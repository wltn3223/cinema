package com.mire.cinema.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.mire.cinema.domain.image.Image;






public interface ImageService {
	
	public String saveImage(MultipartFile file);


	public Image findImage(int lmageNo);

	public void modifyImage(Image image);
	
	public void removeImage(int lmageNo);
}
