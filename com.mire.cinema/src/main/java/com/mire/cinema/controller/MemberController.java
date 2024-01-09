package com.mire.cinema.controller;

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

import com.mire.cinema.domain.DiscountGrade;
import com.mire.cinema.domain.member.LoginResponseDTO;
import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberJoinDTO;
import com.mire.cinema.domain.member.MemberLoginDTO;
import com.mire.cinema.response.SucessMessage;
import com.mire.cinema.service.MemberService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
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
	        .memberGrade(DiscountGrade.SILVER).build();

	    	
	        memberService.saveMember(member);
	        return new ResponseEntity<>(SucessMessage.INSERT, SucessMessage.statusOK);
	    }

	    @GetMapping("/{memberId}")
	    public ResponseEntity<Member> findMember(@PathVariable String memberId) {
	        Member foundMember = memberService.findMember(memberId);
	        
	        return ResponseEntity.ok(foundMember);
	    
	    }
	    
	    @PostMapping("/logout")
	    public ResponseEntity<Void> logout(HttpSession session) {
	        session.invalidate();
	        return ResponseEntity.ok().build();
	    }
	    
	    @PostMapping("/login")
	    public ResponseEntity<String> checkMember(@Valid @RequestBody MemberLoginDTO memberLoginDTO, HttpSession session) {
	    	
	    	LoginResponseDTO response =  memberService.loginMember(memberLoginDTO);
	    	
	    	if (!response.isResult()) {
	    		return new ResponseEntity<>(response.getMessage(), HttpStatus.BAD_REQUEST);
	    	}
	    	session.setAttribute("memberId", memberLoginDTO.getMemberId());
	    	
	    	return new ResponseEntity<>(SucessMessage.LOGIN, SucessMessage.statusOK);
	    }

	    @PutMapping
	    public ResponseEntity<String> modifyMember(@RequestBody Member member) {
	        memberService.modifyMember(member);
	        return new ResponseEntity<>(SucessMessage.UPDATE,  SucessMessage.statusOK);
	    }

	    @DeleteMapping("/{memberId}")
	    public ResponseEntity<String> removeMember(@PathVariable String memberId) {
	        memberService.removeMember(memberId);
	        return new ResponseEntity<>(SucessMessage.DELETE,  SucessMessage.statusOK);
	    }
	   
	

}
