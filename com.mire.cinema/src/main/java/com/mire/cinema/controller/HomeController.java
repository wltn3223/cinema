package com.mire.cinema.controller;

import java.util.Date;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mire.cinema.security.JwtTokenProvider;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
@Log
@RequiredArgsConstructor
@Controller
public class HomeController {
	
	static boolean isLogin = false;
	private final JwtTokenProvider jwtTokenProvider;
	
	@RequestMapping("/")
	public String home(HttpServletRequest request) {
		
		if(isLogin == false) {
		
			CheckedLogin(request);
		}

		return "redirect:/index.jsp";// template> home.html 으로 보내줌
	}
	
	
	
	
	
	public void CheckedLogin(HttpServletRequest request) {
		isLogin = true;
		
		
		String token = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("accessToken".equals(cookie.getName())) {
					String bearerToken = cookie.getValue();
					if (bearerToken != null && !bearerToken.isBlank() && bearerToken.startsWith("Bearer")) {
						token = bearerToken.substring(7);
					}
				}
			}
		}
		
		if (token != null && jwtTokenProvider.validateToken(token)) {
			Authentication authentication = jwtTokenProvider.getAutentication(token);
			
		
			
			HttpSession session =   request.getSession();
			session.setAttribute("memberId", authentication.getName());
			session.setMaxInactiveInterval(checkTime(jwtTokenProvider.expirationDate()) - 1);
			
			System.out.println(session.getMaxInactiveInterval());
		}
		
	}
	public int checkTime(Date Date) {
		Date now = new Date();
		
		int restTime = (int)((Date.getTime() -  now.getTime())/60000);
		
		return restTime;
	}
}
