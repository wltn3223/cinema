package com.mire.cinema.service;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberLoginDTO;
import com.mire.cinema.domain.member.MemberUpdateDTO;
import com.mire.cinema.domain.member.TokenDTO;
import com.mire.cinema.repository.MemberMapper;
import com.mire.cinema.security.JwtTokenProvider;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;
	private final AuthenticationManagerBuilder authenticationManagerBuilder;
	private final JwtTokenProvider jwtTokenProvider;

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
		if (member == null || !member.getMemberPasswd().equals(dto.getMemberPasswd())) {
			new IllegalArgumentException("아이디와 비밀번호가 일치하지 않습니다.");
			return;

		}

		if (dto.getMemberEmail() == null) {
			dto.setMemberEmail(member.getMemberEmail());
		}
		if (dto.getMemberPhone() == null) {
			dto.setMemberPhone(member.getMemberPhone());
		}

		memberMapper.updateMember(member);

	}

	@Override
	public void removeMember(String memberId) {

		memberMapper.deleteMember(memberId);

	}

	@Override
	public TokenDTO loginMember(MemberLoginDTO dto) {
		System.out.println(dto);
		UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(dto.getMemberId(), dto.getMemberPasswd());
		
		Authentication authentication = authenticationManagerBuilder.getObject().authenticate(authenticationToken);
		
		TokenDTO tokenDTO = jwtTokenProvider.createToken(authentication);
	
		
		
		return tokenDTO;
		
	}

}
