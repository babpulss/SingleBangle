package recoder.single.bangle.account.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import recoder.single.bangle.account.DTO.AccountDTO;
import recoder.single.bangle.account.component.AccountComponent;
import recoder.single.bangle.account.service.AccountService;

@Controller
public class AccountController {
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	AccountService accService;
	
	@Autowired
	AccountComponent component;
	
	@RequestMapping("/account")
	public String accountIndex() {
		return "accountBook/accountIndex";
	}
	
//	가계부 월별 리스트
	@RequestMapping("/accountBook")
	public String account() {
		
		session.setAttribute("id", "shinikho");
		session.setAttribute("userName", "신익호");
		System.out.println(session.getAttribute("userName"));
		try {
			List<AccountDTO> list = accService.monthListById(session);
			request.setAttribute("list", list);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "accountBook/accountBook";
	}
//	가계부 상세리스트
	@RequestMapping("/detailAccount")
	public String detailAccount(HttpServletRequest req) {
		String formedDate = (String)req.getParameter("formedReportingDate");
		int incomeSUM =0;
		int expenseSUM =0;
		try {
			List<AccountDTO> list = accService.ListAllByFormedReportingDate(session,formedDate);
			Map<String, Integer> sum = component.summary(list);
			for(AccountDTO tmp : list) {
				incomeSUM += tmp.getIncome();
				expenseSUM += tmp.getExpense();
			}
			Date mon = list.get(0).getReportingDate();
			SimpleDateFormat months = new SimpleDateFormat("MM");
			String month = months.format(mon);
			request.setAttribute("month", month);
			request.setAttribute("incomeSUM", incomeSUM);
			System.out.println(incomeSUM);
			System.out.println(expenseSUM);
			request.setAttribute("expenseSUM", expenseSUM);
			request.setAttribute("list", list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return "accountBook/detailAccountBook";
	}
	
}
