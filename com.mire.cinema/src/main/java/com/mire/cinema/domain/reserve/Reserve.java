package com.mire.cinema.domain.reserve;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Builder
@Setter

public class Reserve {
	private long reserveNo;
	private String orderId;
	private long seatNo;
	private int reservePrice;
	private String memberId;
	private long scheduleNo;

}
