package recoder.single.bangle.remarket.DTO;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class MarketDTO {
	private int seq;
	private String title;
	private int price;
	private String content;
	private String writer;
	private String category;
	private String place;
	private Timestamp writeDate;
	private int viewCount;
	private String done;
	private MultipartFile[] file;
	private String gender;
	public MarketDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MarketDTO(int seq, String title, int price, String content, String writer, String category, String place,
			Timestamp writeDate, int viewCount, String done, MultipartFile[] file, String gender) {
		super();
		this.seq = seq;
		this.title = title;
		this.price = price;
		this.content = content;
		this.writer = writer;
		this.category = category;
		this.place = place;
		this.writeDate = writeDate;
		this.viewCount = viewCount;
		this.done = done;
		this.file = file;
		this.gender = gender;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
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
	public String getDone() {
		return done;
	}
	public void setDone(String done) {
		this.done = done;
	}
	public MultipartFile[] getFile() {
		return file;
	}
	public void setFile(MultipartFile[] file) {
		this.file = file;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
}
