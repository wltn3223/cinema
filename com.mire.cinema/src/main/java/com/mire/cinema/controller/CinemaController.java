package com.mire.cinema.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.mire.cinema.domain.cinema.Cinema;
import com.mire.cinema.domain.cinema.CinemaDTO;
import com.mire.cinema.domain.notice.Notice;
import com.mire.cinema.domain.notice.NoticeDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.CinemaService;
import com.mire.cinema.service.ImageService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/cinema")
@RequiredArgsConstructor
public class CinemaController {
	private final CinemaService cinemaService;

	

	// 영화관 리스트
	@GetMapping("/list")
	public ResponseEntity<List<Cinema>> CinemaList() {
		List<Cinema> cinemaList = cinemaService.seeCinema();
		return new ResponseEntity<>(cinemaList, SucessMsg.statusOK);
	}
	


	

	// 영화관 리스트 수정하기
	@PutMapping
	public ResponseEntity<String> modifyCinema(@RequestBody CinemaDTO.CinemaUpdate cinema) {
		cinemaService.modifyCinema(cinema);
		return new ResponseEntity<>(SucessMsg.UPDATE, SucessMsg.statusOK);
	}

	
}
