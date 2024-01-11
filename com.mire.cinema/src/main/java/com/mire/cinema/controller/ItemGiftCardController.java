
package com.mire.cinema.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mire.cinema.domain.itemgiftcard.ItemGiftCard;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCardDTO;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.ItemGiftCardService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/item")
@RequiredArgsConstructor
public class ItemGiftCardController {

	private final ItemGiftCardService itemGiftCardService;

	@PostMapping()
	public ResponseEntity<String> saveMember(@Valid @RequestBody ItemGiftCardDTO itemGiftCardDTO,
			BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return new ResponseEntity<>(bindingResult.getAllErrors().get(0).getDefaultMessage(),
					HttpStatus.BAD_REQUEST);
		}

		ItemGiftCard itemGiftCard = ItemGiftCard.builder().itemName(itemGiftCardDTO.getItemName())
				.itemType(itemGiftCardDTO.getItemType()).itemPrice(itemGiftCardDTO.getItemPrice())
				.itemSize(itemGiftCardDTO.getItemSize()).itemInfo(itemGiftCardDTO.getItemInfo()).build();

		itemGiftCardService.saveItemGiftCard(itemGiftCard);
		
		return new ResponseEntity<>("상품등록이 완료되었습니다.", HttpStatus.OK);
	}

	@GetMapping("/{itemName}")
	public ResponseEntity<ItemGiftCard> findItemGiftCard(@PathVariable String itemName) {
		ItemGiftCard foundItemGiftCard = itemGiftCardService.findItemGiftCard(itemName);
		return ResponseEntity.ok(foundItemGiftCard);
	}

	@PutMapping
	public ResponseEntity<Void> modifyItemGiftCard(@RequestBody ItemGiftCard item) {
		itemGiftCardService.modifyItemGiftCard(item);
		return ResponseEntity.ok().build();
	}

	@DeleteMapping("/{itemName}")
	public ResponseEntity<Void> removeItemGiftCard(@PathVariable String itemName) {
		itemGiftCardService.removeItemGiftCard(itemName);
		return ResponseEntity.ok().build();
	}
	
	
	@GetMapping("/list")
	public ResponseEntity<List<ItemGiftCard>> itemGiftCardList() {
	    List<ItemGiftCard> itemList = itemGiftCardService.selectAllItemGiftCard();
	    return new ResponseEntity<>(itemList, SucessMsg.statusOK);
	}

   
}
