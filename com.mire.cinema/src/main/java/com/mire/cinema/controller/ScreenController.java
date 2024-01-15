package com.mire.cinema.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mire.cinema.domain.screen.Screen;
import com.mire.cinema.domain.screen.ScreenDTO;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.ScreenService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/screen")
@RequiredArgsConstructor
public class ScreenController {
	private final ScreenService screenService;

	// 상영관 등록
	@PostMapping
	public ResponseEntity<String> saveScreen(@Valid @RequestBody ScreenDTO.insert screenDTO,
			BindingResult bindingResult) throws Exception {
		if (bindingResult.hasErrors()) {
			return new ResponseEntity<>(bindingResult.getAllErrors().get(0).getDefaultMessage(),
					HttpStatus.BAD_REQUEST);
		}

		Screen screen = Screen.builder().screenNo(screenDTO.getScreenNo()).screenFloor(screenDTO.getScreenFloor())
				.screenHall(screenDTO.getScreenHall()).screenTotalSeat(screenDTO.getScreenTotalSeat())
				.cinemaNo(screenDTO.getCinemaNo()).build();

		screenService.saveScreen(screen);
		return new ResponseEntity<>(SucessMsg.INSERT, SucessMsg.statusOK);
	}

	// 상영관 리스트
	@GetMapping("/list")
	public ResponseEntity<List<Screen>> ScreenList() {
		List<Screen> screenList = screenService.seeScreen();
		return new ResponseEntity<>(screenList, SucessMsg.statusOK);
	}

	// 상영관 내용보기
	@GetMapping("/{screenNo}")
	public ResponseEntity<Screen> findScreen(@PathVariable long screenNo) {
		Screen foundScreen = screenService.findScreen(screenNo);
		return new ResponseEntity<>(foundScreen, SucessMsg.statusOK);
	}

	// 상영관 내용 수정하기
	@PutMapping("/modify")
	public ResponseEntity<String> modifyScreen(@RequestBody ScreenDTO.Update screen) {
		screenService.modifyScreen(screen);
		return new ResponseEntity<>(SucessMsg.UPDATE, SucessMsg.statusOK);
	}

	// 상영관 삭제하기
	@DeleteMapping("/{screenNo}")
	public ResponseEntity<String> removeNotice(@PathVariable Long screenNo) {
		screenService.removeScreen(screenNo);
		return new ResponseEntity<>(SucessMsg.DELETE, SucessMsg.statusOK);
	}
}
