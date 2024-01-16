package com.mire.cinema.domain.movie;

import java.sql.Timestamp;
import java.util.Date;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Past;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

public class MovieDTO {

	@Data
	@Builder
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Save {
		@NotBlank(message = "제출 한 항목중 공백이 있습니다. 다시 시도해주세요.")
		private String movieTitle;
		@NotBlank(message = "제출 한 항목중 공백이 있습니다. 다시 시도해주세요.")
		private String movieIntro;
		@NotBlank(message = "제출 한 항목중 공백이 있습니다. 다시 시도해주세요.")
		private String movieActors;
		@NotBlank(message = "제출 한 항목중 공백이 있습니다. 다시 시도해주세요.")
		private String movieGenre;
		@NotBlank(message = "제출 한 항목중 공백이 있습니다. 다시 시도해주세요.")
		private String moviePlayTime;
		@NotBlank(message = "제출 한 항목중 공백이 있습니다. 다시 시도해주세요.")
		private String movieLimit;
		@Past(message = "입력한 날짜형식이 올바르지않습니다.")
		private Date movieDate;

	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Movies {
		private String movieNo;
		private String movieTitle;
		private String movieLimit;
		private String imageUuid;
		private String movieDate;

	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class update {
			
			private long movieNo;
			@NotBlank(message = "제출 한 항목중 공백이 있습니다. 다시 시도해주세요.")
			private String movieTitle;
			@NotBlank(message = "제출 한 항목중 공백이 있습니다. 다시 시도해주세요.")
			private String movieIntro;
			@NotBlank(message = "제출 한 항목중 공백이 있습니다. 다시 시도해주세요.")
			private String movieActors;
			@NotBlank(message = "제출 한 항목중 공백이 있습니다. 다시 시도해주세요.")
			private String movieGenre;
			@NotBlank(message = "제출 한 항목중 공백이 있습니다. 다시 시도해주세요.")
			private String moviePlayTime;
			@NotBlank(message = "제출 한 항목중 공백이 있습니다. 다시 시도해주세요.")
			private String movieLimit;
			private String imageUuid;
			
	
	}

}
