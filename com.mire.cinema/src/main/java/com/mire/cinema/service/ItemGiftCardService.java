package com.mire.cinema.service;

import java.util.List;
import java.util.Map;

import com.mire.cinema.domain.itemgiftcard.ItemGiftCard;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCardDTO;

public interface ItemGiftCardService {

	public void saveItemGiftCard(ItemGiftCard item);

	public ItemGiftCard findItemGiftCard(Long itemNo);

	public void modifyItemGiftCard(ItemGiftCardDTO.update update);

	public void removeItemGiftCard(Long itemNo);

	public List<ItemGiftCard> selectAllItemGiftCard();
	public int getTotalItemGiftCard();
	public int getTotalItemGiftCard(String name);
	public Map<String,Object> getItemGiftCardMap(Integer pageNum, String itemNo);
	
}