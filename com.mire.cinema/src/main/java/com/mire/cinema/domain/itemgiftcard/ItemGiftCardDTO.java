package com.mire.cinema.domain.itemgiftcard;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ItemGiftCardDTO {
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