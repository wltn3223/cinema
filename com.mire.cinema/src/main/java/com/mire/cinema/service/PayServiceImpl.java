package com.mire.cinema.service;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.mire.cinema.domain.order.Order;
import com.mire.cinema.domain.order.OrderStatus;
import com.mire.cinema.domain.pay.PayDTO;
import com.mire.cinema.domain.pay.PayDTO.ReserveInfo;
import com.mire.cinema.domain.reserve.Reserve;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.MovieScheduleMapper;
import com.mire.cinema.repository.OrderMapper;
import com.mire.cinema.repository.ReserveMapper;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.Payment;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
@RequiredArgsConstructor
public class PayServiceImpl implements PayService {
	private final OrderMapper orderMapper;
	private final ReserveMapper reserveMapper;
	private final MovieScheduleMapper movieScheduleMapper;
	
	@Value("${impKey}")
	private String impKey;

	@Value("${secretKey}")
	private String secretKey;
	
	@Override
	public void updateStatus(String orderId) {
		orderMapper.updateStatus(orderId, OrderStatus.CANCLE);
		
	}
	

	@Override 
	public void verifyOrder(PayDTO.Info imp_uid) throws IamportResponseException, IOException {
		log.info(impKey.toString());
		log.info(secretKey.toString());
		
		IamportClient api =  new IamportClient(impKey, secretKey);
		Payment payInfo = api.paymentByImpUid(imp_uid.getImp_uid()).getResponse();
		String orderId = imp_uid.getMerchant_uid();
		
		
		Order order = orderMapper.selectOrderById(orderId);
		System.out.println("주문정보:" + order);
		log.info("가격" + payInfo.getAmount().intValue());
		log.info("구매자이름:" + payInfo.getBuyerName());
		log.info("아이디비교:" + orderId +"아이디2:" + payInfo.getMerchantUid());
	
	
		if(payInfo.getAmount().intValue() != order.getDiscountPrice() || !payInfo.getBuyerName().equals(order.getMemberId())
			||	!payInfo.getMerchantUid().equals(orderId)) {
			orderMapper.updateStatus(orderId, OrderStatus.FAIL);
			String accessToken = getToken();
			log.info("토큰발급:" +  accessToken.toString());
			refund(accessToken,payInfo.getMerchantUid());
			throw new IllegalArgumentException(ErrorMsg.BADPAYINFO);
		} 
		
		
		orderMapper.updateStatus(orderId, OrderStatus.COMPLETE);
	}


	@Override
	public void refund(String token, String merchant_uid) throws IOException {
		URL url = new URL("https://api.iamport.kr/payments/cancel");
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        
        conn.setRequestMethod("POST");
        
        // 요청의 Content-Type, Accept, Authorization 헤더 설정
        conn.setRequestProperty("Content-type", "application/json");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("Authorization", token);
        
        // 해당 연결을 출력 스트림(요청)으로 사용
        conn.setDoOutput(true);
 
        // JSON 객체에 해당 API가 필요로하는 데이터 추가.
        JsonObject json = new JsonObject();
        json.addProperty("merchant_uid", merchant_uid);
        json.addProperty("reason", "정보 불일치");
        
        // 출력 스트림으로 해당 conn에 요청
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
        bw.write(json.toString());
        bw.flush();
        bw.close();
 
        // 입력 스트림으로 conn 요청에 대한 응답 반환
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        br.close();
        conn.disconnect();
 
        log.info("결제 취소 완료 : 주문 번호 {}", merchant_uid);
		
	}


	
	@Override
	public String getToken() throws IOException {
		  URL url = new URL("https://api.iamport.kr/users/getToken");
		  HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
		  
		  conn.setRequestMethod("POST");
		  
		  conn.setRequestProperty("Content-Type", "application/json");
	        conn.setRequestProperty("Accept", "application/json");
	        
	        conn.setDoOutput(true);
	        
	        JsonObject json = new JsonObject();
	        json.addProperty("imp_key", impKey);
	        json.addProperty("imp_secret", secretKey);
	        
	     // 출력 스트림으로 해당 conn에 요청
	        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	        bw.write(json.toString()); // json 객체를 문자열 형태로 HTTP 요청 본문에 추가
	        bw.flush(); // BufferedWriter 비우기
	        bw.close(); // BufferedWriter 종료
	 
	        // 입력 스트림으로 conn 요청에 대한 응답 반환
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        Gson gson = new Gson(); // 응답 데이터를 자바 객체로 변환
	        log.info("응답데이터: " + gson.toString());
	        String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();
	        String accessToken = gson.fromJson(response, Map.class).get("access_token").toString();
	        br.close(); // BufferedReader 종료
	        conn.disconnect(); // 연결 종료
	        
	        log.info("Iamport 엑세스 토큰 발급 성공 : {}" + accessToken);
	        return accessToken;
	}


	@Override
	public void verifyReserve(ReserveInfo imp_uid) throws IamportResponseException, IOException {
		log.info(impKey.toString());
		log.info(secretKey.toString());
		
		IamportClient api =  new IamportClient(impKey, secretKey);
		Payment payInfo = api.paymentByImpUid(imp_uid.getImp_uid()).getResponse();
		String orderId = imp_uid.getMerchant_uid();
	
		
	
	
		if(payInfo.getAmount().intValue() != 10000 || !payInfo.getBuyerName().equals(imp_uid.getMemberId())
			||	!payInfo.getMerchantUid().equals(orderId)) {
			String accessToken = getToken();
			log.info("토큰발급:" +  accessToken.toString());
			refundReserve(accessToken, orderId);
			throw new IllegalArgumentException(ErrorMsg.BADPAYINFO);
		} 
		
		reserve(imp_uid);
		
		
	}
	public void reserve(ReserveInfo info) {
		Reserve reserve = Reserve.builder()
				.seatNo(info.getSeatNo())
				.orderId(info.getMerchant_uid())
				.reservePrice(10000)
				.memberId(info.getMemberId())
				.scheduleNo(info.getScheduleNo())
				.build();
		reserveMapper.insertReserve(reserve);
		
		movieScheduleMapper.updateSeat(-1, reserve.getScheduleNo());
		
	}


	@Override
	public void refundReserve(String token, String orderId) throws IOException {
		URL url = new URL("https://api.iamport.kr/payments/cancel");
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        
        conn.setRequestMethod("POST");
        
        // 요청의 Content-Type, Accept, Authorization 헤더 설정
        conn.setRequestProperty("Content-type", "application/json");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("Authorization", token);
        
        // 해당 연결을 출력 스트림(요청)으로 사용
        conn.setDoOutput(true);
 
        // JSON 객체에 해당 API가 필요로하는 데이터 추가.
        JsonObject json = new JsonObject();
        json.addProperty("merchant_uid", orderId);
        json.addProperty("reason", "정보 불일치");
        
        // 출력 스트림으로 해당 conn에 요청
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
        bw.write(json.toString());
        bw.flush();
        bw.close();
 
        // 입력 스트림으로 conn 요청에 대한 응답 반환
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        br.close();
        conn.disconnect();
    	Reserve reserve = reserveMapper.getReserve(orderId);
    	log.info("예약정보:" + reserve.toString());
        movieScheduleMapper.updateSeat(1, reserve.getScheduleNo()); 
        
        
        log.info("결제 취소 완료 : 주문 번호 {}", orderId);
        
		
	}
	
	

}
