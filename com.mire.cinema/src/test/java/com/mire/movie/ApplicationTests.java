package com.mire.movie;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.stereotype.Repository;
import org.springframework.test.context.ContextConfiguration;

import com.mire.cinema.Application;
import com.mire.cinema.domain.member.Member;
import com.mire.cinema.repository.mapper.MemberMapper;

import lombok.extern.java.Log;

@Log
@SpringBootTest
@ContextConfiguration(classes = Application.class)
class ApplicationTests {

	@Autowired
	MemberMapper memberMapper;
	
	

	@Test
	void contextLoads() {
		

	}

}