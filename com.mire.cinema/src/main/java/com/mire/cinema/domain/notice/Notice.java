package com.mire.cinema.domain.notice;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
@Builder
public class Notice {
	private Long boardNo;
	private String boardTitle;
	private String boardContent;
	private String boardType = "notice";
	private Integer boardViews;
	private LocalDate boardDate;
	private String imageUuid;
}
