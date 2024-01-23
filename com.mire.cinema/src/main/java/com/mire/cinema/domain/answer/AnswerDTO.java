package com.mire.cinema.domain.answer;

import java.time.LocalDate;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

public class AnswerDTO {

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class AnswerWriteDTO {
		private Long ansNo;
		@NotBlank(message = "제목을 입력하세요")
		private String ansTitle;
		@NotBlank(message = "내용을 입력하세요")
		private String ansContent;
		private Integer ansViews;
		private LocalDate ansDate;
		private Long askNo;


	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class AnswerUpdate {
		private Long ansNo;
		private String ansTitle;
		private String ansContent;
//		private Integer ansStatus;
	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class AnswerDelete {
		private Long ansNo;
	}

	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class AnswerInfo {
		private Long ansNo;
		private String ansTitle;
		private String ansContent;
		private Integer ansViews;
		private LocalDate ansDate;
		private Integer ansStatus;
		private Long askNo;


	}

	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Search {
		private String ansTitle;
		private int startNum;
		private int endNum;
	}
}