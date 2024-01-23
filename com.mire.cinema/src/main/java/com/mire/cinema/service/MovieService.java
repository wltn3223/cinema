package com.mire.cinema.service;



import java.util.List;
import java.util.Map;

import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.domain.movie.MovieDTO;

public interface MovieService {
	public void saveMovie(Movie movie);
	public Movie findMovie(long movieNo);
	public void modifyMovie(MovieDTO.update update);
	public void removeMovie(long movieNo);
	public List<Movie> getTotalList();

	public Movie findSearchMovie(String movieTitle);
	public Map<String,Object> getPageMap(Integer pageNum , String movieTitle);
	public int getTotalMovie();
	public int getTotalMovie(String movieTitle);
	public int getTotalCount();
}
