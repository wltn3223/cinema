package com.mire.cinema.domain.itemgiftcard;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
@AllArgsConstructor
@Builder
public class ItemGiftCard {
	 	private Long itemNo;
	    private String itemName;
		private String itemType;
		private Integer itemPrice;
		private String itemSize;
		private String itemInfo;
		
}