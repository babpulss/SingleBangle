package recoder.single.bangle.tipBoard.DTO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BoardDTO {
	private int seq;
	private int category;
	private String writer;
	private String title;
	private String contents;
	private Timestamp writeDate;
	private int viewCount;
	private int scrapCount;
	private int likeCount;
	private int countSeq;
	
	private String formedDate;
	
	public BoardDTO() {
		super();
	}

	public BoardDTO(int seq, int category, String writer, String title, String contents, Timestamp writeDate,
			int viewCount, int scrapCount, int likeCount, int countSeq) {
		super();
		this.seq = seq;
		this.category = category;
		this.writer = writer;
		this.title = title;
		this.contents = contents;
		this.writeDate = writeDate;
		this.viewCount = viewCount;
		this.scrapCount = scrapCount;
		this.likeCount = likeCount;
		this.countSeq = countSeq;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
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

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Timestamp getWriteDate() {
		return writeDate;
	}
	
	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}
	
	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public int getScrapCount() {
		return scrapCount;
	}

	public void setScrapCount(int scrapCount) {
		this.scrapCount = scrapCount;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	public int getCountSeq() {
		return countSeq;
	}
	
	public void setCountSeq(int countSeq) {
		this.countSeq = countSeq;
	}
	
	public String getFormedDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(this.writeDate);
	}

	@Override
	public String toString() {
		return "BoardDTO [seq=" + seq + ", category=" + category + ", writer=" + writer + ", title=" + title
				+ ", contents=" + contents + ", writeDate=" + writeDate + ", viewCount=" + viewCount + ", scrapCount="
				+ scrapCount + ", likeCount=" + likeCount + ", countSeq=" + countSeq + "]";
	}

}
