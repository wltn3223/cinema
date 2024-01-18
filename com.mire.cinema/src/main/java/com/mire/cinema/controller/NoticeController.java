package com.mire.cinema.controller;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.mire.cinema.domain.notice.Notice;
import com.mire.cinema.domain.notice.NoticeDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.ImageService;
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
	private final ImageService imageService;

	// 공지사항 등록
	@PostMapping
	public ResponseEntity<String> saveNotice(@Valid NoticeDTO.NoticeWriteDTO noticeDTO,
			@RequestParam(name = "file", required = false) MultipartFile noticeImage, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return new ResponseEntity<>(bindingResult.getAllErrors().get(0).getDefaultMessage(),
					HttpStatus.BAD_REQUEST);
		}

		if (noticeImage == null) {
			throw new NullPointerException(ErrorMsg.IMAGENOTFOUND);
		}
		String uuidName = imageService.saveImage(noticeImage);

		Notice notice = Notice.builder().boardNo(noticeDTO.getBoardNo()).boardTitle(noticeDTO.getBoardTitle())
				.boardContent(noticeDTO.getBoardContent()).boardType(noticeDTO.getBoardType()).imageUuid(uuidName)
				.build();

		noticeService.saveNotice(notice);
		return new ResponseEntity<>(SucessMsg.INSERT, SucessMsg.statusOK);
	}

	// 공지사항 내용보기
	@GetMapping("/{boardNo}")
	public ResponseEntity<Notice> findNotice(@PathVariable long boardNo) {
		Notice foundNotice = noticeService.findNotice(boardNo);
		return new ResponseEntity<>(foundNotice, SucessMsg.statusOK);
	}

	// 공지사항 내용 수정하기
	@PostMapping("/update")
	public ResponseEntity<String> modifyNotice(@Valid NoticeDTO.NoticeUpdate noticeDTO,
			@RequestParam(required = false) MultipartFile file) {
		String uuid = null;
		Notice notice = null;

		notice = noticeService.findNotice(noticeDTO.getBoardNo());// 가져오고

		if (file != null && file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {// 파일이 있을때
			if (notice.getImageUuid() != null) {// 이미지
				imageService.removeImage(notice.getImageUuid());
			}
			log.info("저장");
			uuid = imageService.saveImage(file);
			noticeDTO.setImageUuid(uuid);// 저장
		} else {
			noticeDTO.setImageUuid(notice.getImageUuid());
		}
		System.out.println("가나" + noticeDTO.toString());
		noticeService.modifyNotice(noticeDTO);
		return new ResponseEntity<>(SucessMsg.UPDATE, SucessMsg.statusOK);
	}

	// 공지사항 삭제하기
	@DeleteMapping("/{boardNo}")
	public ResponseEntity<String> removeNotice(@PathVariable Long boardNo) {
		noticeService.removeNotice(boardNo);
		return new ResponseEntity<>(SucessMsg.DELETE, SucessMsg.statusOK);
	}

	// 공지사항 검색기능,페이징기능 
	@GetMapping("/info/{boardTitle}")
	public ResponseEntity<NoticeDTO.Info> findNoticeInfo(@PathVariable String boardTitle) {
		Notice info = noticeService.findSearchNotice(boardTitle);
		if (info == null) {
			throw new IllegalArgumentException(ErrorMsg.BoardNOTFOUND);
		}
		NoticeDTO.Info notice = NoticeDTO.Info.builder().boardNo(info.getBoardNo()).boardTitle(info.getBoardTitle())
				.boardContent(info.getBoardContent()).boardViews(info.getBoardViews()).boardDate(info.getBoardDate())
				.build();
		return new ResponseEntity<>(notice, SucessMsg.statusOK);
	}

	@GetMapping("/list/{pageNum}")
	public ResponseEntity<Map<String, Object>> getNoticeList(@PathVariable Integer pageNum) {
		try {
			return new ResponseEntity<>(noticeService.getNoticeMap(pageNum, null), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/list/{pageNum}/notice/{boardTitle}")
	public ResponseEntity<Map<String, Object>> getNoticeList(@PathVariable Integer pageNum,@PathVariable String boardTitle) {
		return new ResponseEntity<>(noticeService.getNoticeMap(pageNum, boardTitle), HttpStatus.OK);
	}

}
