package recoder.single.bangle.hospital.dto;

public class HospCodeDTO {
	private String addrCd;
	private String addrCdNm;
	
	
	
	public HospCodeDTO() {
		super();
	}
	public HospCodeDTO(String addrCd, String addrCdNm) {
		super();
		this.addrCd = addrCd;
		this.addrCdNm = addrCdNm;
	}
	
	public String getAddrCd() {
		return addrCd;
	}
	public void setAddrCd(String addrCd) {
		this.addrCd = addrCd;
	}
	public String getAddrCdNm() {
		return addrCdNm;
	}
	public void setAddrCdNm(String addrCdNm) {
		this.addrCdNm = addrCdNm;
	}
	
}
