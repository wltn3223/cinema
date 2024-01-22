package com.mire.cinema.domain.pay;

import lombok.Data;
import lombok.ToString;

public class PayDTO {
	
	@Data
	@ToString
	public static class Info{
		private String imp_uid;
		private String merchant_uid;
	}
	@Data
	@ToString
	public static class ReserveInfo{
		private String imp_uid;
		private String merchant_uid;
		private long scheduleNo;
		private String memberId;
		private int seatNo;
	}
}
