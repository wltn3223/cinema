package com.mire.cinema.domain.page;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Page {
	
	private int pageNum;
	private int countPerPage ;  // 갯수
	
	
	private int startNum;
	private int endNum;
	
	
	public void calStartNum() {
		
		if(this.pageNum != 1) {
			this.startNum = (this.pageNum -1) * countPerPage + 1;
			this.endNum = startNum + countPerPage -1;
			
		}
		else if(this.pageNum == 1) {
			this.startNum = 1;
			this.endNum = countPerPage;
		}
		
		
	}
	
	
	public void setPageNum(int pageNum, int countPerPage) {
		this.countPerPage = countPerPage;
		this.pageNum = pageNum;
		calStartNum();
	}
	
	
	//검색에 필요한 데이터를 변수로 선언.
		private String keyword;
		private String condition;
		
	
}
