package com.mire.cinema.service;

import java.util.List;
import java.util.Map;

import com.mire.cinema.domain.review.Review;
import com.mire.cinema.domain.review.ReviewDTO;

public interface ReviewService {
	// 등록
	public void saveReview(Review review);

	// 리스트 출력
	public List<Review> seeReview();

	// 내용 출력
	public Review findReview(Long reviewNo);

	// 검색/페이징
	public Review findSearchReview(String reviewTitle);
	public Map<String, Object> getReviewMap(Integer pageNum, String reviewTitle);
	public int getTotalReview();
	public int getTotalReview(String reviewTitle);

	// 내용 수정
	public void modifyReview(ReviewDTO.ReviewUpdate review);

	// 삭제
	public void removeReview(Long reviewNo);
	
	public List<ReviewDTO.ReviewInfo> getReviewsByMovie(Long movieNo);
	
	
}