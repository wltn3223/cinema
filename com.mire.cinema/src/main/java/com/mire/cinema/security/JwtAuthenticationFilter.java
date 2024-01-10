package com.mire.cinema.security;

import java.io.IOException;


import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import jakarta.servlet.FilterChain;
import jakarta.servlet.GenericFilter;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends GenericFilter{
	
    private final JwtTokenProvider jwtTokenProvider;

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		log.info("필터호출");
		
		String token = resolveToken((HttpServletRequest)request);
	
		
		if(token != null && jwtTokenProvider.validateToken(token)) {
			Authentication authentication = jwtTokenProvider.getAutentication(token);
			authentication.getAuthorities().stream().forEach(d -> System.out.println(d.getAuthority()));
			System.out.println(authentication.getName());
			SecurityContextHolder.getContext().setAuthentication(authentication);
		}
		chain.doFilter(request, response);
		
		
	}
	
	
	
		
	private String resolveToken(HttpServletRequest request) {
	    // Try to retrieve the token from the "accessToken" cookie
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ("accessToken".equals(cookie.getName())) {
	                String bearerToken = cookie.getValue();
	                if (bearerToken != null && !bearerToken.isBlank() && bearerToken.startsWith("Bearer")) {
	                    return bearerToken.substring(7);
	                }
	            }
	        }
	    }

	    // If the token is not found in the cookie, return null
	    return null;
	}

}
