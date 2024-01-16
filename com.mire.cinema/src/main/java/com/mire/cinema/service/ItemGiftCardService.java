
package com.mire.cinema.service;

import java.util.List;

import com.mire.cinema.domain.itemgiftcard.ItemGiftCard;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCardDTO;

public interface ItemGiftCardService {

	public void saveItemGiftCard(ItemGiftCard item);

	public ItemGiftCard findItemGiftCard(String itemName);

	public void modifyItemGiftCard(ItemGiftCard item, ItemGiftCardDTO.update update);

	public void removeItemGiftCard(String itemName);

	public List<ItemGiftCard> selectAllItemGiftCard();
	    
	
}