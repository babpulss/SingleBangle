package recoder.single.bangle.admin.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private HttpServletRequest request;

	// 관리자 페이지 진입
	@RequestMapping("")
	public String index() { return "admin/adminIndex"; }
	
	// 공지사항페이지로 이동
	@RequestMapping("/toNotice")
	public String toNotice() {
		return "admin/notice/notice";
	}
	
	// 공지사항 등록
	@RequestMapping("/addNotice")
	public String addNotice() {
		return "redirect:/admin/toNotice";
	}
}
