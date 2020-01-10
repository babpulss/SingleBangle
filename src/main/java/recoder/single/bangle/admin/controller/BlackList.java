package recoder.single.bangle.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import recoder.single.bangle.admin.DTO.BlackMember;
import recoder.single.bangle.admin.service.BlackListService;

@Controller
@RequestMapping("/admin")
public class BlackList {

	@Autowired
	private BlackListService blackListService;
	
	// 블랙리스트 진입
	@RequestMapping("/viewBlackList")
	public String viewBlackList(Model m) {
		List<BlackMember> list = blackListService.getBlackList();
		m.addAttribute("list", list);
		return "admin/blackList";
	}

	// 블랙리스트 해제
	@RequestMapping(value="/unblock", produces="text/html; charset=UTF-8")
	@ResponseBody
	public void unblock(String id, HttpServletResponse res) {
//		blackListService.unblock(id);
		try {
			res.getWriter().print(true);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}