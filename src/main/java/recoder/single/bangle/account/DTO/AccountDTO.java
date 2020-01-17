package recoder.single.bangle.account.DTO;

import java.sql.Date;

public class AccountDTO {

	private int seq;			// 시퀀스
	private String id;			// 회원ID
	private String userName;	// 회원명
	private Date reportingDate;	// 작성일자
	private String formedReportingDate;
	private String details;		// 상세
	private String payments;	// 결제방식
	private String spec;		// 수입/지출
	private int income;			// 수입(원)
	private int expense;		// 지출(원)
	private String remarks;		// 비고

	public AccountDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AccountDTO(int seq, String id, String userName, Date reportingDate, String formedReportingDate,
			String details, String payments, String spec, int income, int expense, String remarks) {
		super();
		this.seq = seq;
		this.id = id;
		this.userName = userName;
		this.reportingDate = reportingDate;
		this.formedReportingDate = formedReportingDate;
		this.details = details;
		this.payments = payments;
		this.spec = spec;
		this.income = income;
		this.expense = expense;
		this.remarks = remarks;
	}

	public AccountDTO(String formedReportingDate, int income, int expense) {
		super();
		this.formedReportingDate = formedReportingDate;
		this.income = income;
		this.expense = expense;
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getReportingDate() {
		return reportingDate;
	}

	public void setReportingDate(Date reportingDate) {
		this.reportingDate = reportingDate;
	}

	public String getFormedReportingDate() {
		return formedReportingDate;
	}

	public void setFormedReportingDate(String formedReportingDate) {
		this.formedReportingDate = formedReportingDate;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getPayments() {
		return payments;
	}

	public void setPayments(String payments) {
		this.payments = payments;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}

	public int getIncome() {
		return income;
	}

	public void setIncome(int income) {
		this.income = income;
	}

	public int getExpense() {
		return expense;
	}

	public void setExpense(int expense) {
		this.expense = expense;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}


	@Override
	public String toString() {
		return "AccountDTO [seq=" + seq + ", id=" + id + ", userName=" + userName + ", reportingDate=" + reportingDate
				+ ", formedReportingDate=" + formedReportingDate + ", details=" + details + ", payments=" + payments
				+ ", spec=" + spec + ", income=" + income + ", expense=" + expense + ", remarks=" + remarks + "]";
	}


}
