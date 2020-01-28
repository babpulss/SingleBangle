package recoder.single.bangle.tipBoard.DTO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class ScrapDTO {
	private int seq;
	private int rootSeq;
	private int category;
	private String title;
	private String id;
	private Timestamp scrapDate;
	
	private String formedDate;

	public ScrapDTO() {
		super();
	}

	public ScrapDTO(int seq, int rootSeq, int category, String title, String id, Timestamp scrapDate) {
		super();
		this.seq = seq;
		this.rootSeq = rootSeq;
		this.category = category;
		this.title = title;
		this.id = id;
		this.scrapDate = scrapDate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getRootSeq() {
		return rootSeq;
	}

	public void setRootSeq(int rootSeq) {
		this.rootSeq = rootSeq;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Timestamp getScrapDate() {
		return scrapDate;
	}

	public void setScrapDate(Timestamp scrapDate) {
		this.scrapDate = scrapDate;
	}
	
	public String getFormedDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(this.scrapDate);
	}
	
}
