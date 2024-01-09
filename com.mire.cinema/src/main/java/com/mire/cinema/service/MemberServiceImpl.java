package com.mire.cinema.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.member.LoginResponseDTO;
import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberLoginDTO;
import com.mire.cinema.domain.member.MemberUpdateDTO;
import com.mire.cinema.repository.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;

	@Override
	public void saveMember(Member member) {
		memberMapper.insertMember(member);

	}

	@Override
	public Member findMember(String memberId) {
	
		return memberMapper.selectMember(memberId);
	}

	@Override
	public void modifyMember(MemberUpdateDTO dto) {
		Member member = memberMapper.selectMember(dto.getMemberId());
		if(member == null || !member.getMemberPasswd().equals(dto.getMemberPasswd())) {
			new IllegalArgumentException("아이디와 비밀번호가 일치하지 않습니다.");
			return;
			
		}
		
		if(dto.getMemberEmail() == null) {
			dto.setMemberEmail(member.getMemberEmail());
		}
		if(dto.getMemberPhone() == null) {
			dto.setMemberPhone(member.getMemberPhone());
		}
		
		
		memberMapper.updateMember(member);

	}

	@Override
	public void removeMember(String memberId) {
		
		memberMapper.deleteMember(memberId);

	}
	@Override
	public LoginResponseDTO loginMember(MemberLoginDTO memberLoginDTO) {
		
		Member member = memberMapper.selectMember(memberLoginDTO.getMemberId());
		
		if(member == null) {
			return new LoginResponseDTO(false, "아이디를 잘못 입력하셨습니다..");
		}
		
		if(!memberLoginDTO.getMemberPasswd().equals(member.getMemberPasswd())) {
			return new LoginResponseDTO(false, "비밀번호를 잘못 입력하셨습니다..");
		}
		
		
		return new LoginResponseDTO(true, "로그인 성공");
		
	}

}
