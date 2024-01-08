package com.mire.cinema.repository.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.Member;




@Repository
@Mapper
public interface MemberMapper {
   
	void saveMember(Member member);
    Member findMemberbyId(String id);

    List<Member> getMemberList();
    void deleteMember(Member member);

    void updateMember(Member member);
}
