package com.mire.cinema.domain.member;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberJoinDTO {
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
