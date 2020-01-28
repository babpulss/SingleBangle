package recoder.single.bangle.house.DTO;

public class HouseContentDTO {
	private int seq;
	private int houseSeq;
	private String imgTitle;
	private String imgContent;
	private String sysName;
	private String oriName;

	
	public HouseContentDTO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public HouseContentDTO(int seq, int houseSeq, String imgTitle, String imgContent, String sysName, String oriName) {
		super();
		this.seq = seq;
		this.houseSeq = houseSeq;
		this.imgTitle = imgTitle;
		this.imgContent = imgContent;
		this.sysName = sysName;
		this.oriName = oriName;
	}


	public int getSeq() {
		return seq;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}


	public int getHouseSeq() {
		return houseSeq;
	}


	public void setHouseSeq(int houseSeq) {
		this.houseSeq = houseSeq;
	}


	public String getImgTitle() {
		return imgTitle;
	}


	public void setImgTitle(String imgTitle) {
		this.imgTitle = imgTitle;
	}


	public String getImgContent() {
		return imgContent;
	}


	public void setImgContent(String imgContent) {
		this.imgContent = imgContent;
	}


	public String getSysName() {
		return sysName;
	}


	public void setSysName(String sysName) {
		this.sysName = sysName;
	}


	public String getOriName() {
		return oriName;
	}


	public void setOriName(String oriName) {
		this.oriName = oriName;
	}


	@Override
	public String toString() {
		return "HouseContentDTO [seq=" + seq + ", houseSeq=" + houseSeq + ", imgTitle=" + imgTitle + ", imgContent="
				+ imgContent + ", sysName=" + sysName + ", oriName=" + oriName + "]";
	}

	
	
}