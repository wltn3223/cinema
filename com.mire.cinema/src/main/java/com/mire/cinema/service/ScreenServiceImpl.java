package com.mire.cinema.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.screen.Screen;
import com.mire.cinema.domain.screen.ScreenDTO.Update;
import com.mire.cinema.repository.ScreenMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ScreenServiceImpl implements ScreenService{
	private final ScreenMapper screenMapper;

	@Override
	public void saveScreen(Screen screen) {
		screenMapper.insertScreen(screen);
	}

	@Override
	public List<Screen> seeScreen() {
		return screenMapper.selectScreen();
	}

	@Override
	public Screen findScreen(long screenNo) {
		return screenMapper.getScreen(screenNo);
	}

	@Override
	public Screen findCinemaScreen(String cinemaName) {
		return screenMapper.getCinemaScreen(cinemaName);
	}
	
	@Override
	public void modifyScreen(Update screen) {
		screenMapper.updateScreen(screen);
	}
	
}
