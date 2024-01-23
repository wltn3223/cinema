package com.mire.cinema.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.mire.cinema.security.JwtAuthenticationFilter;
import com.mire.cinema.security.JwtTokenProvider;

import lombok.RequiredArgsConstructor;


@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class WebSecurityConfig {
	
	private final JwtTokenProvider jwtTokenProvider;
	
	@SuppressWarnings("deprecation")
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		
		http
        .httpBasic().disable()
        .csrf().disable()
        .formLogin().loginPage("/login.html")
        .and()
        .authorizeRequests(authorizeRequests -> {
        	authorizeRequests
        	.requestMatchers("/member/memberInfo.jsp").authenticated()
        	.requestMatchers("/pay/**").authenticated()
        	.requestMatchers("/index.jsp").permitAll()
        	.requestMatchers("/login.html").permitAll()
        	.requestMatchers("/WEB-INF/header.jsp").permitAll()
        	.requestMatchers("/WEB-INF/footer.jsp").permitAll()
        	.requestMatchers("/member/login").permitAll()
        	.requestMatchers("/join.html").permitAll()
        	.requestMatchers(HttpMethod.GET ,"/member/*").permitAll()
        	.requestMatchers(HttpMethod.POST,"/member").permitAll();
        	
        })
		 .addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider), UsernamePasswordAuthenticationFilter.class);
//		   .addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider), UsernamePasswordAuthenticationFilter.class);
		
		
		return http.build();
		
	
	}
	@Bean
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
}
