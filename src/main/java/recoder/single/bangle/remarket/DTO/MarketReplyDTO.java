package recoder.single.bangle.remarket.DTO;

import java.sql.Timestamp;

public class MarketReplyDTO {
	private int seq;
	private String recontent;
	private Timestamp writeDate;
	private String writer;
	private int boardSeq;
	public MarketReplyDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MarketReplyDTO(int seq, String recontent, Timestamp writeDate, String writer, int boardSeq) {
		super();
		this.seq = seq;
		this.recontent = recontent;
		this.writeDate = writeDate;
		this.writer = writer;
		this.boardSeq = boardSeq;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getRecontent() {
		return recontent;
	}
	public void setRecontent(String recontent) {
		this.recontent = recontent;
	}
	public Timestamp getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(int boardSeq) {
		this.boardSeq = boardSeq;
	}
}
