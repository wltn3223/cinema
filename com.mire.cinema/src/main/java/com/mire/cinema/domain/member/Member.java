package com.mire.cinema.domain.member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@AllArgsConstructor
@Builder
@NoArgsConstructor

public class Member {
    private Long memberNo;
    private String memberId;
    private String memberPasswd;
	private String memberName;
	private String memberEmail;
	private String memberPhone;
	private String memberRole;
	private DiscountGrade memberGrade;
	private String memberDate;
	
   
}