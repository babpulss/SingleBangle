package recoder.single.bangle.member.DTO;

public class MemberDTO {
	private String id;
	private String pw;
	private String name;
	private String gender;
	private String phone;
	private String email;
	private String postcode;
	private String address1;
	private String address2;
	private String adminCheck;
	private String blackCheck;



	public MemberDTO() {
		super();
	}
	public MemberDTO(String id, String pw, String name, String gender, String phone, String email, String postcode,
			String address1, String address2, String adminCheck, String blackCheck) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.gender = gender;
		this.phone = phone;
		this.email = email;
		this.postcode = postcode;
		this.address1 = address1;
		this.address2 = address2;
		this.adminCheck = adminCheck;
		this.blackCheck = blackCheck;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getAdminCheck() {
		return adminCheck;
	}
	public void setAdminCheck(String adminCheck) {
		this.adminCheck = adminCheck;
	}
	public String getBlackCheck() {
		return blackCheck;
	}
	public void setBlackCheck(String blackCheck) {
		this.blackCheck = blackCheck;
	}
	
	public String getRealGender() {
		if(this.gender.equals("M")) {
			return "남";
		}
		else {
			return "여";
		}
	}
	
	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", pw=" + pw + ", name=" + name + ", gender=" + gender + ", phone=" + phone
				+ ", email=" + email + ", postcode=" + postcode + ", address1=" + address1 + ", address2=" + address2
				+ ", adminCheck=" + adminCheck + ", blackCheck=" + blackCheck + "]";
	}
	
}
