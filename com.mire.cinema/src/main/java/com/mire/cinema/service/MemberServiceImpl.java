package com.mire.cinema.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.member.MemberDTO.search;
import com.mire.cinema.domain.member.TokenDTO;
import com.mire.cinema.domain.page.Page;
import com.mire.cinema.domain.page.PageCreate;
import com.mire.cinema.exception.ErrorMsg;
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

		Member member = memberMapper.selectMember(memberId);

		return member;
	}

	@Override
	public void modifyMember(MemberDTO.Update dto) {
		Member member = memberMapper.selectMember(dto.getMemberId());

		if (member == null || !member.getMemberPasswd().equals(dto.getMemberPasswd())) {
			
			throw new IllegalArgumentException(ErrorMsg.USERINFO);

		}

		memberMapper.updateMember(dto);

	}

	@Override
	public void removeMember(String memberId) {

		Member member = findMember(memberId);

		if (member == null) {
			System.out.println("예외호출");
			throw new IllegalArgumentException(ErrorMsg.USERINFO);
		}

		memberMapper.deleteMember(memberId);

	}

	@Override
	public TokenDTO loginMember(MemberDTO.Login dto) {
		Member member = memberMapper.selectMember(dto.getMemberId());

		if (member == null || !member.getMemberPasswd().equals(dto.getMemberPasswd())) {
			log.info("member" + member.getMemberId() + " " + member.getMemberPasswd());
			throw new IllegalArgumentException(ErrorMsg.USERINFO);

		}

		UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
				dto.getMemberId(), dto.getMemberPasswd());

		Authentication authentication = authenticationManagerBuilder.getObject().authenticate(authenticationToken);

		TokenDTO tokenDTO = jwtTokenProvider.createToken(authentication);

		return tokenDTO;

	}

	@Override
	public int getTotalMember() {
		int num = memberMapper.countMember();
		if(num == 0) {
			throw new NullPointerException(ErrorMsg.DataNOTFOUND);
		}
		
		
		return num;
	}
	@Override
	public int getTotalMember(String id) {
		

		
		
		return 	memberMapper.countsearchMember(id);
	}

	@Override
	public Map<String,Object> getMemberMap(Integer pageNum, String memberId) {
		Map<String, Object> map = new HashMap<>();
		if(pageNum == null) {
			throw new IllegalArgumentException(ErrorMsg.BADTYPE);
		}
		PageCreate pc = new PageCreate();
		
		
		if(memberId == null || "".equals(memberId.trim())) {
			pc = getPage(pageNum, getTotalMember());
			map.put("list",memberMapper.getPartList(pc.getPaging().getStartNum(), pc.getPaging().getEndNum()));
		}
		else {
			pc = getPage(pageNum, getTotalMember(memberId));
			MemberDTO.search dto = new search();
			dto.setMemberId(memberId);
			dto.setStartNum(pc.getPaging().getStartNum());
			dto.setEndNum(pc.getPaging().getEndNum());
			map.put("keyword", memberId);
			map.put("searchList",memberMapper.searchPartList(dto));
		}	
		
		map.put("page", pc);
		
	 
		
		return map;
	}
	public PageCreate getPage(int pageNum, int totalCount) {
		Page page = new Page();
		page.setPageNum(pageNum, 5);  // 현재 페이지와 페이지 몇개 보여줄지 설정
		
		PageCreate pc = new PageCreate();
		pc.setPaging(page);
		pc.setArticleTotalCount(totalCount);
		
		return pc;
	}

}
