package recoder.single.bangle.remarket.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import utils.Configuration;
import recoder.single.bangle.member.DTO.MemberDTO;
import recoder.single.bangle.remarket.DAO.MsgDAO;
import recoder.single.bangle.remarket.DTO.MsgDTO;
import recoder.single.bangle.remarket.service.MsgService;
import utils.Configuration;

@Controller
@RequestMapping("/msg")
public class MsgController {
	
	@Autowired
	private MsgService service;
	
	@Autowired
	private HttpSession session;

	@Autowired
	private HttpServletRequest request;
	
	@Autowired
	private MsgDAO dao;
	
	@RequestMapping("/writeMsg.do")
	public String writeMsg(Model model) {
		String receiver = request.getParameter("receiver");
		model.addAttribute("receiver", receiver);
		System.out.println("쪽지 보내기 도착");
		return "msg/writemsg";
	}
	
	@RequestMapping("/replyMsgProc.do")//서비스ok
	public String replyMsgProc(MsgDTO dto) {
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		String sender = loginInfo.getId();
		String receiver = dto.getReceiver();
		String title = dto.getTitle();
		String contents = dto.getContents();
		System.out.println("1 : " + contents);
		title = title.replaceAll("<script", "&lt;script");
		contents = contents.replaceAll("<script", "&lt;script");
		System.out.println(contents);
		//내용 전부 들어옴ㅇㅇ
		try {
			service.writeMsg(dto, title, contents, sender);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/msg/msgList.do?receiver="+sender;
	}
	
	@RequestMapping("/msgList.do")//메세지 리스트 확인하기
	public String msgList(Model model) {
		try {
			String receiver = (String)request.getParameter("receiver");
			String navi = dao.getPageNavi(1, receiver);
			int cpage=1;
			String page = request.getParameter("cpage");
			if(page != null) {
				cpage = Integer.parseInt(page);
			}
			int start = cpage * Configuration.recordCountPerPage - (Configuration.recordCountPerPage -1);
			int end = cpage * Configuration.recordCountPerPage;
			List<MsgDTO> list = dao.selectByPage(start, end, receiver);
//			List<MsgDTO> list = service.msgList(receiver);
			model.addAttribute("navi", navi);
			model.addAttribute("list", list);
			return "msg/msgbox";
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping("/msgDetail.do")//메세지상세
	public String msgDetail(int seq, Model model) {
		try {
			MsgDTO dto = service.msgDetail(seq);
			model.addAttribute("dto", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "msg/msgdetail";
	}

	@RequestMapping("/replyMsg.do")
	public String replyMsg() {
		return "msg/writemsg";
	}
}
