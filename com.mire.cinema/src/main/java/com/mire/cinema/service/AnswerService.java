package com.mire.cinema.service;

import java.util.List;
import java.util.Map;

import com.mire.cinema.domain.answer.Answer;
import com.mire.cinema.domain.answer.AnswerDTO;

public interface AnswerService {
	// 등록
	public void saveAnswer(Answer ans);

	// 리스트 출력
	public List<Answer> seeAnswer();

	// 내용 출력
	public Answer findAnswer(Long ansNo);

	// 검색/페이징
	public Answer findSearchAnswer(String ansTitle);
	public Map<String, Object> getAnswerMap(Integer pageNum, String ansTitle);
	public int getTotalAnswer();
	public int getTotalAnswer(String ansTitle);

	// 내용 수정
	public void modifyAnswer(AnswerDTO.AnswerUpdate ans);

	// 삭제
	public void removeAnswer(Long ansNo);

}
