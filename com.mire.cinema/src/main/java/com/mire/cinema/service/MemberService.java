package com.mire.cinema.service;


import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberLoginDTO;
import com.mire.cinema.domain.member.MemberUpdateDTO;
import com.mire.cinema.domain.member.TokenDTO;

public interface MemberService {
	
	
	
	public void saveMember(Member member);
	public Member findMember(String memberId);
	public void modifyMember(MemberUpdateDTO dto);
	public void removeMember(String memberId);
	public TokenDTO loginMember(MemberLoginDTO memberLoginDTO);
}
