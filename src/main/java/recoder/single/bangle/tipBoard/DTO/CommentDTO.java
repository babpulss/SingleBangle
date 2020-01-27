package recoder.single.bangle.tipBoard.DTO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class CommentDTO {
	private int seq;
	private int rootSeq;
	private String writer;
	private String contents;
	private Timestamp writeDate;
	
	private String formedDate;
	
	public CommentDTO() {
		super();
	}

	public CommentDTO(int seq, int rootSeq, String writer, String contents, Timestamp writeDate) {
		super();
		this.seq = seq;
		this.rootSeq = rootSeq;
		this.writer = writer;
		this.contents = contents;
		this.writeDate = writeDate;
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

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
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

	public String getFormedDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd HH:mm");
		return sdf.format(this.writeDate);
	}
	
	public void setFormedDate(String formedDate) {
		this.formedDate = formedDate;
	}
	
	@Override
	public String toString() {
		return "CommentDTO [seq=" + seq + ", rootSeq=" + rootSeq + ", writer=" + writer + ", contents=" + contents
				+ ", writeDate=" + writeDate + "]";
	}
		
}
