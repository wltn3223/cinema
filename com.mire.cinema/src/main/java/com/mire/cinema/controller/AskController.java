package com.mire.cinema.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.mire.cinema.domain.ask.Ask;
import com.mire.cinema.domain.ask.AskDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.AskService;
import com.mire.cinema.service.ImageService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/ask")
@RequiredArgsConstructor
public class AskController {
	private final AskService askService;
	private final ImageService imageService;

	// 문의사항 등록
	@PostMapping
	public ResponseEntity<String> saveAsk(@Valid AskDTO.AskWriteDTO askDTO,@RequestParam(name = "file",required = false) MultipartFile askImage,
			BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return new ResponseEntity<>(bindingResult.getAllErrors().get(0).getDefaultMessage(),
					HttpStatus.BAD_REQUEST);
		}
		
		if(askImage == null) {
			throw new NullPointerException(ErrorMsg.IMAGENOTFOUND);
		}
		String uuidName = imageService.saveImage(askImage);
		
		Ask ask = Ask.builder().askNo(askDTO.getAskNo()).askTitle(askDTO.getAskTitle())
				.askContent(askDTO.getAskContent()).memberId(askDTO.getMemberId()).imageUuid(uuidName).build();

		askService.saveAsk(ask);
		return new ResponseEntity<>(SucessMsg.INSERT, SucessMsg.statusOK);
	}

	// 문의사항 리스트
	@GetMapping("/list")
	public ResponseEntity<List<Ask>> AskList() {
		List<Ask> askList = askService.seeAsk();
		return new ResponseEntity<>(askList,SucessMsg.statusOK);
	}

	// 문의사항 내용보기
	@GetMapping("/{askNo}")
	public ResponseEntity<Ask> findAsk(@PathVariable long askNo) {
		Ask foundAsk = askService.findAsk(askNo);
		return new ResponseEntity<>(foundAsk, SucessMsg.statusOK);
	}
	//문의사항 데이터를 출력
	@GetMapping("/info/{askNo}")
	public ResponseEntity<Ask> findItemInfo(@PathVariable long askNo) {
	    Ask info = askService.findAsk(askNo);
	    Ask ask = Ask.builder()
	    		.askNo(info.getAskNo())
	    		.askTitle(info.getAskTitle())
	    		.askContent(info.getAskContent())
	    		.askDate(info.getAskDate())
	    		.memberId(info.getMemberId())
	            .build();

	    return new ResponseEntity<>(ask, SucessMsg.statusOK);
	}

	
	//문의사항 내용 수정하기
	@PutMapping
	public ResponseEntity<String> modifyAsk(@RequestBody AskDTO.AskUpdate ask) {
		askService.modifyAsk(ask);
		return new ResponseEntity<>(SucessMsg.UPDATE, SucessMsg.statusOK);
	}
	
	//문의사항 삭제하기
	@DeleteMapping("/{askNo}")
	public ResponseEntity<String> removeAsk(@PathVariable Long askNo) {
		askService.removeAsk(askNo);
		return new ResponseEntity<>(SucessMsg.DELETE, SucessMsg.statusOK);
	}

	// 검색기능,페이징기능 
		@GetMapping("/info/{askTitle}")
		public ResponseEntity<AskDTO.Info> findAskInfo(@PathVariable String askTitle) {
			Ask info = askService.findSearchAsk(askTitle);
			if (info == null) {
				throw new IllegalArgumentException(ErrorMsg.AskNOTFOUND);
			}
			AskDTO.Info ask = AskDTO.Info.builder().askNo(info.getAskNo()).askTitle(info.getAskTitle())
					.askContent(info.getAskContent()).askDate(info.getAskDate())
					.build();
			return new ResponseEntity<>(ask, SucessMsg.statusOK);
		}

		@GetMapping("/list/{pageNum}")
		public ResponseEntity<Map<String, Object>> getAskList(@PathVariable Integer pageNum) {
			try {
				return new ResponseEntity<>(askService.getAskMap(pageNum, null), HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}

		@GetMapping("/list/{pageNum}/ask/{askTitle}")
		public ResponseEntity<Map<String, Object>> getAskList(@PathVariable Integer pageNum,@PathVariable String askTitle) {
			return new ResponseEntity<>(askService.getAskMap(pageNum, askTitle), HttpStatus.OK);
		}

}
