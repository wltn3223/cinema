package com.mire.cinema.domain.itemgiftcard;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
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
		@NotNull(message = "상품가격을 입력하세요")
	    @Min(value = 0, message = "상품가격은 0 이상이어야 합니다.")
		private Integer itemPrice;
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
		private Integer itemPrice;
		private String itemSize;
		private String itemInfo;
		
	}
	

}
