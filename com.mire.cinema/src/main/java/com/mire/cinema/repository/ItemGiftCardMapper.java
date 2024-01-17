package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.itemgiftcard.ItemGiftCard;




@Repository
@Mapper
public interface ItemGiftCardMapper {
	  
		void insertItemGiftCard(ItemGiftCard itemgiftcard);
		ItemGiftCard selectItemGiftCard(String name);

	    List<ItemGiftCard> getItemGiftCardList();
	    List<ItemGiftCard> selectAllItemGiftCard();
	    void deleteItemGiftCard(String name);

	    void updateItemGiftCard(ItemGiftCard itemgiftcard);
	    void updateItemImage(ItemGiftCard item);
	    
}
