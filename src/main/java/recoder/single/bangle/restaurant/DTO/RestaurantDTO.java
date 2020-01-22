package recoder.single.bangle.restaurant.DTO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.springframework.web.multipart.MultipartFile;

public class RestaurantDTO {
	private int seq;
	private String writer;
	private String title;
	private Timestamp writeDate;
	private int viewCount;
	private String approvalCheck;
	
	private MultipartFile[] files;
	private String[] contents;
	
	
	
	public RestaurantDTO() {
		super();
	}
	public RestaurantDTO(int seq, String writer, String title, Timestamp writeDate, int viewCount, String approvalCheck) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.writeDate = writeDate;
		this.viewCount = viewCount;
		this.approvalCheck = approvalCheck;
	}
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Timestamp getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public String getApprovalCheck() {
		return approvalCheck;
	}
	public void setApprovalCheck(String approvalCheck) {
		this.approvalCheck = approvalCheck;
	}
	
	public MultipartFile[] getFiles() {
		return files;
	}
	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}
	public String[] getContents() {
		return contents;
	}
	public void setContents(String[] contents) {
		this.contents = contents;
	}
	
	public String getFormedDate1() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		return sdf.format(this.writeDate);
	}
	public String getFormedDate2() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		return sdf.format(this.writeDate);
	}
	
}
