package com.mire.cinema.service;


import java.util.List;
import java.util.Map;

import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.member.TokenDTO;

public interface MemberService {
	
	
	
	public void saveMember(Member member);
	public Member findMember(String memberId);
	public int getTotalMember();
	public int getTotalMember(String id);
	public Map<String,Object> getMemberMap(Integer pageNum, String memberId);
	public void modifyMember(MemberDTO.Update dto);
	public void removeMember(String memberId);
	public TokenDTO loginMember(MemberDTO.Login memberLoginDTO);
}
