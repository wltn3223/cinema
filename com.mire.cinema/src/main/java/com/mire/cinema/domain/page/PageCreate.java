package com.mire.cinema.domain.page;

import lombok.Data;

@Data
public class PageCreate {
	
	private Page paging;
	private int totalBoardCount;
	private int endPage;
	private int beginPage;
	private boolean prev;
	private boolean next;
	
	private final int buttonNum = 5;
	
	private void calcDataOfPage() {
		endPage = (int)(Math.ceil(paging.getPageNum()/(double)buttonNum) * buttonNum);
		
		beginPage = endPage - buttonNum + 1 ;
		
		prev = (beginPage == 1) ? false:true;
		
		next = totalBoardCount <= (endPage * paging.getCountPerPage()) ? false:true;
		
		if(!next) {
			endPage = (int)Math.ceil(totalBoardCount/(double)paging.getCountPerPage())  ;
		} 
		
	}
	
	public void setArticleTotalCount(int totalBoardCount) {
		this.totalBoardCount = totalBoardCount;
		calcDataOfPage();
	}
	public PageCreate getPage(int pageNum, int totalCount) {
		Page page = new Page();
		page.setPageNum(pageNum, 6);  // 현재 페이지와 페이지 몇개 보여줄지 설정
		
		PageCreate pc = new PageCreate();
		pc.setPaging(page);
		pc.setArticleTotalCount(totalCount);
		
		return pc;
	}
	

}