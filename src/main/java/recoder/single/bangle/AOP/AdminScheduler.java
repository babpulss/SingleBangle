package recoder.single.bangle.AOP;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import recoder.single.bangle.movie.tool.KakaoAPI;

@Component
public class AdminScheduler {

	@Autowired
	private SqlSessionTemplate sst;
	
	@Autowired
	private KakaoAPI kakao;

	@Scheduled(cron="0 0 * * * *")
	public void blockedId() {
		sst.update("Admin.reduceTime");
		sst.delete("Admin.checkBlockTime");
	}
	
	
	@Scheduled(cron= "0 35 20 1-31 * ?")
	public void myJob() {
		try {
			kakao.deleteMovie();
			kakao.insertMovie();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
