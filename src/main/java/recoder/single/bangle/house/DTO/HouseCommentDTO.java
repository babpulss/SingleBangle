package recoder.single.bangle.house.DTO;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.ibatis.javassist.expr.NewArray;

public class HouseCommentDTO {
	private int seq;
	private int houseSeq;
	private String writer;
	private String content;
	private String wirteDate;
	
	public HouseCommentDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public HouseCommentDTO(int seq, int houseSeq, String writer, String content, String wirteDate) {
		super();
		this.seq = seq;
		this.houseSeq = houseSeq;
		this.writer = writer;
		this.content = content;
		this.wirteDate = wirteDate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getHouseSeq() {
		return houseSeq;
	}

	public void setHouseSeq(int houseSeq) {
		this.houseSeq = houseSeq;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWirteDate() {
		return wirteDate;
	}
	

	public void setWirteDate(String wirteDate) {
		this.wirteDate = wirteDate;
	}

	@Override
	public String toString() {
		return "HouseCommentDTO [seq=" + seq + ", houseSeq=" + houseSeq + ", writer=" + writer + ", content=" + content
				+ ", wirteDate=" + wirteDate + "]";
	}

	
}
