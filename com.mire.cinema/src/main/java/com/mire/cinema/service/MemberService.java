package com.mire.cinema.service;


import com.mire.cinema.domain.member.LoginResponseDTO;
import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberLoginDTO;
import com.mire.cinema.domain.member.MemberUpdateDTO;

public interface MemberService {
	
	
	
	public void saveMember(Member member);
	public Member findMember(String memberId);
	public void modifyMember(MemberUpdateDTO dto);
	public void removeMember(String memberId);
	public LoginResponseDTO loginMember(MemberLoginDTO memberLoginDTO);
}
