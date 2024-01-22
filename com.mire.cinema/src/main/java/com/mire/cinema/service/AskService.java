package com.mire.cinema.service;

import java.util.List;
import java.util.Map;

import com.mire.cinema.domain.ask.Ask;
import com.mire.cinema.domain.ask.AskDTO;

public interface AskService {
	// 문의사항 등록
	public void saveAsk(Ask ask);

	// 문의사항 리스트 출력
	public List<Ask> seeAsk();

	// 문의사항 내용 출력
	public Ask findAsk(long askNo);

	// 문의사항 내용 수정
	public void modifyAsk(AskDTO.AskUpdate ask);

	// 문의사항 삭제
	public void removeAsk(Long askNo);

	// 검색기능, 페이징
	public Ask findSearchAsk(String askTitle);

	public Map<String, Object> getAskMap(Integer pageNum, String boardTitle);

	public int getTotalAsk();

	public int getTotalAsk(String askTitle);
}
