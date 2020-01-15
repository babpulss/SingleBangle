package recoder.single.bangle.remarket.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import recoder.single.bangle.remarket.service.MsgService;

@Controller
@RequestMapping("/msg")
public class MsgController {
	
	@Autowired
	private MsgService service;
	
	@Autowired
	private HttpSession session;

	@Autowired
	private HttpServletRequest request;
	
	@RequestMapping("/writeMsg.do")
	public String writeMsg(Model model) {
		String receiver = request.getParameter("receiver");
		model.addAttribute("receiver", receiver);
		System.out.println("쪽지 보내기 도착");
		return "msg/writemsg";
	}
	
	@RequestMapping("/replyMsgProc.do")
	public String replyMsgProc() {
		String sender = (String) session.getAttribute("id");
		String receiver = request.getParameter("receiver");
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		try {
			service.writeMsg(sender, receiver, title, contents);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "home";
	}
}
