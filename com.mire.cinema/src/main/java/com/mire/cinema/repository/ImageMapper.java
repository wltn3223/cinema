package com.mire.cinema.repository;

import java.util.List;	

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.image.Image;
import com.mire.cinema.domain.member.Member;

@Mapper
@Repository
public interface ImageMapper {

	void insertImage(Image Image);
	Image selectImage(String uuid);

    List<Member> getMemberList();
    void deleteImage(String uuid);

  
}


