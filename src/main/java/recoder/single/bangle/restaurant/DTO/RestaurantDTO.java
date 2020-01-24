package recoder.single.bangle.restaurant.DTO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.springframework.web.multipart.MultipartFile;

public class RestaurantDTO {
	private int seq;
	private String writer;
	private String title;
	private String placeName;
	private String jibunAddr;
	private String roadAddr;
	private String placePhone;
	private String placeUrl;
	private String xPos;
	private String yPos;
	private Timestamp writeDate;
	private String approvalCheck;
	
	private String formedDate1;
	private MultipartFile[] files;
	private String[] contents;
	
	
	
	public RestaurantDTO() {
		super();
	}
	public RestaurantDTO(int seq, String writer, String title, String placeName, String jibunAddr, String roadAddr,
			String placePhone, String placeUrl, String xPos, String yPos, Timestamp writeDate, String approvalCheck) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.placeName = placeName;
		this.jibunAddr = jibunAddr;
		this.roadAddr = roadAddr;
		this.placePhone = placePhone;
		this.placeUrl = placeUrl;
		this.xPos = xPos;
		this.yPos = yPos;
		this.writeDate = writeDate;
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
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public String getJibunAddr() {
		return jibunAddr;
	}
	public void setJibunAddr(String jibunAddr) {
		this.jibunAddr = jibunAddr;
	}
	public String getRoadAddr() {
		return roadAddr;
	}
	public void setRoadAddr(String roadAddr) {
		this.roadAddr = roadAddr;
	}
	public String getPlacePhone() {
		return placePhone;
	}
	public void setPlacePhone(String placePhone) {
		this.placePhone = placePhone;
	}
	public String getPlaceUrl() {
		return placeUrl;
	}
	public void setPlaceUrl(String placeUrl) {
		this.placeUrl = placeUrl;
	}
	public String getxPos() {
		return xPos;
	}
	public void setxPos(String xPos) {
		this.xPos = xPos;
	}
	public String getyPos() {
		return yPos;
	}
	public void setyPos(String yPos) {
		this.yPos = yPos;
	}
	public Timestamp getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
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
	public void setFormedDate1(String formedDate1) {
		this.formedDate1 = formedDate1;
	}
	public String getFormedDate2() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		return sdf.format(this.writeDate);
	}
	
}
