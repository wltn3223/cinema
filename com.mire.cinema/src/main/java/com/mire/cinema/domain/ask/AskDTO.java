package com.mire.cinema.domain.ask;

import java.time.LocalDate;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

public class AskDTO {

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class AskResponseDTO {
		private boolean result;
		private String message;
	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class AskWriteDTO {
		private Long askNo;
		@NotBlank(message = "제목을 입력하세요")
		private String askTitle;
		@NotBlank(message = "문의사항을 입력하세요")
		private String askContent;
		private LocalDate askDate;
		private String imageUuid;
		private String memberId;
	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class AskUpdate {
		private Long askNo;
		@NotBlank(message = "제목을 입력하세요")
		private String askTitle;
		@NotBlank(message = "문의사항을 입력하세요")
		private String askContent;
	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Delete {
		private Long askNo;
	}

}
