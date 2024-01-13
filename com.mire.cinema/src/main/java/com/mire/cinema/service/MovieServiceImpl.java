package com.mire.cinema.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mire.cinema.domain.movie.Movie;
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
	public List<Movie> getList(){
		
		
		return movieMapper.getMovieList();
		
	};

}
