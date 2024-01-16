package com.mire.cinema.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.notice.Notice;
import com.mire.cinema.domain.notice.NoticeDTO;
import com.mire.cinema.repository.NoticeMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class NoticeServiceImpl implements NoticeService {
	private final NoticeMapper noticeMapper;

	// 공지사항 등록
	@Override
	public void saveNotice(Notice notice) {
		noticeMapper.insertNotice(notice);
	}

	// 공지사항 출력하기
	@Override
	public List<Notice> seeNotice() {
		return noticeMapper.selectNotice();
	}

	// 공지사항 내용 출력
	@Override
	public Notice findNotice(long boardNo) {
		noticeMapper.updateNoticeViews(boardNo);
		return noticeMapper.getNotice(boardNo);
	}

	// 공지사항 내용 업데이트
	@Override
	public void modifyNotice(NoticeDTO.NoticeUpdate notice) {
		noticeMapper.updateNotice(notice);
	}

	// 공지사항 내용 삭제
	@Override
	public void removeNotice(Long boardNO) {
		noticeMapper.deleteNotice(boardNO);
	}

}
