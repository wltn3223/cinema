package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.notice.Notice;
import com.mire.cinema.domain.notice.NoticeDTO;

@Repository
@Mapper
@MapperScan
public interface NoticeMapper {
	// 공지사항 등록하기
	void insertNotice(Notice notice);

	// 공지사항 리스트 출력하기
	List<Notice> selectNotice();

	// 공지사항 내용 출력하기
	Notice getNotice(Long boardNo);

	// 공지사항 내용 수정하기
	void updateNotice(NoticeDTO.NoticeUpdate notice);

	// 공지사항 삭제하기
	void deleteNotice(Long boardNo);
	
	// 공지사항 조회수 증가
	void updateNoticeViews(long boardNo);

	
	// 공지사항 검색,페이징 기능
	List<Notice> searchNoticeList(NoticeDTO.Search noticeDTO);
	int countNotice();
	List<Notice> getPartList(int start,int end);
	int countNoticeTitle(String boardTitle);
	int countSearchNotice(String boardTitle);
	void searchNoiceList(NoticeDTO.Search notice);
	Notice getSearchNotice(String boardTitle);
}
