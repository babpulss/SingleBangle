package recoder.single.bangle.Notice;

import java.sql.Timestamp;

public class NoticeDTO {

	private int seq;
	private String title;
	private String contents;
	private Timestamp writeDate;
	public NoticeDTO(int seq, String title, String contents, Timestamp writeDate) {
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.writeDate = writeDate;
	}
	public NoticeDTO() {
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
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
	@Override
	public String toString() {
		return "NoticeDTO [seq=" + seq + ", title=" + title + ", contents=" + contents + ", writeDate=" + writeDate
				+ "]";
	}
	
}
