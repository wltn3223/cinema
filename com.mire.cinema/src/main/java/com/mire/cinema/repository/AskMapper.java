package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.ask.Ask;
import com.mire.cinema.domain.ask.AskDTO;

@Repository
@Mapper
@MapperScan
public interface AskMapper {
	// 문의사항 등록하기
	void insertAsk(Ask ask);

	// 문의사항 리스트 출력하기
	List<Ask> selectAsk();
	
	// 문의사항 내용 출력하기
	Ask getAsk(Long askNo);

	// 문의사항 내용 수정하기
	void updateAsk(AskDTO.AskUpdate ask);
	
	// 문의사항 삭제하기
	void deleteAsk(Long askNo);
}
