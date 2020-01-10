package recoder.single.bangle.admin.DTO;

import java.sql.Date;

public class Reporting {
	
	private int seq;
	private String id;
	private Date reportingDate;
	private String reason;
	private String url;
	
	public Reporting() {
	}

	public Reporting(int seq, String id, Date reportingDate, String reason, String url) {
		this.seq = seq;
		this.id = id;
		this.reportingDate = reportingDate;
		this.reason = reason;
		this.url = url;
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


	public Date getReportingDate() {
		return reportingDate;
	}


	public void setReportingDate(Date reportingDate) {
		this.reportingDate = reportingDate;
	}


	public String getReason() {
		return reason;
	}


	public void setReason(String reason) {
		this.reason = reason;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}

	@Override
	public String toString() {
		return "Report [seq=" + seq + ", id=" + id + ", reportingDate=" + reportingDate + ", reason=" + reason
				+ ", url=" + url + "]";
	}
	
}
