package com.mire.cinema.domain.member;

import lombok.AllArgsConstructor;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class LoginResponseDTO {
	private boolean result;
	private String message;
}
