package com.mire.cinema.domain.ask;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
@Builder
public class Ask {
	private Long askNo;
	private String askTitle;
    private String askContent;
	private LocalDate askDate;
	private String imageUuid;
	private String memberId;
}

