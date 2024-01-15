
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.mire.cinema.domain.itemgiftcard.ItemGiftCard;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCardDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.ImageService;
import com.mire.cinema.service.ItemGiftCardService;

import io.jsonwebtoken.io.IOException;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.Value;
import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/item")
@RequiredArgsConstructor
public class ItemGiftCardController {

	private final ItemGiftCardService itemGiftCardService;
	private final ImageService imageService;

	@PostMapping
	public ResponseEntity<String> saveItemGiftCard(@Valid ItemGiftCardDTO.Insert insert,
			@RequestParam("itemImage") MultipartFile itemImage, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return new ResponseEntity<>(bindingResult.getAllErrors().get(0).getDefaultMessage(),
					HttpStatus.BAD_REQUEST);
		}
		if(itemImage == null) {
			throw new NullPointerException(ErrorMsg.IMAGENOTFOUND);
		}
		String imageUuid = imageService.saveImage(itemImage);


		// ItemGiftCard 객체 생성
		ItemGiftCard itemGiftCard = ItemGiftCard.builder().itemName(insert.getItemName()).itemType(insert.getItemType())
				.itemPrice(insert.getItemPrice()).itemSize(insert.getItemSize()).itemInfo(insert.getItemInfo())
				.imageUuid(imageUuid).cinemaNo(insert.getCinemaNo()).build();

		// 서비스를 통해 ItemGiftCard 저장
		itemGiftCardService.saveItemGiftCard(itemGiftCard);

		return new ResponseEntity<>(SucessMsg.INSERT, SucessMsg.statusOK);

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

	@GetMapping("/info/{itemName}")
	public ResponseEntity<ItemGiftCardDTO.Info> findItemInfo(@PathVariable String itemName) {
		ItemGiftCard info = itemGiftCardService.findItemGiftCard(itemName);
		ItemGiftCardDTO.Info item = ItemGiftCardDTO.Info.builder().itemName(info.getItemName())
				.itemType(info.getItemType()).itemPrice(info.getItemPrice()).itemSize(info.getItemSize())
				.itemInfo(info.getItemInfo()).build();

		return new ResponseEntity<>(item, SucessMsg.statusOK);
	}

}
