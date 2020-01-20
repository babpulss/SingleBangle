package recoder.single.bangle.admin.DTO;

import java.sql.Date;

public class BlackMemberDTO {

	private int seq;
	private String id;
	private Date addedDate;
	private String reason;
	private int blockTime;
	
	
	public BlackMemberDTO() {
	}


	public BlackMemberDTO(int seq, String id, Date addedDate, String reason, int blockTime) {
		this.seq = seq;
		this.id = id;
		this.addedDate = addedDate;
		this.reason = reason;
		this.blockTime = blockTime;
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


	public int getBlockTime() {
		return blockTime;
	}


	public void setBlockTime(int blockTime) {
		this.blockTime = blockTime;
	}


	@Override
	public String toString() {
		return "BlackMemberDTO [seq=" + seq + ", id=" + id + ", addedDate=" + addedDate + ", reason=" + reason
				+ ", blockTime=" + blockTime + "]";
	}
	
}
