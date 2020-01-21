package recoder.single.bangle.admin.service;

import org.springframework.beans.factory.annotation.Autowired;

public class AdminService {

	@Autowired
	private BlackListService blackListService;
	
	@Autowired
	private ReportingService reportingService;
	
	// 블랙리스트 등록 (@Autowired가 요구됨)
	public boolean blockId(String id, String reason) {
		return blackListService.block(id, reason);
	}

	// 신고접수
	public boolean reporting(String id, String reason, String url) {
		return reportingService.addReporting(id, reason, url);
	}
	
}
