package com.mire.cinema.domain.pay;

import lombok.Data;

@Data
public class payInfo {
	private String pg;
    private String pay_method;
    private String name;
    private int amount;
    private String buyer_email;
    private String buyer_name;
    private String buyer_tel; 
}	
