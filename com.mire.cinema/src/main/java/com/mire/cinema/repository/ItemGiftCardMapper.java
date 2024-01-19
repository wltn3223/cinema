package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.itemgiftcard.ItemGiftCard;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCardDTO;




@Repository
@Mapper
public interface ItemGiftCardMapper {
	  
		void insertItemGiftCard(ItemGiftCard itemgiftcard);
		ItemGiftCard selectItemGiftCard(Long itemNo);
	    List<ItemGiftCard> getItemGiftCardList();
	    List<ItemGiftCard> selectAllItemGiftCard();
	    void deleteItemGiftCard(Long itenNo);
	    void updateItemGiftCard(ItemGiftCard itemgiftcard);
	    
	    int countItemGiftCard();
	    int countItemName(String itemName);
	    int countsearchItem(String itemName);
	    List<ItemGiftCard> getPartList(int start,int end);
	    List<ItemGiftCard> searchPartList(ItemGiftCardDTO.search dto);
	    
}
