package recoder.single.bangle.remarket.DTO;

public class MarketFileDTO {
	private int seq;
	private int board_seq;
	private String ori_name;
	private String sys_name;
	public MarketFileDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MarketFileDTO(int seq, int board_seq, String ori_name, String sys_name) {
		super();
		this.seq = seq;
		this.board_seq = board_seq;
		this.ori_name = ori_name;
		this.sys_name = sys_name;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public String getOri_name() {
		return ori_name;
	}
	public void setOri_name(String ori_name) {
		this.ori_name = ori_name;
	}
	public String getSys_name() {
		return sys_name;
	}
	public void setSys_name(String sys_name) {
		this.sys_name = sys_name;
	}
}
