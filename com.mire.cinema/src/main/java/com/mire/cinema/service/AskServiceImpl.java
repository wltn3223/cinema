package com.mire.cinema.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.ask.Ask;
import com.mire.cinema.domain.ask.AskDTO;
import com.mire.cinema.repository.AskMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class AskServiceImpl implements AskService {
	private final AskMapper askMapper;
	private final MemberService memberService;

	// 문의사항 등록
	@Override
	public void saveAsk(Ask ask) {
		askMapper.insertAsk(ask);
	}

	// 문의사항 출력하기
	@Override
	public List<Ask> seeAsk() {
		return askMapper.selectAsk();
	}

	// 문의사항 내용 출력
	@Override
	public Ask findAsk(long askNo) {
		return askMapper.getAsk(askNo);
	}

	// 문의사항 내용 업데이트
	@Override
	public void modifyAsk(AskDTO.AskUpdate ask) {
		askMapper.updateAsk(ask);
	}

	// 문의사항 내용 삭제
	@Override
	public void removeAsk(Long askNO) {
		askMapper.deleteAsk(askNO);
	}

}
