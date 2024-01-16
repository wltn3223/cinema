package com.mire.cinema.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.itemgiftcard.ItemGiftCard;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCardDTO;
import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.domain.movie.MovieDTO;
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
	
}