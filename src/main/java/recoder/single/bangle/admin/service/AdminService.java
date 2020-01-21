package recoder.single.bangle.admin.service;

import org.springframework.beans.factory.annotation.Autowired;

public class AdminService {

	@Autowired
	private ReportingService reportingService;
	
	// 신고접수
	public boolean reporting(String id, String reason, String url) {
		return reportingService.addReporting(id, reason, url);
	}
	
}
