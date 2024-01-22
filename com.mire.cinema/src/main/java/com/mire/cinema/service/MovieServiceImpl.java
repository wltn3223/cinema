package com.mire.cinema.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.domain.movie.MovieDTO;
import com.mire.cinema.domain.movie.MovieDTO.Search;
import com.mire.cinema.domain.page.Page;
import com.mire.cinema.domain.page.PageCreate;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.MovieMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@Service
@RequiredArgsConstructor
public class MovieServiceImpl implements MovieService {
	private final MovieMapper movieMapper;

	@Override
	public void saveMovie(Movie movie) {
		movieMapper.insertMovie(movie);
	}

	@Override
	public Movie findMovie(long movieNo) {
		return movieMapper.selectMovie(movieNo);
	}

	@Override
	public void modifyMovie(MovieDTO.update update) {
		log.info(update.getImageUuid());

		Movie movie = Movie.builder().movieNo(update.getMovieNo()).movieTitle(update.getMovieTitle())
				.movieGenre(update.getMovieGenre()).movieIntro(update.getMovieIntro())
				.movieActors(update.getMovieActors()).moviePlayTime(Integer.parseInt(update.getMoviePlayTime()))
				.movieLimit(Integer.parseInt(update.getMovieLimit())).imageUuid(update.getImageUuid()).build();

		log.info("영화정보" + movie);

		movieMapper.updateMovie(movie);

	}

	@Override
	public void removeMovie(long movieNo) {
		movieMapper.deleteMovie(movieNo);

	}

	@Override
	public List<Movie> getTotalList() {
		return movieMapper.getTotalList();
	};

	@Override
	public Map<String, Object> getPageMap(Integer pageNum, String movieTitle) {
		Map<String, Object> map = new HashMap<>();
		PageCreate pc = new PageCreate();
		Page page = new Page();
		page.setPageNum(pageNum, 15); // 현재 페이지와 페이지 몇개 보여줄지 설정
		
		if (movieTitle == null || "".equals(movieTitle.trim())) {
			pc = pc.getPage(pageNum, getTotalMovie());
			map.put("list", movieMapper.getPartList(pc.getPaging().getStartNum(), pc.getPaging().getEndNum()));
		} else {
			pc = pc.getPage(pageNum, getTotalMovie(movieTitle));
			MovieDTO.Search dto = new Search();
			dto.setMovieTitle(movieTitle);
			dto.setStartNum(pc.getPaging().getStartNum());
			dto.setEndNum(pc.getPaging().getEndNum());
			map.put("keyword", movieTitle);
			map.put("searchList", movieMapper.searchMovieList(dto));
		}
		map.put("page", pc);
		

		return map;
	}
	@Override
	public int getTotalMovie() {
		int num = movieMapper.countMovie();
		if(num == 0) {
			throw new NullPointerException(ErrorMsg.DataNOTFOUND);
		}
		return num;
	};
	
	@Override
	public int getTotalMovie(String movieTitle) {
		if(movieTitle == null) {
			return movieMapper.countMovie();
		}else {
			return movieMapper.countMovieTitle(movieTitle);
		}
	}

	@Override
	public Movie findSearchMovie(String movieTitle) {
		return movieMapper.getSearchMovie(movieTitle);
	}

	@Override
	public int getTotalCount() {
		if (movieMapper.countMovie() == 0) {
			throw new NullPointerException(ErrorMsg.DataNOTFOUND);
		}
		return movieMapper.countMovie();
	}



}
