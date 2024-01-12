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

import com.mire.cinema.domain.notice.Notice;
import com.mire.cinema.domain.notice.NoticeDTO;
import com.mire.cinema.response.SucessMessage;
import com.mire.cinema.service.NoticeService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeController {
	private final NoticeService noticeService;

	// 공지사항 등록
	@PostMapping
	public ResponseEntity<String> saveNotice(@Valid @RequestBody NoticeDTO.NoticeWriteDTO noticeDTO,
			BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return new ResponseEntity<>(bindingResult.getAllErrors().get(0).getDefaultMessage(),
					HttpStatus.BAD_REQUEST);
		}

		Notice notice = Notice.builder().boardNo(noticeDTO.getBoardNo()).boardTitle(noticeDTO.getBoardTitle())
				.boardContent(noticeDTO.getBoardContent()).boardType(noticeDTO.getBoardType()).build();

		noticeService.saveNotice(notice);
		return new ResponseEntity<>(SucessMessage.INSERT, SucessMessage.statusOK);
	}

	// 공지사항 리스트
	@GetMapping("/list")
	public ResponseEntity<List<Notice>> NoticeList() {
		List<Notice> noticeList = noticeService.seeNotice();
		return new ResponseEntity<>(noticeList, SucessMessage.statusOK);
	}

	// 공지사항 내용보기
	@GetMapping("/{boardNo}")
	public ResponseEntity<Notice> findNotice(@PathVariable long boardNo) {
		Notice foundNotice = noticeService.findNotice(boardNo);
		return new ResponseEntity<>(foundNotice, SucessMessage.statusOK);
	}
	//공지사항 데이터를 출력
	@GetMapping("/info/{boardNo}")
	public ResponseEntity<Notice> findItemInfo(@PathVariable long boardNo) {
	    Notice info = noticeService.findNotice(boardNo);
	    Notice notice = Notice.builder()
	    		.boardNo(info.getBoardNo())
	    		.boardTitle(info.getBoardTitle())
	    		.boardContent(info.getBoardContent())
	    		.boardType(info.getBoardType())
	    		.boardViews(info.getBoardViews())
	    		.boardDate(info.getBoardDate())
	            .build();

	    return new ResponseEntity<>(notice, SucessMessage.statusOK);
	}

	
	//공지사항 내용 수정하기
	@PutMapping
	public ResponseEntity<String> modifyNotice(@RequestBody NoticeDTO.NoticeUpdate notice) {
		noticeService.modifyNotice(notice);
		return new ResponseEntity<>(SucessMessage.UPDATE, SucessMessage.statusOK);
	}
	
	//공지사항 삭제하기
	@DeleteMapping("/{boardNo}")
	public ResponseEntity<String> removeNotice(@PathVariable Long boardNo) {
		noticeService.removeNotice(boardNo);
		return new ResponseEntity<>(SucessMessage.DELETE, SucessMessage.statusOK);
	}

}
