package com.mire.cinema.domain;

import lombok.*;

@Getter
@Setter
@ToString
public class Member {
    private long memberNo;
    private String memberId;
	
    public Member(long memberNo, String memberId) {
		super();
		this.memberNo = memberNo;
		this.memberId = memberId;
		System.out.println(memberNo+memberId);
    }
    

}

