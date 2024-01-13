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
	
	private int pageNum = 1;
	private int countPerPage = 18;
	
	
	private int startNum = 1;
	private int endNum = 18;
	
	
	public void calStartNum() {
		
		if(this.pageNum != 1) {
			this.startNum = (this.pageNum -1) * countPerPage + 1;
			this.endNum = startNum + countPerPage -1;
			
		}
		
		
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
		calStartNum();
	}
	
	
	//검색에 필요한 데이터를 변수로 선언.
		private String keyword;
		private String condition;
		
	
}
