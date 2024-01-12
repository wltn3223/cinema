package com.mire.cinema.domain.itemgiftcard;

import com.mire.cinema.domain.member.DiscountGrade;
import com.mire.cinema.domain.member.MemberDTO;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

public class ItemGiftCardDTO {

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Insert {
		@NotBlank(message = "상품명을 입력하세요")
		private String itemName;
		@NotBlank(message = "상품타입을 입력하세요")
		private String itemType;
		@NotBlank(message = "상품가격 입력하세요")
		private String itemPrice;
		@NotBlank(message = "상품사이즈를 입력하세요")
		private String itemSize;
		@NotBlank(message = "상품정보를 입력하세요")
		private String itemInfo;
	}
	
	
	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Info {
		private String itemName;
		private String itemType;
		private String itemPrice;
		private String itemSize;
		private String itemInfo;
		
	}
	

}