package com.mire.cinema.controller;

import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.mire.cinema.domain.answer.Answer;
import com.mire.cinema.domain.answer.AnswerDTO;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCard;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCardDTO;
import com.mire.cinema.domain.notice.Notice;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.AnswerService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/answer")
@RequiredArgsConstructor
public class AnswerController {
	private final AnswerService answerService;

	// 등록
	@PostMapping
	public ResponseEntity<String> saveAnswer(@Valid @RequestBody AnswerDTO.AnswerWriteDTO ansDTO,
			BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return new ResponseEntity<>(bindingResult.getAllErrors().get(0).getDefaultMessage(),
					HttpStatus.BAD_REQUEST);
		}

		Answer ans = Answer.builder().ansNo(ansDTO.getAnsNo()).ansTitle(ansDTO.getAnsTitle())
				.ansContent(ansDTO.getAnsContent()).build();

		answerService.saveAnswer(ans);
		return new ResponseEntity<>(SucessMsg.INSERT, SucessMsg.statusOK);
	}

	@GetMapping("/info/{ansNo}")
	public ResponseEntity<AnswerDTO.AnswerInfo> findAnswerInfo(@PathVariable Long ansNo) {
		Answer info = answerService.findAnswer(ansNo);
		AnswerDTO.AnswerInfo ans = AnswerDTO.AnswerInfo.builder().ansNo(info.getAnsNo()).ansTitle(info.getAnsTitle())
				.ansContent(info.getAnsContent()).ansViews(info.getAnsViews()).ansDate(info.getAnsDate())
				.ansStatus(info.getAnsStatus()).build();

		return new ResponseEntity<>(ans, SucessMsg.statusOK);
	}

	@PostMapping("/update")
	public ResponseEntity<String> modifyAnswer(@Valid AnswerDTO.AnswerUpdate ans) {
		answerService.modifyAnswer(ans);
		return new ResponseEntity<>(SucessMsg.UPDATE, SucessMsg.statusOK);
	}

	// 삭제하기
	@DeleteMapping("/{ansNo}")
	public ResponseEntity<String> removeAnswer(@PathVariable Long ansNo) {
		answerService.removeAnswer(ansNo);
		return new ResponseEntity<>(SucessMsg.DELETE, SucessMsg.statusOK);
	}

	// 검색기능,페이징기능
	@GetMapping("/info/title/{ansTitle}")
	public ResponseEntity<AnswerDTO.AnswerInfo> findAnswerInfo(@PathVariable String ansTitle) {
		Answer info = answerService.findSearchAnswer(ansTitle);
		if (info == null) {
			throw new IllegalArgumentException(ErrorMsg.BoardNOTFOUND);
		}
		AnswerDTO.AnswerInfo ans = AnswerDTO.AnswerInfo.builder().ansNo(info.getAnsNo()).ansTitle(info.getAnsTitle())
				.ansContent(info.getAnsContent()).ansViews(info.getAnsViews()).ansDate(info.getAnsDate()).build();

		return new ResponseEntity<>(ans, SucessMsg.statusOK);
	}

	@GetMapping("/list/{pageNum}")
	public ResponseEntity<Map<String, Object>> getAnswerList(@PathVariable Integer pageNum) {
		try {
			return new ResponseEntity<>(answerService.getAnswerMap(pageNum, null), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/list/{pageNum}/answer/{ansTitle}")
	public ResponseEntity<Map<String, Object>> getAnswerList(@PathVariable Integer pageNum,
			@PathVariable String ansTitle) {
		return new ResponseEntity<>(answerService.getAnswerMap(pageNum, ansTitle), HttpStatus.OK);
	}

}
