package com.mire.cinema.domain.itemgiftcard;

import java.util.List;

import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.movie.MovieDTO;

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
		private Long itemNo;
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
		private String imageUuid;
		private String cinemaName;
	}

	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Info {
		private Long itemNo;
		private String itemName;
		private String itemType;
		private Integer itemPrice;
		private String itemSize;
		private String itemInfo;
		private String imageUuid;
		private String cinemaName;

	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class update {
		private Long itemNo;
		private String itemName;
		private String itemType;
		private Integer itemPrice;
		private String itemSize;
		private String itemInfo;
		private String imageUuid;
		private String cinemaName;

	}
	
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class items {
		private String itemNo;
		private String itemName;
		private String itemSize;
		private String itemPrice;
		private String imageUuid;

	}
	
	@Builder
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class search{
		private String itemName;
		private int startNum;
		private int endNum;
	}

}
