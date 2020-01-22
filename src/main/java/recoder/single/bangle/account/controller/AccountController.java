package recoder.single.bangle.account.controller;

import java.sql.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import recoder.single.bangle.account.DTO.AccountDTO;
import recoder.single.bangle.account.service.AccountService;
import recoder.single.bangle.account.service.PdfService;

@RequestMapping("/accountBook")
@Controller
public class AccountController {
	@Autowired
	HttpSession session;
	
	@Inject
	PdfService pdfService;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	AccountService accService;
	

	
	@RequestMapping("/account")
	public String accountIndex() {
		return "accountBook/accountIndex";
	}
	
//	가계부 월별 리스트
	@RequestMapping("/accountBook")
	public String account() {
		
		session.setAttribute("id", "shinikho");		
		try {
			List<AccountDTO> list = accService.monthListById(session);
			session.setAttribute("userName",list.get(0).getUserName());
			System.out.println(session.getAttribute("userName"));
			request.setAttribute("list", list);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "error";
		}
		
		return "accountBook/accountBook";
	}
//	가계부 상세리스트
	@RequestMapping("/detailAccount")
	public String detailAccount(HttpServletRequest req) {
		String formedDate = (String)req.getParameter("formedReportingDate");
		session.setAttribute("formedDate", formedDate);
		int cashSum = 0;
		int cardSum = 0;
		int in = 0;
		int out = 0;
		String name;
		try {
			List<AccountDTO> list = accService.ListAllByFormedReportingDate(session,formedDate);
			cashSum = accService.cashSummary(list);
			cardSum = accService.cardSummary(list);
			in = accService.incomeSummary(list);
			out = accService.outcomeSummary(list);
			name = accService.getUserName(list);
			request.setAttribute("name", name);
			request.setAttribute("cashSum", cashSum);
			request.setAttribute("cardSum", cardSum);
			request.setAttribute("in", in);
			request.setAttribute("out", out);
			request.setAttribute("formedDate", formedDate);
			request.setAttribute("list", list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "error";
		}		
		
		return "accountBook/detailAccountBook";
	}
	
	@RequestMapping("/Account.add")
	public String insertAccount(AccountDTO dto) {
		String id = (String)session.getAttribute("id");
		String userName = (String)session.getAttribute("userName");		
		int price = Integer.parseInt(request.getParameter("price"));
		AccountDTO dtos = new AccountDTO();
		if(dto.getSpec().equals("수입")) {
			dto.setIncome(price);
			dtos = new AccountDTO(0, id, userName, dto.getReportingDate(), null, dto.getDetails(), dto.getPayments(), dto.getSpec(), dto.getIncome(), 0, dto.getRemarks());
			System.out.println(dtos);		 
		}else {
			dto.setExpense(price);
			dtos = new AccountDTO(0, id, userName, dto.getReportingDate(), null, dto.getDetails(), dto.getPayments(), dto.getSpec(), 0, dto.getExpense(), dto.getRemarks());
			System.out.println(dtos);
		}
		accService.insertAccountData(dtos);
		
		return "redirect:accountBook";
	}
	
	@RequestMapping("/ListViewForPDF")
	public String listViewForPDF() {
		int cashSum = 0;
		int cardSum = 0;
		int in = 0;
		int out = 0;
		String formedDate = (String)session.getAttribute("formedDate");
		String name;
		try {
			List<AccountDTO> list = accService.ListAllByFormedReportingDate(session,formedDate);
			cashSum = accService.cashSummary(list);
			cardSum = accService.cardSummary(list);
			in = accService.incomeSummary(list);
			out = accService.outcomeSummary(list);
			name = accService.getUserName(list);
			request.setAttribute("name", name);
			request.setAttribute("cashSum", cashSum);
			request.setAttribute("cardSum", cardSum);
			request.setAttribute("in", in);
			request.setAttribute("out", out);
			request.setAttribute("formedDate", formedDate);
			request.setAttribute("list", list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "error";
		}		
		
		return "accountBook/pdfAccountView";
	}
	
	@RequestMapping("/accountPDF")
	public void accountPDFprint(HttpServletRequest req,HttpServletResponse resp,String pdfValue) {
		
		pdfService.createPdf(req, resp, pdfValue);
	}
	
	@RequestMapping("/deleteAccountByMonth")
	public String deleteAccountMonth() {
		String formedReportingDate = request.getParameter("formedReportingDate");
		
		int result = accService.deleteAccountByMonth(formedReportingDate);
		if(result>0) {
			return "redirect:accountBook";
		}
		
		return "error";
	}
	
	@RequestMapping("/deleteAccountBySeq.do")
	public String deleteAccountSeq() {
		int seq = Integer.parseInt(request.getParameter("seq"));
		System.out.println(seq);
		return null;
	}
	
	@RequestMapping("/modifyAccount")
	public String modifyAccount(AccountDTO dto) {
		dto.setId((String)session.getAttribute("id"));
		dto.setUserName((String)session.getAttribute("userName"));
		System.out.println("controller"+dto);
		int result = accService.modifyAccountData(dto);
		if(result>0) {
			String formedDate = (String)session.getAttribute("formedDate");
			int cashSum = 0;
			int cardSum = 0;
			int in = 0;
			int out = 0;
			String name;
			try {
				List<AccountDTO> list = accService.ListAllByFormedReportingDate(session,formedDate);
				cashSum = accService.cashSummary(list);
				cardSum = accService.cardSummary(list);
				in = accService.incomeSummary(list);
				out = accService.outcomeSummary(list);
				name = accService.getUserName(list);
				System.out.println(cashSum + " : " + cardSum);
				request.setAttribute("name", name);
				request.setAttribute("cashSum", cashSum);
				request.setAttribute("cardSum", cardSum);
				request.setAttribute("in", in);
				request.setAttribute("out", out);
				request.setAttribute("formedDate", formedDate);
				request.setAttribute("list", list);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
			
			return "accountBook/detailAccountBook";
		}else {
			return "error";
		}
	}
}
