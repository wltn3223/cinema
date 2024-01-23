package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.answer.Answer;
import com.mire.cinema.domain.answer.AnswerDTO;
import com.mire.cinema.domain.review.Review;

@Repository
@Mapper
@MapperScan
public interface AnswerMapper {

	void insertAnswer(Answer ans);

	// 리스트 출력하기
	List<Answer> selectAnswer();

	// 내용 출력하기
	Answer getAnswer(Long ansNo);

	// 내용 수정하기
	void updateAnswer(AnswerDTO.AnswerUpdate ans);

	// 검색/페이징 기능
	Answer getSearchAnswer(String ansTitle);
	void searchAnswerList1(AnswerDTO.Search ans);
	int countAnswer();
	int countAnswerTitle(String ansTitle);
	int countSearchAnswer(String ansTitle);
	List<Answer> getPartList(int start,int end);
	List<Answer> searchAnswerList(AnswerDTO.Search answerDTO);
	// 글 삭제하기
	void deleteAnswer(Long ansNo);

	// 글 조회수 증가
	void updateAnswerViews(long ansNo);
	
	List<Answer> getAnswersByAsk(Long askNo);
}