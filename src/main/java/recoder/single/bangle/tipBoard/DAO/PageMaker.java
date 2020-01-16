package recoder.single.bangle.tipBoard.DAO;

public class PageMaker {
	private int totalCount; 	// 전체 게시물 개수
	private int pageNum;		// 전체 페이지 번호
	private int contentNum;		// 한 페이지에 몇개 표시할지 => '10'
	private int startPage;		// 현재 페이지 블록의 시작 페이지
	private int endPage;		// 현재 페이지 블록의 마지막 페이지
	private boolean prev;		// 이전 페이지로 가는 화살표
	private boolean next;		// 다음 페이지로 가는 화살표
	private int currentBlock;	// 현재 페이지 블록
	private int lastBlock;		// 마지막 페이지 블록

	public PageMaker() {
		super();
	}

	public PageMaker(int totalCount, int pageNum, int contentNum, int startPage, int endPage, boolean prev,
			boolean next, int currentBlock, int lastBlock) {
		super();
		this.totalCount = totalCount;
		this.pageNum = pageNum;
		this.contentNum = contentNum;
		this.startPage = startPage;
		this.endPage = endPage;
		this.prev = prev;
		this.next = next;
		this.currentBlock = currentBlock;
		this.lastBlock = lastBlock;
	}

	// 전체 페이지 수를 계산하는 함수 : 전체 게시글을 한 페이지에 표시할 게시글의 수로 나눠서 구함! 이때, 나머지가 0보다 클 때는(ex:12.5) 또 1을 더해줌!
	public int calcPage(int totalCount, int contentNum) {
		int totalPage = totalCount / contentNum;
		if (totalCount % contentNum > 0) {
			totalPage++;
		}
		return totalPage;
	}
	
	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getContentNum() {
		return contentNum;
	}

	public void setContentNum(int contentNum) {
		this.contentNum = contentNum;
	}

	public int getStartPage() {
		return startPage;
	}
	// 현재 페이지 블록의 시작 페이지
	public void setStartPage(int currentBlock) {
		this.startPage = (currentBlock*10)-9;
		//현재블록: 1 // 1  2  3  4  5  6  7  8  9 10 -> 시작페이지: 1
		//현재블록: 2 //11 12 13 14 15 16 17 18 19 20 -> 시작페이지: 11
		//현재블록: 3 //21 22 23 24 25 26 27 28 29 30 -> 시작페이지: 21
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int getLastBlock, int getCurrentBlock) {
		if (getLastBlock == getCurrentBlock) {
			this.endPage = calcPage(getTotalCount(), getContentNum());
		} else {
			this.endPage = endPage;
		}
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getCurrentBlock() {
		return currentBlock;
	}

	public void setCurrentBlock(int currentBlock) {
		this.currentBlock = currentBlock;
	}

	public int getLastBlock() {
		return lastBlock;
	}

	public void setLastBlock(int lastBlock) {
		this.lastBlock = lastBlock;
	}
	
}
