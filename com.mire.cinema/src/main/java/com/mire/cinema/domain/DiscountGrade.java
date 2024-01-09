package com.mire.cinema.domain;

import lombok.Getter;

@Getter
public enum DiscountGrade {
	
	 SILVER("Silver", 3),
	 GOLD("Gold", 5);
	
	private final String grade;
	private final double discountRate;
	
	
	  DiscountGrade(String grade, double discountRate) {
	        this.grade = grade;
	        this.discountRate = discountRate;
	       
	    }
	
	
}
