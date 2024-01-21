package com.mire.cinema.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.answer.Answer;
import com.mire.cinema.domain.answer.AnswerDTO;
import com.mire.cinema.domain.answer.AnswerDTO.Search;
import com.mire.cinema.domain.page.PageCreate;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.AnswerMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class AnswerServiceImpl implements AnswerService {
	private final AnswerMapper answerMapper;

	// 등록
	@Override
	public void saveAnswer(Answer ans) {
		answerMapper.insertAnswer(ans);
	}

	// 출력하기
	@Override
	public List<Answer> seeAnswer() {
		return answerMapper.selectAnswer();
	}

	// 내용 출력
	@Override
	public Answer findAnswer(Long ansNo) {
		answerMapper.updateAnswerViews(ansNo);
		return answerMapper.getAnswer(ansNo);
	}

	// 페이징처리 및 검색기능
	@Override
	public Map<String, Object> getAnswerMap(Integer pageNum, String ansTitle) {
		Map<String, Object> map = new HashMap<>();

		PageCreate pc = new PageCreate();

		if (ansTitle == null || "".equals(ansTitle.trim())) {
			pc = pc.getPage(pageNum, getTotalAnswer());
			map.put("list", answerMapper.getPartList(pc.getPaging().getStartNum(), pc.getPaging().getEndNum()));
		} else {
			pc = pc.getPage(pageNum, getTotalAnswer(ansTitle));
			AnswerDTO.Search AnswerDTO = new Search();
			AnswerDTO.setAnsTitle(ansTitle);
			AnswerDTO.setStartNum(pc.getPaging().getStartNum());
			AnswerDTO.setEndNum(pc.getPaging().getEndNum());

			map.put("Keyword", ansTitle);
			map.put("searchList", answerMapper.searchAnswerList(AnswerDTO));
		}

		map.put("page", pc);

		return map;
	}

	@Override
	public int getTotalAnswer() {
		int num = answerMapper.countAnswer();
		if (num == 0) {// 0이면
			throw new NullPointerException(ErrorMsg.DataNOTFOUND);
		}
		return num;
	}

	@Override
	public int getTotalAnswer(String ansTitle) {
		if (ansTitle == null) {
			return answerMapper.countAnswer();
		} else {
			return answerMapper.countAnswerTitle(ansTitle);
		}
	}

	@Override
	public Answer findSearchAnswer(String ansTitle) {
		return answerMapper.getSearchAnswer(ansTitle);
	}

	// 내용 업데이트
	@Override
	public void modifyAnswer(AnswerDTO.AnswerUpdate Answer) {
		answerMapper.updateAnswer(Answer);
	}

	// 내용 삭제
	@Override
	public void removeAnswer(Long ansNO) {
		answerMapper.deleteAnswer(ansNO);
	}

}