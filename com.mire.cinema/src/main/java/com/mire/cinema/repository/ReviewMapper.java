package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Repository;


import com.mire.cinema.domain.review.Review;
import com.mire.cinema.domain.review.ReviewDTO;

@Repository
@Mapper
@MapperScan
public interface ReviewMapper {

	void insertReview(Review review);

	// 리스트 출력하기
	List<Review> selectReview();

	// 내용 출력하기
	Review getReview(Long reviewNo);

	// 내용 수정하기
	void updateReview(ReviewDTO.ReviewUpdate review);

	// 검색/페이징 기능
	Review getSearchReview(String reviewTitle);
	void searchReviewList1(ReviewDTO.Search review);
	int countReview();
	int countReviewTitle(String reviewTitle);
	int countSearchReview(String reviewTitle);
	List<Review> getPartList(int start,int end);
	List<Review> searchReviewList(ReviewDTO.Search reviewDTO);
	// 글 삭제하기
	void deleteReview(Long reviewNo);
	
	// 글 조회수 증가
	void updateReviewViews(long reviewNo);
}