package com.mire.cinema.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mire.cinema.domain.member.DiscountGrade;
import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberJoinDTO;
import com.mire.cinema.domain.member.MemberLoginDTO;
import com.mire.cinema.domain.member.MemberUpdateDTO;
import com.mire.cinema.domain.member.Role;
import com.mire.cinema.domain.member.TokenDTO;
import com.mire.cinema.response.SucessMessage;
import com.mire.cinema.service.MemberService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RestController
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {
	
	    private final MemberService memberService;

	    @PostMapping
	    public ResponseEntity<String> saveMember(@Valid @RequestBody MemberJoinDTO memberDTO,BindingResult bindingResult) {
	        if(bindingResult.hasErrors()) {
	        	  return new ResponseEntity<>(bindingResult.getAllErrors().get(0).getDefaultMessage(), HttpStatus.BAD_REQUEST);
	        }
	        
	    	
	    	Member member = Member.builder()
	        .memberId(memberDTO.getMemberId())
	        .memberPasswd(memberDTO.getMemberPasswd())
	        .memberName(memberDTO.getMemberName())
	        .memberEmail(memberDTO.getMemberEmail())
	        .memberPhone(memberDTO.getMemberPhone())
	        .memberRole(Role.USER)
	        .memberGrade(DiscountGrade.SILVER).build();

	    	
	        memberService.saveMember(member);
	        return new ResponseEntity<>(SucessMessage.INSERT, SucessMessage.statusOK);
	    }

	    @GetMapping("/{memberId}")
	    public ResponseEntity<String> findMember(@PathVariable String memberId) {
	        Member foundMember = memberService.findMember(memberId);
	        
	        return ResponseEntity.ok(foundMember.getMemberId());
	    
	    }
	    
	    @PostMapping("/logout")
	    public ResponseEntity<Void> logout(HttpSession session) {
	        session.invalidate();
	        HomeController.isLogin = false;
	        return new ResponseEntity<>(SucessMessage.statusOK);
	    }
	    
	    @PostMapping("/login")
	    public ResponseEntity<String>  checkMember(@Valid @RequestBody MemberLoginDTO memberLoginDTO,  HttpServletResponse response, HttpSession session) {
	    	
	    	TokenDTO tokenDTO =  memberService.loginMember(memberLoginDTO);
	    	
	        // 토큰을 HttpOnly 쿠키에 저장하여 클라이언트로 전송
	        Cookie accessTokenCookie = new Cookie("accessToken", tokenDTO.getGrantType() + "_" + tokenDTO.getAccessToken());
	        accessTokenCookie.setHttpOnly(true);
	        accessTokenCookie.setPath("/"); // 쿠키의 유효 경로 설정
	        response.addCookie(accessTokenCookie);
	        
	        session.setAttribute("memberId", memberLoginDTO.getMemberId());
	    	session.setMaxInactiveInterval(59);
	    	
	    	
	    	return new ResponseEntity<>(SucessMessage.LOGIN,  SucessMessage.statusOK);
	    }

	    @PutMapping
	    public ResponseEntity<String> modifyMember(@RequestBody MemberUpdateDTO dto) {
	        
	    	memberService.modifyMember(dto);
	        return new ResponseEntity<>(SucessMessage.UPDATE,  SucessMessage.statusOK);
	    }

	    @DeleteMapping("/{memberId}")
	    public ResponseEntity<String> removeMember(@PathVariable String memberId) {
	        memberService.removeMember(memberId);
	        return new ResponseEntity<>(SucessMessage.DELETE,  SucessMessage.statusOK);
	    }
	    
	    
	    // 페이지를 내려줌
	    @GetMapping("/info/{memberId}")
	    public ModelAndView findMemberInfo(@PathVariable String memberId) {
	        Member foundMember = memberService.findMember(memberId);
	        ModelAndView mv = new ModelAndView("memberInfo");
	        mv.addObject("member",foundMember);
	        return mv;
	    
	    }
	    // 페이지를 내려줌
	    @GetMapping("/editForm/{memberId}")
	    public ModelAndView getEditForm(@PathVariable String memberId) {
	        ModelAndView mv = new ModelAndView("memberEditForm");
	        return mv;
	    
	    }
	   
	

}
