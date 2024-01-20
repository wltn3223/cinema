package com.mire.cinema.domain.review;

import java.time.LocalDate;

import com.mire.cinema.domain.answer.Answer;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
@Builder
public class Review {
	private Long reviewNo;
	private Integer reviewScore;
	private String reviewTitle;
	private String reviewContent;
	private LocalDate reviewDate;
	private Integer reviewViews;
	private String movieTitle;
	private String memberId;
	

}
