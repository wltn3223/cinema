package com.mire.cinema.service;


import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.member.TokenDTO;

public interface MemberService {
	
	
	
	public void saveMember(Member member);
	public Member findMember(String memberId);
	public void modifyMember(MemberDTO.Update dto);
	public void removeMember(String memberId);
	public TokenDTO loginMember(MemberDTO.Login memberLoginDTO);
}
