package com.mire.cinema.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.domain.page.Page;
import com.mire.cinema.domain.page.PageCreate;
import com.mire.cinema.repository.ImageMapper;
import com.mire.cinema.repository.MovieMapper;

import lombok.RequiredArgsConstructor;

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
	public Movie findMovie(int movieNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void modifyMovie(Movie movie) {
		// TODO Auto-generated method stub

	}

	@Override
	public void removeMovie(int movieNo) {
		// TODO Auto-generated method stub

	}
	@Override
	public int getTotalCount() {
		
		return movieMapper.countMovie();
	}
	@Override
	public List<Movie> getTotalList(){
		
		
		return movieMapper.getTotalList();
		
	};
	
	
	@Override
	public List<Movie> getPartList(int start, int end){
		
		
		return movieMapper.getPartList(start,end);
		
	};
	
	@Override
	public Map<String,Object> getPageMap(Integer pageNum){
		Page page = new Page();
		page.setPageNum(pageNum);
		
		
		PageCreate pc = new PageCreate();
		pc.setPaging(page);
		pc.setArticleTotalCount(getTotalCount());
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("page", pc);
		map.put("list",movieMapper.getPartList(page.getStartNum(), page.getEndNum())); 
		
		
		
		
		return	map;
		
	}
}
