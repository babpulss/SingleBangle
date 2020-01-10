package recoder.single.bangle.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import recoder.single.bangle.admin.DTO.BlackMember;
import recoder.single.bangle.admin.service.BlackListService;

@Controller
@RequestMapping("/admin")
public class BlackList {

	@Autowired
	private BlackListService blackListService;
	
	@Autowired
	private Model m;
	
	// 블랙리스트 진입
	@RequestMapping("/viewBlackList")
	public String viewBlackList() {
		List<BlackMember> list = blackListService.getBlackList();
		m.addAttribute("list", list);
		return "admin/blackList";
	}

}
