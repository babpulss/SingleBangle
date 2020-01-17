package recoder.single.bangle.movie.DTO;

public class MovieDTO {
	private String title;
	private Double grade;
	private String rate;
	private String releaseDate;
	private String videoId;
	private String img;
	private String story;
	
	
	
	public MovieDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MovieDTO(String title, Double grade, String rate, String releaseDate, String videoId, String img,
			String story) {
		super();
		this.title = title;
		this.grade = grade;
		this.rate = rate;
		this.releaseDate = releaseDate;
		this.videoId = videoId;
		this.img = img;
		this.story = story;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Double getGrade() {
		return grade;
	}

	public void setGrade(Double grade) {
		this.grade = grade;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(String releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getVideoId() {
		return videoId;
	}

	public void setVideoId(String videoId) {
		this.videoId = videoId;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getStory() {
		return story;
	}

	public void setStory(String story) {
		this.story = story;
	}

	@Override
	public String toString() {
		return "MovieDTO [title=" + title + ", grade=" + grade + ", rate=" + rate + ", releaseDate=" + releaseDate
				+ ", videoId=" + videoId + ", img=" + img + ", story=" + story + ", getTitle()=" + getTitle()
				+ ", getGrade()=" + getGrade() + ", getRate()=" + getRate() + ", getReleaseDate()=" + getReleaseDate()
				+ ", getVideoId()=" + getVideoId() + ", getImg()=" + getImg() + ", getStory()=" + getStory()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}
	
}
