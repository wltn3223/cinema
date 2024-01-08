package com.mire.cinema.domain.member;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberLoginDTO {
		@NotBlank(message = "아이디를 입력하세요")
	 	private String memberId;
		@NotBlank(message = "비밀번호를 입력하세요")
	    private String memberPasswd;
		
}
