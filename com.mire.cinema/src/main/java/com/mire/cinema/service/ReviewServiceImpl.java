package com.mire.cinema.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.page.PageCreate;
import com.mire.cinema.domain.review.Review;
import com.mire.cinema.domain.review.ReviewDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.ReviewMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ReviewServiceImpl implements ReviewService {
	private final ReviewMapper reviewMapper;

	// 등록
	@Override
	public void saveReview(Review review) {
		reviewMapper.insertReview(review);
	}

	// 출력하기
	@Override
	public List<Review> seeReview() {
		return reviewMapper.selectReview();
	}

	// 내용 출력
	@Override
	public Review findReview(Long reviewNo) {
		reviewMapper.updateReviewViews(reviewNo);
		return reviewMapper.getReview(reviewNo);
	}

	// 페이징처리 및 검색기능
	@Override
	public Map<String, Object> getReviewMap(Integer pageNum, String reviewTitle) {
		Map<String, Object> map = new HashMap<>();

		PageCreate pc = new PageCreate();

		if (reviewTitle == null || "".equals(reviewTitle.trim())) {
			pc = pc.getPage(pageNum, getTotalReview());
			map.put("list", reviewMapper.getPartList(pc.getPaging().getStartNum(), pc.getPaging().getEndNum()));
		} else {
			pc = pc.getPage(pageNum, getTotalReview(reviewTitle));
			ReviewDTO.Search ReviewDTO = new ReviewDTO.Search();
			ReviewDTO.setReviewTitle(reviewTitle);
			ReviewDTO.setStartNum(pc.getPaging().getStartNum());
			ReviewDTO.setEndNum(pc.getPaging().getEndNum());

			map.put("Keyword", reviewTitle);
			map.put("searchList", reviewMapper.searchReviewList(ReviewDTO));
		}

		map.put("page", pc);

		return map;
	}

	@Override
	public int getTotalReview() {
		int num = reviewMapper.countReview();
		if (num == 0) {// 0이면
			throw new NullPointerException(ErrorMsg.DataNOTFOUND);
		}
		return num;
	}

	@Override
	public int getTotalReview(String reviewTitle) {
		if (reviewTitle == null) {
			return reviewMapper.countReview();
		} else {
			return reviewMapper.countReviewTitle(reviewTitle);
		}
	}

	@Override
	public Review findSearchReview(String reviewTitle) {
		return reviewMapper.getSearchReview(reviewTitle);
	}

	// 내용 업데이트
	@Override
	public void modifyReview(ReviewDTO.ReviewUpdate Review) {
		reviewMapper.updateReview(Review);
	}

	// 내용 삭제
	@Override
	public void removeReview(Long reviewNO) {
		reviewMapper.deleteReview(reviewNO);
	}

}