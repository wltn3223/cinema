package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.domain.movie.MovieDTO;

@Mapper
@Repository
public interface MovieMapper {
	void insertMovie(Movie Movie);
	Movie selectMovie(long movieNo);
	List<Movie> getTotalList();
	void updateMovie(Movie movie);
	void deleteMovie(long movieNo);

	List<MovieDTO.Movies>searchMovieList(MovieDTO.Search movieDTO);
	int countMovie();
	List<MovieDTO.Movies> getPartList(int start,int end);
	int countMovieTitle(String movieTitle);
	int countSearchMovie(String movieTitle);
	Movie getSearchMovie(String movieTitle);
}
