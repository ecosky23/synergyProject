package member.bean;

import org.springframework.stereotype.Service;

import lombok.Data;

@Data
@Service
public class Pagination {
	private int listSize = 7;                //초기값으로 목록개수를 10으로 셋팅

	private int rangeSize = 5;            //초기값으로 페이지범위를 10으로 셋팅

	private int page;

	private int range;

	private int listCnt;

	private int pageCnt;

	private int startPage;

	private int startList;

	private int endPage;

	private boolean prev;

	private boolean next;

	private boolean first;
	
	private boolean last;


	public void pageInfo(int page, int range, int listCnt) {

		this.page = page;

		this.range = range;

		this.listCnt = listCnt;

		

		//전체 페이지수 

		this.pageCnt = (int) Math.ceil((double)listCnt/listSize);

		

		//시작 페이지

		this.startPage = (range - 1) * rangeSize + 1 ;

		

		//끝 페이지

		this.endPage = range * rangeSize;

				

		//게시판 시작번호

		this.startList = (page - 1) * listSize;

		

		//이전 버튼 상태

		this.prev = range == 1 ? false : true;

		

		//다음 버튼 상태

		this.next = pageCnt > endPage ? true : false;

		if (this.endPage > this.pageCnt) {

			this.endPage = this.pageCnt;

			this.next = false;

		}
		
		//맨 처음으로
		
		this.first = page == 1 ? false : true;
				
				
		//맨 마지막으로
				
		this.last = pageCnt == page ? false : true;

	}



}
