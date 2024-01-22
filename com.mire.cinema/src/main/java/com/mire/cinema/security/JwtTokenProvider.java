package com.mire.cinema.security;

import java.security.Key;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import com.mire.cinema.domain.member.TokenDTO;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Component
public class JwtTokenProvider {

	private final Key key;
	
	private Claims claim;
	
	public JwtTokenProvider(@Value("${secret}") String secretKey) {
		 byte[] keyBytes = Decoders.BASE64.decode(secretKey);  // properties의 key 복호화
		 this.key = Keys.hmacShaKeyFor(keyBytes); // hmac알고리즘 기반의 시크릿 키 생성
	}
	public TokenDTO createToken(Authentication authentication) {
		
		// 사용자가 가진 권한 리스트들을 수집후 합침
		String authorities = authentication.getAuthorities().stream()
				.map(auth -> ((GrantedAuthority)auth).getAuthority())
				.collect(Collectors.joining(","));
		
		long now = (new Date()).getTime(); // 토큰 생성 시간을 가져옴
		
		Date accessTokenExpireTimeDate = new Date(now + (1*60*60*1000));
		
		
		String accessTokenString = Jwts.builder()
				.setSubject(authentication.getName())  // 토큰을 식별하는 토큰이름 사용자 id
				.claim("auth", authorities) // 사용자의 권한들
				.setExpiration(accessTokenExpireTimeDate) // 토큰의 유효기간 설정 
				.signWith(key,SignatureAlgorithm.HS256) // 토큰의 비밀키를 h256알고리즘기반으로 암호화
				.compact();
		
		
	    return TokenDTO.builder()
	            .grantType("Bearer")
	            .accessToken(accessTokenString)
	            .build();
	}
	
	public Date expirationDate() {
		Date exDate = null;
		
		if(claim != null) {
			exDate = claim.getExpiration();
		}
		return exDate;
		
	} 
	public Authentication getAutentication(String accessToken) {
		
		Claims claims = parseClaims(accessToken); // 액세스토큰을 복호화
		
		
		if (claims.get("auth") == null) {
			 throw new RuntimeException("권한 정보가 없는 토큰입니다.");
			
		}
		this.claim = claims;
		// 클레임에서 권한 정보 가져오기(클레임은 ,로 권한을 모두 섞어놨으니 다시 ,로 분리해야함)
		// 권한 정보들을 하나씩 가져와 사용자 권한을 생성하고 수집해서 리스트로 변환
		Collection<? extends GrantedAuthority> authorities =
				Arrays
				.stream(claims.get("auth").toString().split(","))
				.map(role -> new SimpleGrantedAuthority(role))
				.collect(Collectors.toList());
		
		// userDetails 토큰을 복호화후 유저 id passwd 권한을 이용해 Authentication 리턴
		// passwd는 제공하지않음, 토큰을 이미 암호화해서 발급하기때문에 토큰에는 id만 넣고 사용
		UserDetails infoDetails = new User(claims.getSubject(), "", authorities);
		
		return new UsernamePasswordAuthenticationToken(infoDetails,"",authorities);
	
				
				
	}
	// 토큰 유효성 검증
	 public boolean validateToken(String token) {
	        try {
	            Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token);
	            return true;
	        } catch (io.jsonwebtoken.security.SecurityException | MalformedJwtException e) {
	            log.info("유효하지 않은 토큰입니다.", e);
	        } catch (ExpiredJwtException e) {
	        	
	            log.info("기간이 만료된 토큰입니다.", e);
	        } catch (UnsupportedJwtException e) {
	            log.info("지원하지 않는 토큰입니다.", e);
	        } catch (IllegalArgumentException e) {
	            log.info("토큰이 비어있습니다.", e);
	        }
	        return false;
	    }
	
	 private Claims parseClaims(String accessToken) {
	        try {
	        	// accessToken 키와 내 키를 검증하고 유효하면 claim을 반환
	            return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(accessToken).getBody();
	        } catch (ExpiredJwtException e) {
	        	// 유효기간이 지나면 예외발생
	        	return e.getClaims();
	        }
	    }
}
