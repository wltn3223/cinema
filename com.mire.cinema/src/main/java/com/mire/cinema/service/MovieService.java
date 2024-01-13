package com.mire.cinema.service;



import java.util.List;

import com.mire.cinema.domain.movie.Movie;

public interface MovieService {
	
	public void saveMovie(Movie movie);
	public Movie findMovie(int movieNo);
	public void modifyMovie(Movie movie);
	public void removeMovie(int movieNo);
	
	public List<Movie> getList();

}
