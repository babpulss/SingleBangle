package recoder.single.bangle.member.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import recoder.single.bangle.member.DTO.MemberDTO;
import recoder.single.bangle.member.service.MemberService;
import recoder.single.bangle.remarket.service.MsgService;
import recoder.single.bangle.tipBoard.DAO.BoardDAO;
import recoder.single.bangle.tipBoard.DTO.ScrapDTO;
import utils.EncryptionUtils;
import utils.XSSprotect;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private MemberService memSvc;
	
	@Autowired
	private BoardDAO boardDao;
	
	@Autowired
	private MsgService msgService;
	
	
	
	@RequestMapping("/signUp.mem")
	public String signUp() {
		return "member/signUpForm";
	}
	
	@RequestMapping("/signUpProc.mem")
	public String signUpProc(MemberDTO dto, Model model) {
		String pw = dto.getPw();
		dto.setPw(EncryptionUtils.encrypt(pw));
		
		String address2 = dto.getAddress2();
		dto.setAddress2(XSSprotect.replaceParameter(address2));
		
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
	public String login() {
		return "member/login";
	}
	
	@RequestMapping("/loginProc.mem")
	public String loginProc(String id, String pw, Model model) {
		int loginResult = memSvc.login(id, EncryptionUtils.encrypt(pw));
		if(loginResult > 0) {
			MemberDTO dto = memSvc.getInfo(id);
			session.setAttribute("loginInfo", dto);
		}
		model.addAttribute("loginResult", loginResult);
		
		return "member/loginCheck";
	}
	
	@RequestMapping("/findId.mem")
	public String findId() {
		return "member/findId";
	}
	
	@RequestMapping("/findIdResult.mem")
	public String findIdResult(String name, String phone, Model model) {
		List<String> findIdResult = memSvc.findIdResult(name, phone);
		model.addAttribute("findIdResult", findIdResult);
		System.out.println(findIdResult.size());
		
		return "member/findIdResult";
	}
	
	@RequestMapping("/findPw.mem")
	public String findPw() {
		return "member/findPw";
	}
	
	@RequestMapping("/myPage.mem")
	public String memberHome() {
		return "member/myPage";
	}
	
	@RequestMapping("/myInfo.mem")
	public String myInfo(Model model) {
		MemberDTO infoResult = memSvc.getInfo(((MemberDTO)session.getAttribute("loginInfo")).getId());
		model.addAttribute("infoResult", infoResult);
		
		return "member/myInfo";
	}
	
	@RequestMapping("/modifyInfo.mem")
	public String modifyInfo() {
		return "member/modifyVerify";
	}
	
	@RequestMapping("/modifyInfoForm.mem")
	public String modifyInfoForm(String pw, Model model) {
		String id = ((MemberDTO) session.getAttribute("loginInfo")).getId();
		int pwCheckResult = memSvc.pwCheck(id, EncryptionUtils.encrypt(pw));
		model.addAttribute("pwCheckResult", pwCheckResult);
		
		if(pwCheckResult > 0) {
			MemberDTO infoResult = memSvc.getInfo(((MemberDTO)session.getAttribute("loginInfo")).getId());
			model.addAttribute("infoResult", infoResult);
		}
		
		return "member/modifyForm";
	}
	
	@RequestMapping("/modifyInfoProc.mem")
	public String modifyInfoProc(MemberDTO dto, Model model) {
		dto.setId(((MemberDTO)session.getAttribute("loginInfo")).getId());
		String pw = dto.getPw();
		dto.setPw(EncryptionUtils.encrypt(pw));
		
		String address2 = dto.getAddress2();
		dto.setAddress2(XSSprotect.replaceParameter(address2));
		
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
	public String withdraw() {
		return "member/withdrawVerify";
	}
	
	@RequestMapping("/withdrawProc.mem")
	public String withdrawProc(String pw, Model model) {
		String id = ((MemberDTO) session.getAttribute("loginInfo")).getId();
		int pwCheckResult = memSvc.pwCheck(id, EncryptionUtils.encrypt(pw));
		
		int deleteResult = 0;
		if(pwCheckResult > 0) {
			session.invalidate();
			deleteResult = memSvc.withdraw(id);			
		}
		model.addAttribute("deleteResult", deleteResult);
		
		return "member/withdrawCheck";
	}
	
	@RequestMapping("/myScrap.mem")
	public String myScrap(@RequestParam(value="currentPage")String currentPage_, Model model) {
		List<ScrapDTO> myScrapList = new ArrayList<>();
		String id = ((MemberDTO) session.getAttribute("loginInfo")).getId();
		try {
			int currentPage;
			if (currentPage_ == null) currentPage = 1;
			else currentPage = Integer.parseInt(currentPage_);

			int totalScraps = boardDao.myScrapCount(id);
			int totalPage = totalScraps / 10 + 1;

			if (currentPage <= 0) currentPage = 1;
			else if (currentPage > totalPage) currentPage = totalPage;

			myScrapList = boardDao.myScrap(id, currentPage);
			String pagination = memSvc.myScrapPagination(totalScraps, currentPage);
			model.addAttribute("pagination", pagination);

			model.addAttribute("myScrapList", myScrapList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "member/myScrapList";
	}
}
