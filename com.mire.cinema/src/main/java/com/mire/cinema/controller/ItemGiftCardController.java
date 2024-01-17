
package com.mire.cinema.controller;

import java.util.List;
import java.util.Map;

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
import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.domain.movie.MovieDTO;
import com.mire.cinema.domain.notice.Notice;
import com.mire.cinema.domain.notice.NoticeDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.ImageService;
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
	private final ImageService imageService;

	@PostMapping
	public ResponseEntity<String> saveItemGiftCard(@Valid ItemGiftCardDTO.Insert insert,
			@RequestParam(name = "file", required =false) MultipartFile itemImage, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			throw new IllegalArgumentException(bindingResult.getFieldErrors().get(0).getDefaultMessage());
					
		}
		if(itemImage == null) {
			throw new NullPointerException(ErrorMsg.IMAGENOTFOUND);
		}
		String imageUuid = imageService.saveImage(itemImage);


		// ItemGiftCard 객체 생성
		ItemGiftCard itemGiftCard = ItemGiftCard.builder().itemNo(insert.getItemNo()).itemName(insert.getItemName()).itemType(insert.getItemType())
				.itemPrice(insert.getItemPrice()).itemSize(insert.getItemSize()).itemInfo(insert.getItemInfo())
				.imageUuid(imageUuid).cinemaName(insert.getCinemaName()).build();

		// 서비스를 통해 ItemGiftCard 저장
		itemGiftCardService.saveItemGiftCard(itemGiftCard);

		return new ResponseEntity<>(SucessMsg.INSERT, SucessMsg.statusOK);

	}

	@GetMapping("/{itemNo}")
	public ResponseEntity<ItemGiftCard> findItemGiftCard(@PathVariable Long itemNo) {
		ItemGiftCard foundItemGiftCard = itemGiftCardService.findItemGiftCard(itemNo);
		return ResponseEntity.ok(foundItemGiftCard);
	}

	
	@PostMapping("/update")
	public ResponseEntity<String> modifyItemGiftCard(@Valid ItemGiftCardDTO.update item,
	    @RequestParam(required = false) MultipartFile file) {
	    String uuid = null;
	    ItemGiftCard findItem = null;

	    findItem = itemGiftCardService.findItemGiftCard(item.getItemNo());

	    try {
	        if (file != null && !file.isEmpty()) {
	            if (findItem.getImageUuid() != null) {
	                imageService.removeImage(findItem.getImageUuid());
	            }
	            log.info("새 이미지 저장");
	            uuid = imageService.saveImage(file);
	            item.setImageUuid(uuid);
	        } else {
	            // 새 이미지가 제공되지 않은 경우 기존 이미지 UUID 유지
	            item.setImageUuid(findItem.getImageUuid());
	        }

	        log.info("상품 수정 중");
	        itemGiftCardService.modifyItemGiftCard(item);
	        return new ResponseEntity<>(SucessMsg.UPDATE, SucessMsg.statusOK);
	    } catch (Exception e) {
	       
	        return new ResponseEntity<>(ErrorMsg.DataNOTFOUND, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}




	@DeleteMapping("/{itemNo}")
	public ResponseEntity<Void> removeItemGiftCard(@PathVariable Long itemNo) {
		itemGiftCardService.removeItemGiftCard(itemNo);
		return ResponseEntity.ok().build();
	}

	@GetMapping("/list")
	public ResponseEntity<List<ItemGiftCard>> itemGiftCardList() {
		List<ItemGiftCard> itemList = itemGiftCardService.selectAllItemGiftCard();
		return new ResponseEntity<>(itemList, SucessMsg.statusOK);
	}

	@GetMapping("/info/{itemNo}")
	public ResponseEntity<ItemGiftCardDTO.Info> findItemInfo(@PathVariable Long itemNo) {
		ItemGiftCard info = itemGiftCardService.findItemGiftCard(itemNo);
		ItemGiftCardDTO.Info item = ItemGiftCardDTO.Info.builder().itemNo(info.getItemNo()).itemName(info.getItemName())
				.itemType(info.getItemType()).itemPrice(info.getItemPrice()).itemSize(info.getItemSize())
				.itemInfo(info.getItemInfo()).imageUuid(info.getImageUuid()).cinemaName(info.getCinemaName()).build();

		return new ResponseEntity<>(item, SucessMsg.statusOK);
	}
//	
//	@GetMapping("/list/{pageNum}")
//	public ResponseEntity<Map<String,Object>> getItemGiftCardList(@PathVariable Integer pageNum) {
//		
//
//	
//
//		return new ResponseEntity<>(itemGiftCardService.getItemGiftCardMap(pageNum,null),HttpStatus.OK);
//
//	}
//	
//	@GetMapping("/list/{pageNum}/item/{itemNo}")
//	public ResponseEntity<Map<String,Object>> getItemGiftCardList(@PathVariable Integer pageNum, @PathVariable String itemNo) {
//		
//		return new ResponseEntity<>(itemGiftCardService.getItemGiftCardMap(pageNum, itemNo),HttpStatus.OK);
//
//	}

}
