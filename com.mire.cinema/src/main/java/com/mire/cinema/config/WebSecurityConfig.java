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
           .requestMatchers("/pay/**").authenticated()
           .requestMatchers("/member/memberInfo.jsp").authenticated()
           .requestMatchers("/review/reviewwrite.jsp").authenticated()
           .requestMatchers("/notice/noticemodify.jsp").hasRole("ADMIN")
           .requestMatchers("/notice/noticewrite.jsp").hasRole("ADMIN")
           .requestMatchers("/notice/deletenotice.jsp").hasRole("ADMIN")
           .requestMatchers("/member/myOrderList.jsp").hasRole("USER")
           .requestMatchers("/member/myReserveList.jsp").hasRole("USER")
           .requestMatchers("/").permitAll()
           .requestMatchers("/index.jsp").permitAll()
           .requestMatchers("/login.html").permitAll()
           .requestMatchers("/WEB-INF/header.jsp").permitAll()
           .requestMatchers("/WEB-INF/footer.jsp").permitAll()
           .requestMatchers("/WEB-INF/main.jsp").permitAll()
           .requestMatchers("/member/login").permitAll()
           .requestMatchers("/join.html").permitAll()
           .requestMatchers(HttpMethod.GET ,"/member/*").permitAll()
           .requestMatchers(HttpMethod.POST,"/member").permitAll()
           .requestMatchers("/upload/**").permitAll()
           .requestMatchers("/image/**").permitAll()
           .requestMatchers("/movie/list/**").permitAll()
           .requestMatchers("/movie/movieList.jsp").permitAll()
           .requestMatchers("movieInfo.jsp").permitAll()
           .requestMatchers(HttpMethod.GET,"/movie/**").permitAll()
           .requestMatchers(HttpMethod.GET,"/review/list/**").permitAll()
           .requestMatchers(HttpMethod.GET,"/review/info/**").permitAll()
           .requestMatchers(HttpMethod.GET,"/movieschedule/getMovieSchedule/**").permitAll()
           .requestMatchers(HttpMethod.GET,"/movieschedule/MovieInfo/**").permitAll()
           .requestMatchers("/movieschedule/schedule.jsp").permitAll()
           .requestMatchers("/movieschedule/schedule.jsp").permitAll()
           .requestMatchers("/itemgiftcard/useritemlist.jsp").permitAll()
           .requestMatchers("/item/list/**").permitAll()
           .requestMatchers("/item/info/**").permitAll()
           .requestMatchers("/itemgiftcard/**").permitAll()
           .requestMatchers("/itemgiftcard/#tab01").permitAll()
           .requestMatchers(HttpMethod.GET,"/notice/**").permitAll()
           .anyRequest().authenticated();

           

        })
       .addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider), UsernamePasswordAuthenticationFilter.class);
//         .addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider), UsernamePasswordAuthenticationFilter.class);
      
      
      return http.build();
      
   
   }
   @Bean
   public PasswordEncoder passwordEncoder() {
      return PasswordEncoderFactories.createDelegatingPasswordEncoder();
   }
}