package recoder.single.bangle.tipBoard.DAO;

public class PageMaker {
	private int totalCount; 	// 전체 게시물 개수
	private int pageNum;		// 현재 페이지 번호
	private int contentNum = 10;// 한 페이지에 몇개 표시할지 => '10'
	private int startPage = 1;	// 현재 페이지 블록의 시작 페이지
	private int endPage = 10;	// 현재 페이지 블록의 마지막 페이지
	private boolean prev = false;// 이전 페이지로 가는 화살표
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
	
	public void prevNext(int pageNum) {
		// 현재 페이지가 1p ~ 10p 이면, 즉 첫번째 블록에 있으면 prev가 안 보이게 함!
		if (pageNum > 0 && pageNum < 11) {
			setPrev(false);
			setNext(true);
		} else if (getLastBlock() == getCurrentBlock()) {
			// 현재 블록이 마지막 블록이면 next가 안 보이게 함!
			setPrev(true);
			setNext(false);
		} else {
			setPrev(true);
			setNext(true);
		}
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
		// 현재 블록이 마지막 블록이면, 전체 페이지 수가 마지막 페이지임!
		if (getLastBlock == getCurrentBlock) {
			this.endPage = calcPage(getTotalCount(), getContentNum());
		} else {
			// 그렇지 않다면, 한 블록에서 마지막 페이지는 시작 페이지에 9를 더한 것! => 시작이 1이면 끝은 10, 시작이 2이면 끝은 11 이런식...!
			this.endPage = getStartPage()+9;
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

	public void setCurrentBlock(int pageNum) {
		// 현지 페이지의 블록 번호는 현재 페이지 번호를 통해서 구함!
		this.currentBlock = pageNum/10;
		// 현재 페이지 번호(ex.13)를 10으로 나눈 값(1.3 -> 1)이 현재 블록인데, 만약 나머지가 있으면(0.3) 구해진 값에 +1 한다.  
		if(pageNum%10>0) {
			this.currentBlock++;
		}
	}

	public int getLastBlock() {
		return lastBlock;
	}

	public void setLastBlock(int totalCount) {
		// 한 페이지 블록 당, 10개의 게시물씩 & 10 단위로 네비게이터 출력 => 한 블록당 10*10 = 100 개의 글이 올라옴! 
		// 전체 게시글 개수를 100으로 나누면, 블록의 개수가 나옴! '블록의 개수 = 마지막 블록'
		this.lastBlock = totalCount / (10*this.contentNum);
		// 그런데 글의 수가 한 블록을 넘어간다면, 마지막 블록에 +1 을 한다.
		//블록 1//  1  2  3  4  5  6  7  8  9  10
		//블록 2//  11 12 13 14 15 16 17 18 19 20
		//블록 3//  21 22 23
		// ...
		//블록11// 101 102 103 104 ... 
		// 이런식으로 한다면,전체 글 개수가 104일때, 100으로 나누면 1.4 -> 1 이고, 나어지가 있으니까 마지막 블록은 2임.
		if(totalCount % (10*this.contentNum)>0) {
			this.lastBlock++;
		}
	}
	
}
