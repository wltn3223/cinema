package com.mire.cinema.domain.movie;

import java.util.Date;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class Movie {
		private long movieNo;
	 	private String movieTitle;
	    private String movieIntro;
	    private String movieActors;
	    private String movieGenre;
	    private int moviePlayTime;
	    private int movieLimit;
	    private Date movieDate;
	    private String imageUuid;
}
