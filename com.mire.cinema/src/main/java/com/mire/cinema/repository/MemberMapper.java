package com.mire.cinema.repository;

import java.util.List;	

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.member.Member;




@Repository
@Mapper
public interface MemberMapper {
   
	void insertMember(Member member);
    Member selectMember(String memberId);

    List<Member> getMemberList();
    void deleteMember(String id);

    void updateMember(Member member);
}
