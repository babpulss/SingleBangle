package recoder.single.bangle.account.controller;

import java.io.FileInputStream;
import java.io.StringReader;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

import recoder.single.bangle.account.DTO.AccountDTO;
import recoder.single.bangle.account.service.AccountService;
import recoder.single.bangle.account.service.PdfService;

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
		}		
		
		return "accountBook/detailAccountBook";
	}
	
	@ResponseBody
	@RequestMapping("/Account.add")
	public String insertAccount(AccountDTO dto) {
		String id = (String)session.getAttribute("id");
		String userName = (String)session.getAttribute("userName");		
		int price = Integer.parseInt(request.getParameter("price"));
		AccountDTO dtos = new AccountDTO();
		System.out.println(dto.getSpec());
		if(dto.getSpec().equals("수입")) {
			dto.setIncome(price);
			dtos = new AccountDTO(0, id, userName, dto.getReportingDate(), null, dto.getDetails(), dto.getPayments(), dto.getSpec(), dto.getIncome(), 0, dto.getRemarks());
			System.out.println(dtos);		 
		}else {
			dto.setExpense(price);
			dtos = new AccountDTO(0, id, userName, dto.getReportingDate(), null, dto.getDetails(), dto.getPayments(), dto.getSpec(), 0, dto.getExpense(), dto.getRemarks());
			System.out.println(dtos);
		}
		int result = accService.insertAccountData(dtos);
		if(result > 0) {
			try {
				List<AccountDTO> list = accService.monthListById(session);
				return new Gson().toJson(list);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
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
		}		
		
		return "accountBook/pdfAccountView";
	}
	
	@RequestMapping("/accountPDF")
	public void accountPDFprint(HttpServletRequest req,HttpServletResponse resp,String pdfValue) {
		
		pdfService.createPdf(req, resp, pdfValue);
	}
	
}
