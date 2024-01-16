package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.image.Image;
import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.domain.movie.MovieDTO;

@Mapper
@Repository
public interface MovieMapper {



	void insertMovie(Movie Movie);
	Movie selectMovie(long movieNo);

    List<Movie> getTotalList();
    
    void deleteMovie(long movieNo);

    void updateMovie(Movie movie);
    
    int countMovie();
    
    List<MovieDTO.Movies> getPartList(int start,int end);




	

}
