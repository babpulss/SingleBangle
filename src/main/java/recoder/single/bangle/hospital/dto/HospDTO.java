package recoder.single.bangle.hospital.dto;

public class HospDTO {
	private String hospName;  // yadmNm, 병원명
	private String type;  // clCdNm, 종별코드명 - (ex : 종합병원) 
	private String addr;  // addr, 주소 
	private String telNo;  // telno, 전화번호
	private String url;  // hospUrl, 홈페이지
	private String xPos;  // XPos, x좌표
	private String yPos;  // YPos, y좌표
	
	
	
	public HospDTO() {
		super();
	}
	public HospDTO(String hospName, String type, String addr, String telNo, String url, String xPos, String yPos) {
		super();
		this.hospName = hospName;
		this.type = type;
		this.addr = addr;
		this.telNo = telNo;
		this.url = url;
		this.xPos = xPos;
		this.yPos = yPos;
	}
	
	public String getHospName() {
		return hospName;
	}
	public void setHospName(String hospName) {
		this.hospName = hospName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
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
	
	@Override
	public String toString() {
		return "HospitalDTO [hospName=" + hospName + ", type=" + type + ", addr=" + addr + ", telNo=" + telNo + ", url="
				+ url + ", xPos=" + xPos + ", yPos=" + yPos + "]";
	}
	
}

