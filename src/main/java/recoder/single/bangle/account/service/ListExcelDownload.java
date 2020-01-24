package recoder.single.bangle.account.service;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import recoder.single.bangle.account.DTO.AccountDTO;

@Service
public class ListExcelDownload extends AbstractXlsView{
	
	@Override
	protected void buildExcelDocument(Map modelMap, Workbook workbook, HttpServletRequest req, HttpServletResponse resp) {
		String sCurTime = null;
		sCurTime = new SimpleDateFormat("yyyyMMdd",Locale.KOREA).format(new Date());
		
		String excelName = sCurTime + "_가계부.xlsx";
		Sheet worksheet = null;
		Row row = null;
		CellStyle style = workbook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		
		List<AccountDTO> listExcel = (List)modelMap.get("list");
		
		worksheet = workbook.createSheet("가계부");
		
		row = worksheet.createRow(0);
		
		int columnIndex = 0;
		while(columnIndex < 7) {
			if(columnIndex == 0) {
				worksheet.setColumnWidth(columnIndex, 3000);
			}else if(columnIndex == 1) {
				worksheet.setColumnWidth(columnIndex, 4000);
			}else if(columnIndex == 2) {
				worksheet.setColumnWidth(columnIndex, 6000);
			}else if(columnIndex == 3) {
				worksheet.setColumnWidth(columnIndex, 4000);
			}else if(columnIndex == 4) {
				worksheet.setColumnWidth(columnIndex, 7000);
			}else if(columnIndex == 5) {
				worksheet.setColumnWidth(columnIndex, 3000);
			}else if(columnIndex == 6) {
				worksheet.setColumnWidth(columnIndex, 3000);
			}
			columnIndex++;
		}
		
		row = worksheet.createRow(0);
		row.createCell(0).setCellValue("날짜");
		row.createCell(1).setCellValue("용도");
		row.createCell(2).setCellValue("결제방식");
		row.createCell(3).setCellValue("입금");
		row.createCell(4).setCellValue("출금");
		row.createCell(5).setCellValue("금액");
		row.createCell(6).setCellValue("비고");
		
		int rowIndex = 1;
		for(AccountDTO dto : listExcel) {
			row = worksheet.createRow(rowIndex);
			row.createCell(0).setCellValue(dto.getReportingDate());
			row.createCell(1).setCellValue(dto.getDetails());
			row.createCell(2).setCellValue(dto.getPayments());
			row.createCell(3).setCellValue(dto.getSpec());
			row.createCell(4).setCellValue(dto.getIncome());
			row.createCell(5).setCellValue(dto.getExpense());
			row.createCell(6).setCellValue(dto.getReportingDate());
			
			rowIndex++;
		}
		
		worksheet.addMergedRegion(new CellRangeAddress(listExcel.size()+1, listExcel.size()+1, 0, 6));
		
		row =worksheet.createRow(listExcel.size()+1);
		row.createCell(0).setCellValue("병합");
		row.getCell(0).setCellStyle(style);
		
		try {
			resp.setHeader("Content-Disposition", "attachment; filename\""+java.net.URLEncoder.encode(excelName,"UTF-8")+"\";charset=\"UTF-8\"");
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
}
