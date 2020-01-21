package recoder.single.bangle.restaurant.DTO;

public class RestaurantFileDTO {
	private int seq;
	private int rootSeq;
	private String oriName;
	private String sysName;
	private String contents;
	
	
	
	public RestaurantFileDTO() {
		super();
	}
	public RestaurantFileDTO(int seq, int rootSeq, String oriName, String sysName, String contents) {
		super();
		this.seq = seq;
		this.rootSeq = rootSeq;
		this.oriName = oriName;
		this.sysName = sysName;
		this.contents = contents;
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
	public String getOriName() {
		return oriName;
	}
	public void setOriName(String oriName) {
		this.oriName = oriName;
	}
	public String getSysName() {
		return sysName;
	}
	public void setSysName(String sysName) {
		this.sysName = sysName;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}

}
