package recoder.single.bangle.house.DTO;

public class HouseDTO {
	private int seq;
	private String writer;
	private String title;
	private String writeDate;
	private int viewCount;
	
	public HouseDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public HouseDTO(int seq, String writer, String title, String writeDate, int viewCount) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.writeDate = writeDate;
		this.viewCount = viewCount;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	@Override
	public String toString() {
		return "HouseDTO [seq=" + seq + ", writer=" + writer + ", title=" + title + ", writeDate=" + writeDate
				+ ", viewCount=" + viewCount + "]";
	}
}
