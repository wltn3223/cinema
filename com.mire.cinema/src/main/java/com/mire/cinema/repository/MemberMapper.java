package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.movie.Movie;




@Repository
@Mapper
public interface MemberMapper {
   
	void insertMember(Member member);
    Member selectMember(String memberId);

    List<Member> getMemberList();
    void deleteMember(String id);

    void updateMember(MemberDTO.Update dto);
    
    int countMember();
    
    int countsearchMember(String memberId);
    
    List<Member> getPartList(int start,int end);
    
    List<Member> searchPartList(MemberDTO.search dto);

}
