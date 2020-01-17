package recoder.single.bangle.movie.tool;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.movie.DTO.MovieDTO;
import recoder.single.bangle.movie.service.MovieService;


@Service
public class KakaoAPI {	
	@Autowired 
	private MovieService movieService;

	public int deleteMovie() throws Exception {
		return movieService.deleteMovie();
	}
	
	public void insertMovie() throws Exception {
		String baseUrl = "https://movie.daum.net/premovie/released";
		URL url = new URL(baseUrl);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		// https를 호출시 user-agent 필수
		con.setRequestProperty("User-Agent", "Mozilla/5.0 Chrome/79.0.3945.88 Safari/537.36"); 

		BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String temp = null;
		int page = 0;

		while ((temp = br.readLine()) != null ) {				
			//페이지 정규식
			Pattern pagePattern = Pattern.compile("(class=\"num_page\">)([0-9])");
			Matcher pageMatcher = pagePattern.matcher(temp);

			while (pageMatcher.find()) {
				System.out.println(pageMatcher.group(2));
				page = Integer.parseInt(pageMatcher.group(2));
			}	
		}

		List<MovieDTO> list = new ArrayList<>();


		for(int i = 1; i<page +1; i++) {
			String pageURL =  baseUrl + "?opt=reserve&page=" + i;
			url = new URL(pageURL);
			con = (HttpURLConnection) url.openConnection();
			// https를 호출시 user-agent 필수
			con.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36\""); 

			br = new BufferedReader(new InputStreamReader(con.getInputStream()));

			String temp2 = null;
			String html = null;
			while ((temp2 = br.readLine()) != null ) {		
				html += temp2;
			}

			System.out.println(pageURL);

			List<String> titleList = new ArrayList<>();
			List<Double> gradeList = new ArrayList<>(); 
			List<String> rateList = new ArrayList<>(); 
			List<String> releaseDateList = new ArrayList<>(); 
			List<String> imgList = new ArrayList<>(); 
			List<String> storyList = new ArrayList<>();

			//영화 제목 정규식
			Pattern titlePattern = Pattern.compile("(class=\"name_movie #title\">)(.+?)<\\/a>");
			Matcher titleMatcher = titlePattern.matcher(html);
			while (titleMatcher.find()) {
				titleList.add(titleMatcher.group(2));
			}

			//포스터
			Pattern imgPattern = Pattern.compile("<img src=\"([A-Za-z0-9\\/.=:?]*)\" class=\"img_g\"");
			Matcher imgMatcher = imgPattern.matcher(html);
			while(imgMatcher.find()) {
				imgList.add(imgMatcher.group(1));
			}

			//평점
			Pattern gradePattern = Pattern.compile("<span class=\"wrap_grade grade_netizen\">\\s+<span class=\"ico_star ico_14star\">등급</span>\\s+<span class=\"num_grade num_[0-9]{2}\">([0-9]{2})</span>\\s+<span class=\"num_grade grade_dot\">.</span>\\s+<span class=\"num_grade num_[0-9]{2}\">([0-9]{2})");
			Matcher gradeMatcher = gradePattern.matcher(html);
			String grades = "";
			while(gradeMatcher.find()) {
				grades += gradeMatcher.group(1);
				grades += "." + gradeMatcher.group(2).substring(1);
				//gradeList.add(Double.parseDouble(gradeMatcher.group(3)));
			}
			for (int j = 0; j < titleList.size()*4; j+=4) {
				gradeList.add(Double.parseDouble(grades.substring(j, j+4))); 
			}

			//개봉일
			Pattern releaseDatePattern = Pattern.compile("<span class=\"info_state\">\\s*(.+?)개봉\\s+(<span .+?</span>\\s+예매율 (.+?)\\s+){0,1}</span>");
			Matcher releaseDateMatcher = releaseDatePattern.matcher(html); 
			while(releaseDateMatcher.find()) {
				releaseDateList.add("20" + releaseDateMatcher.group(1).replace(" 재", "").replace(".", "-").replace(" ", ""));
			}

			//예매율
			Pattern ratePattern = Pattern.compile("<span class=\\\"info_state\\\">\\s*(.+?)개봉\\s+(<span .+?</span>\\s+예매율 (.+?)\\s+){0,1}</span>");
			Matcher rateMatcher = ratePattern.matcher(html);
			while(rateMatcher.find()) {
				String rate = rateMatcher.group(3);
				if(rate == null) {
					rate = "0%";
				}
				rateList.add(rate);
			}

			//				//전체와 예매율 개수 차이가 있다면 0%로 추가
			//				int titleSize = titleList.size();
			//				int rateSize = rateList.size();
			//				if(titleSize != rateSize) {
			//					int result = titleSize - rateSize;
			//					for (int j = 0; j < result; j++) {
			//						rateList.add("0%");
			//					}
			//				}

			//영화 줄거리
			Pattern storyPattern = Pattern
					.compile("class=\\\"desc_movie #synop\\\">(.+?)</a>");
			Matcher storyMatcher = storyPattern.matcher(html);
			while(storyMatcher.find()) {
				storyList.add(storyMatcher.group(1).replaceAll("^\\s+", ""));
			}

			for (int j = 0; j < titleList.size(); j++) {
				String title = titleList.get(j);
				Double grade = gradeList.get(j);
				String rate = rateList.get(j);
				String releaseDate = releaseDateList.get(j);
				String videoId = KakaoAPI.searchRegex(title);
				//String videoId = KakaoAPI.tvSearch(title);
				String img = imgList.get(j);
				String story = storyList.get(j);

				list.add(new MovieDTO(title, grade, rate, releaseDate, videoId, img, story));
			} 
		}
		movieService.insertMovie(list);
	}

	public static String tvSearch(String title) throws Exception{
		String baseUrl = "https://tv.kakao.com/search/cliplinks";
		baseUrl += "?q=" + URLEncoder.encode(title + " 예고편", "UTF-8");

		Document doc = null;
		List<MovieDTO> list = new ArrayList<>();

		try {
			doc = Jsoup.connect(baseUrl).get();
		}catch (Exception e) {
			e.printStackTrace();
		}

		String video = doc.select(".link_itembox").get(0).select("a[href]").attr("href");

		Pattern p = Pattern.compile("\\/channel\\/([0-9]+)\\/cliplink\\/([0-9]+)");
		Matcher m = p.matcher(video);

		String videoId = null;
		while (m.find()) {
			videoId = m.group(2);
		}
		return videoId;
	}

	public static String searchRegex(String title) throws Exception {
		String baseUrl = "https://tv.kakao.com/search/cliplinks";
		baseUrl += "?q=" + URLEncoder.encode(title + " 예고편", "UTF-8");

		URL url = new URL(baseUrl);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestProperty("User-Agent", "Mozilla/5.0 Chrome/79.0.3945.88 Safari/537.36"); 

		BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String temp = null;
		String videoId = null;
		while ((temp = br.readLine()) != null ) {				
			Pattern pagePattern = Pattern.compile("<a href=\"/channel/462787/cliplink/(.+)\" class=\"link_itembox\">");
			Matcher pageMatcher = pagePattern.matcher(temp);

			if(pageMatcher.find()) {
				videoId = pageMatcher.group(1);
			}	
		}
		return videoId;
	}
}