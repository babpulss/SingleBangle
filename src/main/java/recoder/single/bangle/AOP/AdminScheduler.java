package recoder.single.bangle.AOP;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class AdminScheduler {

	@Autowired
	private SqlSessionTemplate sst;
	
	@Scheduled(cron="0 0 0 * * *")
	public void blockedId() {
		sst.update("Admin.reduceTime");
		sst.delete("Admin.checkBlockTime");
	}
}
