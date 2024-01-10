package com.mire.cinema.domain.member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class TokenDTO {

    private String grantType;
    private String accessToken;
    private String refreshToken;


}
