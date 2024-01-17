package com.mire.cinema.service;

import java.util.List;
import java.util.Map;

import com.mire.cinema.domain.itemgiftcard.ItemGiftCard;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCardDTO;

public interface ItemGiftCardService {

	public void saveItemGiftCard(ItemGiftCard item);

	public ItemGiftCard findItemGiftCard(String itemName);

	public void modifyItemGiftCard(ItemGiftCard item, ItemGiftCardDTO.update update);

	public void removeItemGiftCard(String itemName);

	public List<ItemGiftCard> selectAllItemGiftCard();
	public int getTotalItemGiftCard();
	public int getTotalItemGiftCard(String name);
	public Map<String,Object> getItemGiftCardMap(Integer pageNum, String itemName);
	
}