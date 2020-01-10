package recoder.single.bangle.admin.DTO;

import java.sql.Date;

public class BlackMemberDTO {

	private int seq;
	private String id;
	private Date addedDate;
	private String reason;
	
	
	public BlackMemberDTO() {
	}

	public BlackMemberDTO(int seq, String id, Date addedDate, String reason) {
		this.seq = seq;
		this.id = id;
		this.addedDate = addedDate;
		this.reason = reason;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getAddedDate() {
		return addedDate;
	}

	public void setAddedDate(Date addedDate) {
		this.addedDate = addedDate;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	@Override
	public String toString() {
		return "BlackMember [seq=" + seq + ", id=" + id + ", addedDate=" + addedDate + ", reason=" + reason + "]";
	}
	
}
