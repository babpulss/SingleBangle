package recoder.single.bangle.admin.DTO;

import java.sql.Date;

public class ReportingDTO {
	
	private int seq;
	private String id;
	private Date reportingDate;
	private String reason;
	private String reportedUrl;
	private String confirmReporting;
	private Date confirmDate;
	
	public ReportingDTO() {
	}

	public ReportingDTO(int seq, String id, Date reportingDate, String reason, String reportedUrl,
			String confirmReporting, Date confirmDate) {
		this.seq = seq;
		this.id = id;
		this.reportingDate = reportingDate;
		this.reason = reason;
		this.reportedUrl = reportedUrl;
		this.confirmReporting = confirmReporting;
		this.confirmDate = confirmDate;
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

	public String getReportedUrl() {
		return reportedUrl;
	}

	public void setReportedUrl(String reportedUrl) {
		this.reportedUrl = reportedUrl;
	}

	public String getConfirmReporting() {
		return confirmReporting;
	}

	public void setConfirmReporting(String confirmReporting) {
		this.confirmReporting = confirmReporting;
	}

	public Date getConfirmDate() {
		return confirmDate;
	}

	public void setConfirmDate(Date confirmDate) {
		this.confirmDate = confirmDate;
	}

}
