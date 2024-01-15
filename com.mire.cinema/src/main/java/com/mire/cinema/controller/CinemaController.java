package com.mire.cinema.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.mire.cinema.domain.cinema.Cinema;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.CinemaService;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/cinema")
@RequiredArgsConstructor
public class CinemaController {

	private final CinemaService cinemaService;

	@ResponseBody
	@GetMapping(value = "/list")
	public ResponseEntity<List<Cinema>> list() throws Exception {
		log.info("list");

		return new ResponseEntity<>(cinemaService.list(), SucessMsg.statusOK);

	}

	@PutMapping
	public ResponseEntity<Void> modifyCinema(@RequestBody Cinema cinema) throws Exception {
		cinemaService.modifyCinema(cinema);
		return ResponseEntity.ok().build();
	}



}
