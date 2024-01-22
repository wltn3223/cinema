package com.mire.cinema.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mire.cinema.domain.review.Review;
import com.mire.cinema.domain.review.ReviewDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.ReviewService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/review")
@RequiredArgsConstructor
public class ReviewController {
	private final ReviewService reviewService;

	// 등록
	@PostMapping
	public ResponseEntity<String> saveReview(@Valid @RequestBody ReviewDTO.ReviewWriteDTO reviewDTO,BindingResult bindingResult){
	    if (bindingResult.hasErrors()) {
	        return new ResponseEntity<>(bindingResult.getAllErrors().get(0).getDefaultMessage(),
	                HttpStatus.BAD_REQUEST);
	    }

		Review review = Review.builder().reviewNo(reviewDTO.getReviewNo()).reviewScore(reviewDTO.getReviewScore())
				.reviewTitle(reviewDTO.getReviewTitle()).reviewContent(reviewDTO.getReviewContent()).movieNo(reviewDTO.getMovieNo()).build();
		
		reviewService.saveReview(review);
		return new ResponseEntity<>(SucessMsg.INSERT, SucessMsg.statusOK);
	}

	@GetMapping("/info/{reviewNo}")
	public ResponseEntity<ReviewDTO.ReviewInfo> findReviewInfo(@PathVariable Long reviewNo) {
		Review info = reviewService.findReview(reviewNo);
		ReviewDTO.ReviewInfo review = ReviewDTO.ReviewInfo.builder().reviewNo(info.getReviewNo()).reviewScore(info.getReviewScore())
				.reviewTitle(info.getReviewTitle()).reviewContent(info.getReviewContent()).reviewViews(info.getReviewViews()).reviewDate(info.getReviewDate()).movieNo(info.getMovieNo()).build();

		return new ResponseEntity<>(review, SucessMsg.statusOK);
	}

	@PostMapping("/update")
	public ResponseEntity<String> modifyReview(@Valid ReviewDTO.ReviewUpdate review) {
		reviewService.modifyReview(review);
		return new ResponseEntity<>(SucessMsg.UPDATE, SucessMsg.statusOK);
	}

	// 삭제하기
	@DeleteMapping("/{reviewNo}")
	public ResponseEntity<String> removeReview(@PathVariable Long reviewNo) {
		reviewService.removeReview(reviewNo);
		return new ResponseEntity<>(SucessMsg.DELETE, SucessMsg.statusOK);
	}

	// 검색기능,페이징기능
	@GetMapping("/info/title/{reviewTitle}")
	public ResponseEntity<ReviewDTO.ReviewInfo> findReviewInfo(@PathVariable String reviewTitle) {
		Review info = reviewService.findSearchReview(reviewTitle);
		if (info == null) {
			throw new IllegalArgumentException(ErrorMsg.BoardNOTFOUND);
		}
		ReviewDTO.ReviewInfo review = ReviewDTO.ReviewInfo.builder().reviewNo(info.getReviewNo()).reviewScore(info.getReviewScore())
				.reviewTitle(info.getReviewTitle()).reviewContent(info.getReviewContent()).reviewViews(info.getReviewViews()).reviewDate(info.getReviewDate()).movieNo(info.getMovieNo()).build();

		return new ResponseEntity<>(review, SucessMsg.statusOK);
	}

	@GetMapping("/list/{pageNum}")
	public ResponseEntity<Map<String, Object>> getReviewList(@PathVariable Integer pageNum) {
		try {
			return new ResponseEntity<>(reviewService.getReviewMap(pageNum, null), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/list/{pageNum}/review/{reviewTitle}")
	public ResponseEntity<Map<String, Object>> getReviewList(@PathVariable Integer pageNum,
			@PathVariable String reviewTitle) {
		return new ResponseEntity<>(reviewService.getReviewMap(pageNum, reviewTitle), HttpStatus.OK);
	}

	@GetMapping("/list/movie/{movieNo}")
	public ResponseEntity<List<ReviewDTO.ReviewInfo>> getReviewsByMovie(@PathVariable Long movieNo) {
	    try {
	        List<ReviewDTO.ReviewInfo> reviews = reviewService.getReviewsByMovie(movieNo);
	        return new ResponseEntity<>(reviews, HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

}