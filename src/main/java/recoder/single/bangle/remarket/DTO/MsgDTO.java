package recoder.single.bangle.remarket.DTO;

public class MsgDTO {
	private int seq;
	private String sender;
	private String receiver;
	private String title;
	private String contents;
	private int viewCount;
	public MsgDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MsgDTO(int seq, String sender, String receiver, String title, String contents, int viewCount) {
		super();
		this.seq = seq;
		this.sender = sender;
		this.receiver = receiver;
		this.title = title;
		this.contents = contents;
		this.viewCount = viewCount;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
}
