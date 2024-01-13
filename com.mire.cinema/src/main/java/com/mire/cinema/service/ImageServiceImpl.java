package com.mire.cinema.service;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mire.cinema.domain.image.Image;
import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.ImageMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RequiredArgsConstructor
@Service
public class ImageServiceImpl implements ImageService {

	@Value("${upload.path}")
	private String uploadPath;
	private final ImageMapper imageMapper;

	@Override
	public String saveImage(MultipartFile file) {
		
		String fileName = file.getOriginalFilename();
		String uuidName = UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));
		String path = getPath(uuidName);
		
		Image img = Image.builder()
		.imageName(fileName)
		.imageUuid(uuidName)
		.imagePath(path).build();
		
	
			try {
				file.transferTo(new File((path)));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				log.info("파일 입출력에러");
			}
			imageMapper.insertImage(img);
		
			return uuidName;

	}


	@Override
	public Image findImage(int lmageNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void modifyImage(Image image) {
		// TODO Auto-generated method stub

	}

	@Override
	public void removeImage(int lmageNo) {
		// TODO Auto-generated method stub

	}

	public String getPath(String uuidName) {
		String fullPath = uploadPath + uuidName;
		return fullPath;
	}
	
	
}
