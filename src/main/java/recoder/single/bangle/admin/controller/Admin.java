package recoder.single.bangle.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import recoder.single.bangle.admin.DTO.BlackMemberDTO;
import recoder.single.bangle.admin.service.BlackListService;
import recoder.single.bangle.admin.service.ReportingService;

@Controller
@RequestMapping("/admin")
public class Admin {

	@Autowired
	private BlackListService blackListService;

	@Autowired
	private ReportingService reportingService;
	
	@RequestMapping("")
	public String adminIndex() {
		return "admin/adminIndex";
	}
	// 블랙리스트 진입
	@RequestMapping("/viewBlackList")
	public String viewBlackList(Model m) {
		List<BlackMemberDTO> list = blackListService.getBlackList();
		m.addAttribute("list", list);
		return "admin/blackList";
	}

	// 블랙리스트 해제
	@RequestMapping(value="/unblock", produces="text/html; charset=UTF-8")
	@ResponseBody
	public void unblock(String id, HttpServletResponse res) {
		boolean result = blackListService.unblock(id);
		try { res.getWriter().print(result);
		} catch(Exception e) { e.printStackTrace(); }
	}
	
	// 블랙리스트 등록 (@Autowired가 요구됨)
	public boolean block(String id, String reason) {
		return blackListService.block(id, reason);
	}
	
	// 아이디로 블랙리스트 조회
	@RequestMapping(value="/searchByBlockedId", produces="text/html; charset=UTF-8")
	@ResponseBody
	public void searchByBlockedId(String id, HttpServletResponse res) {
		List<BlackMemberDTO> list = blackListService.searchByBlockedId(id);
		try { 
			new Gson().toJson(list, res.getWriter());
		} catch(Exception e) { e.printStackTrace(); }
	}
	
	// 신고접수리스트 보기
	@RequestMapping("/viewReporting")
	public String viewReporting(Model m) {
		List<recoder.single.bangle.admin.DTO.ReportingDTO> list = reportingService.getReportingList();
		m.addAttribute("list", list);
		return "admin/hasReported";
	}
	
	// 신고접수 완료
	@RequestMapping("/confirmReporting")
	@ResponseBody
	public void confirmReporting(int seq, HttpServletResponse res) {
		boolean result = reportingService.confirmReporting(seq); 
		try { res.getWriter().print(result);
		} catch(Exception e) { e.printStackTrace(); }
	}
	
	// 신고접수
	public boolean reporting(String id, String reason, String url) {
		return reportingService.addReporting(id, reason, url);
	}
}
