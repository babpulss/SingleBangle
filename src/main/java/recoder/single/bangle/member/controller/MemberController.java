package recoder.single.bangle.member.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import recoder.single.bangle.member.DTO.MemberDTO;
import recoder.single.bangle.member.service.MemberService;
import recoder.single.bangle.tipBoard.DAO.BoardDAO;
import recoder.single.bangle.tipBoard.DTO.ScrapDTO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private MemberService memSvc;
	
	@Autowired
	private BoardDAO boardDao;
	
	@RequestMapping("/signUp.mem")
	public String signUp() {
		return "member/signUpForm";
	}
	
	@RequestMapping("/signUpProc.mem")
	public String signUpProc(MemberDTO dto, Model model) {
		int signUpResult = memSvc.signUp(dto);
		model.addAttribute("signUpResult", signUpResult);
		
		return "member/signUpCheck";
	}
	
	@RequestMapping(value = "/idDuplCheck.mem", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String idDuplCheck(String id) {
		int duplResult = memSvc.idDuplCheck(id);
		System.out.println(id + " 아이디 중복체크 : " + duplResult);
		System.out.println();
		return "{\"result\":" + duplResult + "}";
	}
	
	@RequestMapping("/login.mem")
	public String login(String id, String pw, Model model) {
		int loginResult = memSvc.login(id, pw);
		if(loginResult > 0) {
			MemberDTO dto = memSvc.getInfo(id);
			session.setAttribute("loginInfo", dto);
		}
		model.addAttribute("loginResult", loginResult);
		
		return "member/loginCheck";
	}
	
	@RequestMapping("/myInfo.mem")
	public String myInfo(Model model) {
		MemberDTO infoResult = memSvc.getInfo(((MemberDTO)session.getAttribute("loginInfo")).getId());
		model.addAttribute("infoResult", infoResult);
		return "member/myInfo";
	}
	
	@RequestMapping("/modifyInfo.mem")
	public String modifyInfo(Model model) {
		MemberDTO infoResult = memSvc.getInfo(((MemberDTO)session.getAttribute("loginInfo")).getId());
		model.addAttribute("infoResult", infoResult);
		return "member/modifyForm";
	}
	
	@RequestMapping("/modifyInfoProc.mem")
	public String modifyInfoProc(MemberDTO dto, Model model) {
		dto.setId(((MemberDTO)session.getAttribute("loginInfo")).getId());
		int updateResult = memSvc.modifyInfoProc(dto);
		model.addAttribute("updateResult", updateResult);
		
		return "member/modifyCheck";
	}
	
	@RequestMapping("/logout.mem")
	public String logout() {
		session.invalidate();
		
		return "member/logoutCheck";
	}
	
	@RequestMapping("/withdraw.mem")
	public String withdraw(Model model) {
		String id = ((MemberDTO) session.getAttribute("loginInfo")).getId();
		
		session.invalidate();
		int deleteResult = memSvc.withdraw(id);
		model.addAttribute("deleteResult", deleteResult);
		
		return "member/withdrawCheck";
	}
	
	@RequestMapping("/myScrap.mem")
	public String myScrap(String id, Model model) {
		List<ScrapDTO> myScrapList = new ArrayList<>();
		try {
			myScrapList = boardDao.myScrap(id);
			model.addAttribute("myScrapList", myScrapList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "member/myScrapList";
	}
}
