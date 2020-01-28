package recoder.single.bangle.movie.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import recoder.single.bangle.movie.tool.KakaoAPI;

@Component
public class MovieScheduler {
	@Autowired
	private KakaoAPI kakao;

	/*
	@Scheduled(fixedRate = 60000)
	public void test() {
		System.out.println("1분");
		try {
			kakao.deleteMovie();
			kakao.insertMovie();
		} catch (Exception e) {			
			e.printStackTrace();
		}	
	}*/
	/*
	//@Scheduled(cron = "0 10 00 * * ?")
	@Scheduled(cron= "0 35 20 1/1 * ? *")
	public void myJob() {
		try {
			kakao.deleteMovie();
			kakao.insertMovie();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
*/
}
