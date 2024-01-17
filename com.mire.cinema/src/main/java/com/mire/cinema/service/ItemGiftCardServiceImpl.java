package com.mire.cinema.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.itemgiftcard.ItemGiftCard;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCardDTO;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCardDTO.search;
import com.mire.cinema.domain.page.PageCreate;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.ItemGiftCardMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ItemGiftCardServiceImpl implements ItemGiftCardService {

	private final ItemGiftCardMapper itemGiftCardMapper;

	@Override
	public void saveItemGiftCard(ItemGiftCard item) {
		itemGiftCardMapper.insertItemGiftCard(item);

	}

	@Override
	public ItemGiftCard findItemGiftCard(String itemName) {

		return itemGiftCardMapper.selectItemGiftCard(itemName);
	}


	@Override
	public void modifyItemGiftCard(ItemGiftCard item1, ItemGiftCardDTO.update update) {
		
		ItemGiftCard item = ItemGiftCard.builder()
				.itemName(update.getItemName())
			    .itemType(update.getItemType())
			    .itemPrice(update.getItemPrice())
			    .itemSize(update.getItemSize())
			    .itemInfo(update.getItemInfo())
			    .imageUuid(update.getImageUuid())
			    .cinemaName(update.getCinemaName())
			    .build();
				
		itemGiftCardMapper.updateItemGiftCard(item);
	}

	@Override
	public void removeItemGiftCard(String itemName) {

		itemGiftCardMapper.deleteItemGiftCard(itemName);

	}

	@Override
	public List<ItemGiftCard> selectAllItemGiftCard() {

		return itemGiftCardMapper.selectAllItemGiftCard();
	}
	
	
	@Override
	public int getTotalItemGiftCard() {
		int num = itemGiftCardMapper.countItemGiftCard();
		if(num == 0) {
			throw new NullPointerException(ErrorMsg.DataNOTFOUND);
		}
		
		
		return num;
	}
	@Override
	public int getTotalItemGiftCard(String name) {

		return 	itemGiftCardMapper.countsearchItem(name);
	}

	@Override
	public Map<String,Object> getItemGiftCardMap(Integer pageNum, String itemName) {
		Map<String, Object> map = new HashMap<>();
		if(pageNum == null) {
			throw new IllegalArgumentException(ErrorMsg.BADTYPE);
		}
		PageCreate pc = new PageCreate();
		
		
		if(itemName == null || "".equals(itemName.trim())) {
			pc = pc.getPage(pageNum, getTotalItemGiftCard());
			map.put("list",itemGiftCardMapper.getPartList(pc.getPaging().getStartNum(), pc.getPaging().getEndNum()));
		}
		
		else {
			pc = pc.getPage(pageNum, getTotalItemGiftCard(itemName));
			ItemGiftCardDTO.search dto = new search();
			dto.setItemName(itemName);
			dto.setStartNum(pc.getPaging().getStartNum());
			dto.setEndNum(pc.getPaging().getEndNum());
			map.put("keyword", itemName);
			map.put("searchList",itemGiftCardMapper.searchPartList(dto));
		}	
		
		map.put("page", pc);
		
	 
		
		return map;
	}
	
}