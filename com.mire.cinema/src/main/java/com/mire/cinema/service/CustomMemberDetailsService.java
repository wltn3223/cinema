package com.mire.cinema.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.mire.cinema.domain.member.Member;
import com.mire.cinema.repository.MemberMapper;
import com.mire.cinema.security.MemberToken;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
@RequiredArgsConstructor
public class CustomMemberDetailsService implements UserDetailsService {
		
	private final MemberMapper memberMapper;
	 private final PasswordEncoder passwordEncoder;
	
	
	@Override
	public UserDetails loadUserByUsername(String userId) {

		
		Member member = memberMapper.selectMember(userId);
		

		
		return createUserDetails(member);
				
		
	}
	
	 private UserDetails createUserDetails(Member member) {
		 return new MemberToken(member,passwordEncoder);
	    }
}
