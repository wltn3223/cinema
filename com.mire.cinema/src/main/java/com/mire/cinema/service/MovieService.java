package com.mire.cinema.service;



import java.util.List;
import java.util.Map;

import com.mire.cinema.domain.movie.Movie;

public interface MovieService {
	
	public void saveMovie(Movie movie);
	public Movie findMovie(int movieNo);
	public void modifyMovie(Movie movie);
	public void removeMovie(int movieNo);
	public int getTotalCount();
	public List<Movie> getTotalList();
	public List<Movie> getPartList(int start, int end);
	public Map<String,Object> getPageMap(Integer pageNum);
}
