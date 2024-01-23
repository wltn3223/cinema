package com.mire.cinema.domain.review;

import java.time.LocalDate;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

public class ReviewDTO {

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class ReviewWriteDTO {
		private Long reviewNo;
		private Integer reviewScore;
		@NotBlank(message = "제목을 입력하세요")
		private String reviewTitle;
		@NotBlank(message = "내용을 입력하세요")
		private String reviewContent;
		private Integer reviewViews;
		private LocalDate reviewDate;
		private Long movieNo;

	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class ReviewUpdate {
		private Long reviewNo;
		private Integer reviewScore;
		private String reviewTitle;
		private String reviewContent;


	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class ReviewDelete {
		private Long reviewNo;
	}

	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class ReviewInfo {
		private Long reviewNo;
		private Integer reviewScore;
		private String reviewTitle;
		private String reviewContent;
		private LocalDate reviewDate;
		private Integer reviewViews;
		private Long movieNo;
		


	}

	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Search {
		private String reviewTitle;
		private int startNum;
		private int endNum;
	}
	
}
