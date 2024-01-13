package com.mire.cinema.domain.notice;

import java.time.LocalDate;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

public class NoticeDTO {

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class NoticeResponseDTO {
		private boolean result;
		private String message;
	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class NoticeWriteDTO {
		private Long boardNo;
		@NotBlank(message = "제목을 입력하세요")
		private String boardTitle;
		@NotBlank(message = "공지사항을 입력하세요")
		private String boardContent;
		private String boardType = "notice";
		private Integer boardViews;
		private LocalDate boardDate;
		private String imageUuid;
	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class NoticeUpdate {
		private Long boadNo;
		@NotBlank(message = "제목을 입력하세요")
		private String boardTitle;
		@NotBlank(message = "공지사항을 입력하세요")
		private String boardContent;
	}
	
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Delete {
		private Long boadNo;
	}

}
