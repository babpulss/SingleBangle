package recoder.single.bangle.hospital.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import recoder.single.bangle.hospital.dto.HospCodeDTO;
import recoder.single.bangle.hospital.dto.HospDTO;
import recoder.single.bangle.hospital.service.HospService;


@Controller
@RequestMapping("/hosp")
public class HospController {

	@Autowired
	private HospService hospSvc;
	
	@RequestMapping("/hospList.hp")
	public String hospitalList() {
		return "hospital/hospList";
	}
	
	@RequestMapping(value = "/getSgguCd.hp", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String getSgguCd(String sidoCd) {
		System.out.println("시도 코드 : " + sidoCd);
		
		List<HospCodeDTO> codeList = null;
		try {
			codeList = hospSvc.getSgguCd(sidoCd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Gson g = new Gson();
		String toJsonResult = g.toJson(codeList);
//		System.out.println(toJsonResult);
		System.out.println();
		
		return toJsonResult;
	}
	
	@RequestMapping(value = "/getEmdongNm.hp", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String getEmdongNm(String sidoCdNm, String sgguCdNm) {
		System.out.println(sidoCdNm + " : " + sgguCdNm);
		
		// 맨 뒤에 붙는 '시'만 빼주는 작업
//		char sgguArr[] = sgguCdNm.toCharArray();
//		if(sgguArr[sgguCdNm.length()-1] == '시') {
//			sgguCdNm = sgguCdNm.substring(0, sgguCdNm.length()-1);
//			System.out.println("얘는 바꿔야됨 ㅋㅋ ->" + sgguCdNm);
//		}
		
		sgguCdNm = sgguCdNm.replaceAll("시", "");
		if(sgguCdNm.equals("부산진구")) {
			sidoCdNm = "";
		}
		if(sgguCdNm.equals("미추홀구")) {
			sgguCdNm = "남구";
		}
		
		List<HospCodeDTO> codeList = null;
		try {
			codeList = hospSvc.getEmdongNm(sidoCdNm, sgguCdNm);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Gson g = new Gson();
		String toJsonResult = g.toJson(codeList);
//		System.out.println(toJsonResult);
		System.out.println();
		
		return toJsonResult;
	}
	
	@RequestMapping(value = "/getHosp.hp", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String getHosp(String sidoCd, String sgguCd, String emdongNm, String yadmNm) {
		System.out.println(sidoCd + " : " + sgguCd + " : " + emdongNm);
		
		List<HospDTO> hospList = null;
		try {
			hospList = hospSvc.getHosp(sidoCd, sgguCd, emdongNm, yadmNm);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Gson g = new Gson();
		String toJsonResult = g.toJson(hospList);
//		System.out.println(toJsonResult);
		System.out.println();
		
		return toJsonResult;
	}
}
