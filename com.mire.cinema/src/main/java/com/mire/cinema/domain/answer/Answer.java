package com.mire.cinema.domain.answer;

import java.time.LocalDate;

import com.mire.cinema.domain.notice.Notice;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
@Builder
public class Answer {
	private Long ansNo;
	private String ansTitle;
	private String ansContent;
	private Integer ansViews;
	private LocalDate ansDate;
	private Integer ansStatus;
	private String memberId;
	private Long askNo;
	
}
