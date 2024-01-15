package com.mire.cinema.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.domain.movie.MovieDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.ImageService;
import com.mire.cinema.service.MovieService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
@Log
@RequiredArgsConstructor
@RestController
@RequestMapping("/movie")
public class MovieContoller {
	private final MovieService movieService;
	private final ImageService imageService;
	
	
	@PostMapping
	public ResponseEntity<String> saveMovie(@Valid MovieDTO.Save dto, BindingResult bindingResult,@RequestParam(name = "file",required = false) MultipartFile movieImage
			, HttpServletRequest request) {
		if(bindingResult.hasErrors()) {
			throw new IllegalArgumentException(bindingResult.getFieldErrors().get(0).getDefaultMessage());
		}
		

		if(movieImage == null) {
			throw new NullPointerException(ErrorMsg.IMAGENOTFOUND);
		}
		String uuidName = imageService.saveImage(movieImage);
		
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
        
        LocalDate parsedDate = LocalDate.parse(dto.getMovieDate().toString(), formatter);
  
		
		
		log.info(dto.getMovieDate().toString());
		Movie movie = Movie.builder()
				.movieTitle(dto.getMovieTitle())
				.movieIntro(dto.getMovieIntro())
				.movieActors(dto.getMovieActors())
				.movieGenre(dto.getMovieGenre())
				.moviePlayTime(Integer.parseInt(dto.getMoviePlayTime()))
				.movieLimit(Integer.parseInt(dto.getMovieLimit()))
				.movieDate(parsedDate)
				.imageUuid(uuidName)
				.build();
				
		
		log.info("날짜:" + dto.getMovieDate().toString());
		
		movieService.saveMovie(movie);
	
		log.info(dto.toString());
		log.info( "path =" + request.getContextPath());
		
		
		return new ResponseEntity<>(SucessMsg.INSERT,HttpStatus.OK);
	}
	@GetMapping("/list/{pageNum}")
	public ResponseEntity<Map<String,Object>> getMovieList(@PathVariable Integer pageNum){
		log.info(pageNum.toString());
		
		
		
		return new ResponseEntity<>(movieService.getPageMap(pageNum),HttpStatus.OK);
		
	}
	@GetMapping("/{movieNo}")
	public ResponseEntity<Movie> getMovie(@PathVariable Integer movieNo){
		
		
		if(movieNo == null) {
			throw new NullPointerException(ErrorMsg.BADTYPE);
		}
		
		
	
		
		return new ResponseEntity<>(movieService.findMovie(movieNo),HttpStatus.OK);
		
	}
	@PostMapping("/update")
	 public String updateMovie(MovieDTO.update movie ,  MultipartFile file){
		log.info("name"+movie.getMovieTitle());
		log.info(file.toString());
		log.info(file.getOriginalFilename());
	
	
		return "성공";
	}
	
	
	
	
	
}
