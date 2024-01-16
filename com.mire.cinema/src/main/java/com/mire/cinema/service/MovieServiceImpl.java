package com.mire.cinema.service;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.domain.movie.MovieDTO;
import com.mire.cinema.domain.page.Page;
import com.mire.cinema.domain.page.PageCreate;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.ImageMapper;
import com.mire.cinema.repository.MovieMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
@Log
@Service
@RequiredArgsConstructor
public class MovieServiceImpl implements MovieService {
	private final MovieMapper movieMapper;
	private final ImageMapper imageMapper;

	@Override
	public void saveMovie(Movie movie) {
		
		movieMapper.insertMovie(movie);

	}

	@Override
	public Movie findMovie(long movieNo) {
		// TODO Auto-generated method stub
		return movieMapper.selectMovie(movieNo);
	}

	@Override
	public void modifyMovie(MovieDTO.update update) {
		log.info(update.getImageUuid());
		
		Movie movie = Movie.builder()
			    .movieNo(update.getMovieNo())
			    .movieTitle(update.getMovieTitle())
			    .movieGenre(update.getMovieGenre())
			    .movieIntro(update.getMovieIntro())
			    .movieActors(update.getMovieActors())
			    .moviePlayTime(Integer.parseInt(update.getMoviePlayTime()))
			    .movieLimit(Integer.parseInt(update.getMovieLimit()))
			    .imageUuid(update.getImageUuid())
			    .build();
		
		log.info("영화정보" + movie);
		
		movieMapper.updateMovie(movie);
		
		

	}

	@Override
	public void removeMovie(long movieNo) {
		movieMapper.deleteMovie(movieNo);

	}
	@Override
	public int getTotalCount() {
		if(movieMapper.countMovie() == 0) {
			throw new NullPointerException(ErrorMsg.DataNOTFOUND);
		}
		
		return movieMapper.countMovie();
	}
	@Override
	public List<Movie> getTotalList(){
		
		
		return movieMapper.getTotalList();
		
	};
	
	
	
	
	@Override
	public List<MovieDTO.Movies> getPartList(int start, int end){
		
		
		return movieMapper.getPartList(start,end);
		
	};
	
	@Override
	public Map<String,Object> getPageMap(Integer pageNum){
		
		if(pageNum == null) {
			throw new IllegalArgumentException(ErrorMsg.BADTYPE);
		}
		
		
		Page page = new Page();
		page.setPageNum(pageNum, 15);  // 현재 페이지와 페이지 몇개 보여줄지 설정
		
		
		PageCreate pc = new PageCreate();
		pc.setPaging(page);
		pc.setArticleTotalCount(getTotalCount());
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("page", pc);
		map.put("list",movieMapper.getPartList(page.getStartNum(), page.getEndNum())); 
		
		
		
		
		return	map;
		
	}
}
