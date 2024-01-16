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
		String uuid = "";
		String fileName = file.getOriginalFilename();
		uuid = getUuid(fileName);

		String path = getPath(uuid);
		Image img = Image.builder().imageName(fileName).imageUuid(uuid).imagePath(path).build();

		try {

			file.transferTo(new File(path));
		} catch (IllegalStateException | IOException e) {
			log.info(e.getMessage());
		}
		imageMapper.insertImage(img);

		return uuid;

	}

	@Override
	public Image findImage(String uuid) {

		return imageMapper.selectImage(uuid);
	}

	@Override
	public void modifyImage(Image image) {
		// TODO Auto-generated method stub

	}

	@Override
	public void removeImage(String uuid) {
		
		String path = getPath(uuid);
		
		File file = new File(path);
		file.delete();
		
		System.out.println("이미지이름" + uuid);
		imageMapper.deleteImage(uuid);
		System.out.println("확인" + uuid);

	}

	public String getPath(String uuidName) {
		String fullPath = "c:/SpringBootProject/cinema/com.mire.cinema/src/main/webapp/upload/" + uuidName;
		return fullPath;
	}

	public String getUuid(String fileName) {
		String uuid = "";
		String[] uuidNames = UUID.randomUUID().toString().split("-");

		for (String data : uuidNames) {
			uuid += data;
		}
		uuid += fileName.substring(fileName.lastIndexOf("."));
		
		return uuid;
	}

}
