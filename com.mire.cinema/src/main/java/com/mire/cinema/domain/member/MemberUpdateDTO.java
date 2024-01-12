package com.mire.cinema.domain.member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberUpdateDTO {
 	private String memberId;

    private String memberPasswd;
	
	private String memberEmail;
	
	private String memberPhone;
}
