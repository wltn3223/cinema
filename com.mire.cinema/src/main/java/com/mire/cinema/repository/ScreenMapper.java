package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.screen.Screen;
import com.mire.cinema.domain.screen.ScreenDTO;

@Repository
@Mapper
public interface ScreenMapper {
	//상영관 등록
	void insertScreen(Screen screen);
	//상영관 리스트 보기
	List<Screen> selectScreen();
	//상영관 정보 보기
	Screen getScreen(long screenNo);
	//상영관 정보 보기
	List<Screen> getCinemaScreen(String cinemaName);
	//상영관 정보수정 하기
	void updateScreen(ScreenDTO.Update screen);
	//상영관 정보 삭제
	void deleteScreen(long screenNo);
}
