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
		try {
		List<BlackMemberDTO> list = blackListService.getBlackList();
		m.addAttribute("list", list);
		return "admin/blackList";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 블랙리스트 해제
	@RequestMapping(value="/unblock", produces="text/html; charset=UTF-8")
	@ResponseBody
	public String unblock(String id, HttpServletResponse res) {
		try {
		return String.valueOf(blackListService.unblock(id));
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 아이디로 블랙리스트 조회
	@RequestMapping(value="/searchByBlockedId", produces="text/html; charset=UTF-8")
	@ResponseBody
	public String searchByBlockedId(String id) {
		try {
		BlackMemberDTO dto = blackListService.searchByBlockedId(id);
			return new Gson().toJson(dto);
		} catch(Exception e) { e.printStackTrace(); }
		return "error";
	}

	// 신고접수리스트 보기
	@RequestMapping("/viewReporting")
	public String viewReporting(Model m) {
		try { 
		List<recoder.single.bangle.admin.DTO.ReportingDTO> list = reportingService.getReportingList();
		m.addAttribute("list", list);
		return "admin/hasReported";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 신고접수 완료
	@RequestMapping("/confirmReporting")
	@ResponseBody
	public String confirmReporting(int seq) {
		try { 
		return String.valueOf(reportingService.confirmReporting(seq)); 
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// 아이디 검색으로 블랙리스트 추가
	@RequestMapping("/searchId")
	public String searchId(String id, Model m) {
		try {
			int checkId = blackListService.checkId(id);
			if (checkId != 0) {
				m.addAttribute("checkId", checkId);
			} else {
				m.addAttribute("dto", blackListService.searchId(id));
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "admin/searchId";
	}
	
	@RequestMapping("/block")
	public String block(BlackMemberDTO dto, Model m) {
		try { 
		Boolean result = blackListService.block(dto);
		if (result) {
			m.addAttribute("result", "추가완료");
		} else {
			m.addAttribute("result", "추가에 실패했습니다");
		}
		return "/admin/blockResult";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
	
}
