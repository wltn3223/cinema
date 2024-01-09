package com.mire.cinema.domain.member;

import com.mire.cinema.domain.DiscountGrade;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
@AllArgsConstructor
@Builder
public class Member {
    private Long memberNo;
    private String memberId;
    private String memberPasswd;
	private String memberName;
	private String memberEmail;
	private String memberPhone;
	private DiscountGrade memberGrade;
	private String memberDate;
	
   
}