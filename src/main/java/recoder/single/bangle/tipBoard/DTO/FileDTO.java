package recoder.single.bangle.tipBoard.DTO;

public class FileDTO {
	private int seq;
	private int rootSeq;
	private String fileName;
	private String oriFileName;
	
	public FileDTO() {
		super();
	}

	public FileDTO(int seq, int rootSeq, String fileName, String oriFileName) {
		super();
		this.seq = seq;
		this.rootSeq = rootSeq;
		this.fileName = fileName;
		this.oriFileName = oriFileName;
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

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOriFileName() {
		return oriFileName;
	}

	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}
	
}
