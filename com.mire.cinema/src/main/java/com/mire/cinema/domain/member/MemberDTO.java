package com.mire.cinema.domain.member;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

public class MemberDTO {

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Join {
		@NotBlank(message = "아이디를 입력하세요")
		private String memberId;
		@NotBlank(message = "비밀번호를 입력하세요")
		private String memberPasswd;
		@NotBlank(message = "회원이름을 입력하세요")
		private String memberName;
		@NotBlank(message = "이메일을 입력하세요")
		private String memberEmail;
		@NotBlank(message = "휴대폰 번호를 입력하세요")
		private String memberPhone;
	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	@ToString
	public static class Login {
		@NotBlank(message = "아이디를 입력하세요")
		private String memberId;
		@NotBlank(message = "비밀번호를 입력하세요")
		private String memberPasswd;

	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Update {

		private String memberId;
		@NotBlank(message = "비밀번호를 입력하세요")
		private String memberPasswd;
		@NotBlank(message = "회원이름을 입력하세요")
		private String memberName;
		@NotBlank(message = "이메일을 입력하세요")
		private String memberEmail;
		@NotBlank(message = "휴대폰 번호를 입력하세요")
		private String memberPhone;
	}
	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Info {
		private String memberId;
		private String memberName;
		private String memberEmail;
		private String memberPhone;
		private DiscountGrade memberGrade;
		private String memberDate;
	}

}
