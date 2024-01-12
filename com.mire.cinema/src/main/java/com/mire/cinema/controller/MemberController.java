package com.mire.cinema.controller;

import java.util.Arrays;

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
import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.member.Role;
import com.mire.cinema.domain.member.TokenDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.MemberService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.Builder;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {

	private final MemberService memberService;

	@PostMapping
	public ResponseEntity<String> saveMember(@Valid @RequestBody MemberDTO.Join memberDTO,
			BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return new ResponseEntity<>(bindingResult.getAllErrors().get(0).getDefaultMessage(),
					HttpStatus.BAD_REQUEST);
		}

		Member member = Member.builder().memberId(memberDTO.getMemberId()).memberPasswd(memberDTO.getMemberPasswd())
				.memberName(memberDTO.getMemberName()).memberEmail(memberDTO.getMemberEmail())
				.memberPhone(memberDTO.getMemberPhone()).memberRole(Role.USER).memberGrade(DiscountGrade.SILVER)
				.build();

		memberService.saveMember(member);
		return new ResponseEntity<>(SucessMsg.INSERT, SucessMsg.statusOK);
	}

	@GetMapping("/{memberId}")
	public ResponseEntity<String> findMember(@PathVariable String memberId) {
		Member foundMember = memberService.findMember(memberId);

		if (foundMember == null) {
			throw new NullPointerException(ErrorMsg.USERNOTFOUND);
		}

		return new ResponseEntity<>(foundMember.getMemberId(), SucessMsg.statusOK);

	}

	@PostMapping("/logout")
	public ResponseEntity<Void> logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Arrays.asList(request.getCookies()).stream().filter(cookie -> cookie.getName().equals("accessToken"))
				.findFirst().ifPresent(cookie -> {

					Cookie copyCookie = new Cookie(cookie.getName(), "");
					copyCookie.setDomain(cookie.getDomain());
					copyCookie.setPath("/");
					copyCookie.setMaxAge(1);
					response.addCookie(copyCookie);
				});

		session.invalidate();
		return new ResponseEntity<>(SucessMsg.statusOK);
	}

	@PostMapping("/login")
	public ResponseEntity<String> checkMember(@Valid @RequestBody MemberDTO.Login memberDTO,
			HttpServletResponse response, HttpSession session) {

		TokenDTO tokenDTO = memberService.loginMember(memberDTO);

		// 토큰을 HttpOnly 쿠키에 저장하여 클라이언트로 전송
		Cookie accessTokenCookie = new Cookie("accessToken", tokenDTO.getGrantType() + "_" + tokenDTO.getAccessToken());
		accessTokenCookie.setHttpOnly(true);
		accessTokenCookie.setPath("/"); // 쿠키의 유효 경로 설정
		accessTokenCookie.setSecure(true);
		response.addCookie(accessTokenCookie);

		session.setAttribute("memberId", memberDTO.getMemberId());
		session.setMaxInactiveInterval(59 * 30);

		return new ResponseEntity<>(SucessMsg.LOGIN, SucessMsg.statusOK);
	}

	@PutMapping
	public ResponseEntity<String> modifyMember(@RequestBody MemberDTO.Update dto) {
	
		memberService.modifyMember(dto);
		return new ResponseEntity<>(SucessMsg.UPDATE, SucessMsg.statusOK);
	}

	@DeleteMapping("/{memberId}")
	public ResponseEntity<String> removeMember(@PathVariable String memberId) {
		memberService.removeMember(memberId);
		return new ResponseEntity<>(SucessMsg.DELETE, SucessMsg.statusOK);
	}

	@GetMapping("/info/{memberId}")
	public ResponseEntity<MemberDTO.Info> findMemberInfo(@PathVariable String memberId) {
		Member info = memberService.findMember(memberId);

		if (info == null) {
			throw new IllegalArgumentException(ErrorMsg.USERINFO);
		}
		MemberDTO.Info member = MemberDTO.Info.builder().memberId(info.getMemberId()).memberName(info.getMemberName())
				.memberEmail(info.getMemberEmail()).memberPhone(info.getMemberPhone())
				.memberGrade(info.getMemberGrade()).memberDate(info.getMemberDate()).build();

		return new ResponseEntity<>(member, SucessMsg.statusOK);

	}


}
