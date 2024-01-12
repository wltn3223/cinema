package com.mire.cinema.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mire.cinema.domain.cinema.Cinema;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.CinemaService;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/cinema")
@RequiredArgsConstructor
public class CinemaController {

	private final CinemaService service;

	@ResponseBody
	@GetMapping(value = "/list")
	public ResponseEntity<List<Cinema>> list() throws Exception {
		log.info("list");

		return new ResponseEntity<>(service.list(), SucessMsg.statusOK);

	}

	@PostMapping
	public ResponseEntity<String> modify(@RequestBody Cinema cinema) throws Exception {
		service.modify(cinema);
		return ResponseEntity.ok("수정이 완료되었습니다.");
	}



}
