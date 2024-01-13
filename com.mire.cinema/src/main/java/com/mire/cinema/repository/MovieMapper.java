package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.image.Image;
import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.movie.Movie;

@Mapper
@Repository
public interface MovieMapper {



	void insertMovie(Movie Movie);
	Image selectMovie(int movieNo);

    List<Movie> getTotalList();
    
    void deleteMovie(int movieNo);

    void updateMovie(Movie movie);
    
    int countMovie();
    
    List<Movie> getPartList(int start,int end);




	

}
