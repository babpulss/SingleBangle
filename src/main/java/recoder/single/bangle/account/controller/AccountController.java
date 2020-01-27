package recoder.single.bangle.account.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFDataFormat; // 데이터 포맷
import org.apache.poi.hssf.usermodel.HSSFWorkbook;	// 워크북 
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined; // 컬러
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import recoder.single.bangle.account.DTO.AccountDTO;
import recoder.single.bangle.account.service.AccountService;
import recoder.single.bangle.account.service.PdfService;
import recoder.single.bangle.member.DTO.MemberDTO;

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
		return "index";
	}
	
//	가계부 월별 리스트
	@RequestMapping("/accountBook")
	public String account() {
		MemberDTO dto = (MemberDTO)session.getAttribute("loginInfo");
		String id = dto.getId();
		String name = dto.getName();
		
		try {
			List<AccountDTO> list = accService.monthListById(session);
			session.setAttribute("userName",name);
			session.setAttribute("id",id);
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
		String formedDate;
		if(req.getParameter("formedReportingDate")!=null) {
			formedDate = (String)req.getParameter("formedReportingDate");
			session.setAttribute("formedDate", formedDate);			
		}else {
			formedDate = (String)session.getAttribute("formedDate");
		}
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
		MemberDTO memberdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = memberdto.getId();
		String userName = memberdto.getName();		
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
		int seq = Integer.parseInt(request.getParameter("deleteSeq"));
		int result = accService.deleteAccountBySeq(seq);
		if(result > 0) {
		return "redirect:detailAccount";
		}else {
			return "error";
		}
	}
	
	@RequestMapping("/modifyAccount")
	public String modifyAccount(AccountDTO dto) {
		MemberDTO memberdto = (MemberDTO)session.getAttribute("loginInfo");
		dto.setId(memberdto.getId());
		dto.setUserName(memberdto.getName());
		if(dto.getSpec().equals("수입")&&dto.getExpense()!=0) {
			dto.setIncome(dto.getExpense());
			dto.setExpense(0);
		}else if(dto.getSpec().equals("지출")&&dto.getIncome()!=0){
			dto.setExpense(dto.getIncome());
			dto.setIncome(0);
		}
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
	
	@RequestMapping("/excelDownload")
	public void excelDownload(HttpServletRequest req, HttpServletResponse resp) {
		String formedDate = (String)session.getAttribute("formedDate");
		session.setAttribute("formedDate", formedDate);
		try {
			List<AccountDTO> list = accService.ListAllByFormedReportingDate(session,formedDate);
			
			// 워크북 생성
			Workbook wb = new HSSFWorkbook();
			Sheet sheet = wb.createSheet(formedDate+" 가계부");
			Row row = null;
			Cell cell = null;
			int rowNo = 0;
			int incomeSum=0;
			int expenseSum=0;
			
			// 테이블 헤더용 스타일
			CellStyle headStyle = wb.createCellStyle();
			// 가는 경계선을 가집니다.
			headStyle.setBorderTop(BorderStyle.THIN);
			headStyle.setBorderBottom(BorderStyle.THIN);
			headStyle.setBorderLeft(BorderStyle.THIN);
			headStyle.setBorderRight(BorderStyle.THIN);
			// 배경색은 노란색입니다.
			headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
			headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			// 데이터는 가운데 정렬합니다.
			headStyle.setAlignment(HorizontalAlignment.CENTER);
			
			// 데이터용 경계 스타일
			CellStyle bodyStyle = wb.createCellStyle();
			bodyStyle.setBorderTop(BorderStyle.THIN);
			bodyStyle.setBorderBottom(BorderStyle.THIN);
			bodyStyle.setBorderLeft(BorderStyle.THIN);
			bodyStyle.setBorderRight(BorderStyle.THIN);
			bodyStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
			
			CellStyle footStyle = wb.createCellStyle();
			footStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
			
			// 헤더 생성
			
			rowNo++;
			row = sheet.createRow(rowNo++);
			int columnIndex = 0;
		    while (columnIndex < 7) {
		    	
		    	if(columnIndex == 0) {
		    		sheet.setColumnWidth(columnIndex, 3000);
		    	} else if (columnIndex == 1) {
		    		sheet.setColumnWidth(columnIndex, 4000);
		    	} else if (columnIndex == 2) {
		    		sheet.setColumnWidth(columnIndex, 3000);
		    	} else if (columnIndex == 3) {
		    		sheet.setColumnWidth(columnIndex, 3000);
		    	} else if (columnIndex == 4) {
		    		sheet.setColumnWidth(columnIndex, 4000);
		    	} else if (columnIndex == 5) {
		    		sheet.setColumnWidth(columnIndex, 4000);
		    	} else if (columnIndex == 6) {
		    		sheet.setColumnWidth(columnIndex, 6000);
		    	}
		    	columnIndex++;
		    }
			cell = row.createCell(0);
			cell.setCellStyle(headStyle);
			cell.setCellValue("날짜");
			cell = row.createCell(1);
			cell.setCellStyle(headStyle);
			cell.setCellValue("용도");
			cell = row.createCell(2);
			cell.setCellStyle(headStyle);
			cell.setCellValue("결제방식");
			cell = row.createCell(3);
			cell.setCellStyle(headStyle);
			cell.setCellValue("입금/출금");
			cell = row.createCell(4);
			cell.setCellStyle(headStyle);
			cell.setCellValue("수입");
			cell = row.createCell(5);
			cell.setCellStyle(headStyle);
			cell.setCellValue("지출");
			cell = row.createCell(6);
			cell.setCellStyle(headStyle);
			cell.setCellValue("비고");
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			
			for(AccountDTO dto : list) {
				dto.getReportingDate();
				row = sheet.createRow(rowNo++);
				cell = row.createCell(0);
				cell.setCellStyle(bodyStyle);							
				cell.setCellValue(format.format(dto.getReportingDate()));
				cell = row.createCell(1);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dto.getDetails());
				cell = row.createCell(2);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dto.getPayments());
				cell = row.createCell(3);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dto.getSpec());
				cell = row.createCell(4);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dto.getIncome());
				cell = row.createCell(5);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dto.getExpense());
				cell = row.createCell(6);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(dto.getRemarks());
				incomeSum += dto.getIncome();
				expenseSum += dto.getExpense();
			}
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell = row.createCell(1);
			cell = row.createCell(2);
			cell = row.createCell(3);
			cell.setCellValue("총 합계");
			cell = row.createCell(4);
			cell.setCellStyle(footStyle);
			cell.setCellValue(incomeSum);
			cell = row.createCell(5);
			cell.setCellStyle(footStyle);
			cell.setCellValue(expenseSum);
			cell = row.createCell(6);
			cell.setCellStyle(footStyle);
			cell.setCellValue(incomeSum-expenseSum);
			// 엑셀 출력
			resp.setContentType("application/vnd.ms-excel");
			resp.setHeader("Content-Disposition", "attachment;filename="+formedDate+".xls");
			
			wb.write(resp.getOutputStream());
			wb.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
