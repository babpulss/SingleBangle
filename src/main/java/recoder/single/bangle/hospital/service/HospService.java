package recoder.single.bangle.hospital.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import recoder.single.bangle.hospital.dto.HospCodeDTO;
import recoder.single.bangle.hospital.dto.HospDTO;

@Service
public class HospService {
	
	// 병원정보서비스 API에 연결
	public StringBuilder urlConnection(StringBuilder urlBuilder) throws Exception {
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());

		BufferedReader rd;
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		
		return sb;
	}

	//////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////
	
	// 전송받은 시,도에 있는 시,군,구 가져오기
	public List<HospCodeDTO> getSgguCd(String sidoCd) throws Exception {
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551182/codeInfoService/getAddrCodeList"); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=s0xQddu4BKfmbuvhDl1duyzfshkK1l67xRfdoSeidOIhQwpAFNSTPEZLrh1zqpqPhodkjpVJQzgQ6llqriDIDQ%3D%3D"); /*Service Key*/
		urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("-", "UTF-8")); /*서비스키*/
		urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*json 형태*/
		urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /*한 페이지 결과 수*/
		urlBuilder.append("&" + URLEncoder.encode("addrTp","UTF-8") + "=" + URLEncoder.encode("2", "UTF-8")); /*1:시도, 2:시군구, 3:읍면동*/
		urlBuilder.append("&" + URLEncoder.encode("sidoCd","UTF-8") + "=" + URLEncoder.encode(sidoCd, "UTF-8")); /*addrTp 2일 경우 입력*/

		StringBuilder sb = this.urlConnection(urlBuilder);
//		System.out.println("시군구 코드 JSON 전체 : " + sb.toString());

		JsonParser parser = new JsonParser();
		JsonElement data = parser.parse(sb.toString());
		
		int totalCount = data.getAsJsonObject().getAsJsonObject("response").getAsJsonObject("body").get("totalCount").getAsInt();
		System.out.println("검색된 시군구 코드의 개수 : " + totalCount);
		
		List<HospCodeDTO> codeList = new ArrayList<>();
		if(totalCount > 0) {
			JsonObject obj = data.getAsJsonObject().getAsJsonObject("response").getAsJsonObject("body").getAsJsonObject("items");
//			System.out.println("시군구 코드 목록 : " + obj.get("item"));
			System.out.println();
			
			boolean isArray = obj.get("item").isJsonArray();
			if(isArray) {
				JsonArray arr = obj.getAsJsonArray("item");
				for(JsonElement tmp : arr) {
					String addrCd = tmp.getAsJsonObject().get("addrCd").getAsString();
					String addrCdNm = tmp.getAsJsonObject().get("addrCdNm").getAsString();
//					System.out.println(addrCd + " : " + addrCdNm);
					
					HospCodeDTO dto = new HospCodeDTO(addrCd, addrCdNm);
					codeList.add(dto);
				}        	        	
			}
			else {
				JsonObject sgguCdInfo = obj.getAsJsonObject("item");
				String addrCd = sgguCdInfo.get("addrCd").getAsString();
				String addrCdNm = sgguCdInfo.get("addrCdNm").getAsString();
//				System.out.println(addrCd + " : " + addrCdNm);
				
				HospCodeDTO dto = new HospCodeDTO(addrCd, addrCdNm);
				codeList.add(dto);
			}
		}
		else {
			codeList = null;
		}
		
		return codeList;
	}

	// 전송받은 시,군,구에 있는 읍,면,동 가져오기
	public List<HospCodeDTO> getEmdongNm(String sidoCdNm, String sgguCdNm) throws Exception {
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551182/codeInfoService/getAddrCodeList"); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=s0xQddu4BKfmbuvhDl1duyzfshkK1l67xRfdoSeidOIhQwpAFNSTPEZLrh1zqpqPhodkjpVJQzgQ6llqriDIDQ%3D%3D"); /*Service Key*/
		urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("-", "UTF-8")); /*서비스키*/
		urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*json 형태*/
		urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /*한 페이지 결과 수*/
		urlBuilder.append("&" + URLEncoder.encode("addrTp","UTF-8") + "=" + URLEncoder.encode("3", "UTF-8")); /*1:시도, 2:시군구, 3:읍면동*/
		urlBuilder.append("&" + URLEncoder.encode("sidoCdNm","UTF-8") + "=" + URLEncoder.encode(sidoCdNm, "UTF-8")); /*addrTp 3일 경우 시도명 입력*/
		urlBuilder.append("&" + URLEncoder.encode("sgguCdNm","UTF-8") + "=" + URLEncoder.encode(sgguCdNm, "UTF-8")); /*addrTp 3일 경우 시군구명 입력*/

		StringBuilder sb = this.urlConnection(urlBuilder);
//		System.out.println("읍면동 코드 JSON 전체 : " + sb.toString());
		
		JsonParser parser = new JsonParser();
		JsonElement data = parser.parse(sb.toString());
		
		int totalCount = data.getAsJsonObject().getAsJsonObject("response").getAsJsonObject("body").get("totalCount").getAsInt();
		System.out.println("검색된 읍면동 코드의 개수 : " + totalCount);
		
		List<HospCodeDTO> codeList = new ArrayList<>();
		if(totalCount > 0) {
			JsonObject obj = data.getAsJsonObject().getAsJsonObject("response").getAsJsonObject("body").getAsJsonObject("items");
//			System.out.println("읍면동 코드 목록 : " + obj.get("item"));
			System.out.println();
			
			boolean isArray = obj.get("item").isJsonArray();
			if(isArray) {
				JsonArray arr = obj.getAsJsonArray("item");
				for(JsonElement tmp : arr) {
					String addrCd = tmp.getAsJsonObject().get("addrCd").getAsString();
					String addrCdNm = tmp.getAsJsonObject().get("addrCdNm").getAsString();
//					System.out.println(addrCd + " : " + addrCdNm);
					
					HospCodeDTO dto = new HospCodeDTO(addrCd, addrCdNm);
					codeList.add(dto);
				}        	        	
			}
			else {
				JsonObject sgguCdInfo = obj.getAsJsonObject("item");
				String addrCd = sgguCdInfo.get("addrCd").getAsString();
				String addrCdNm = sgguCdInfo.get("addrCdNm").getAsString();
//				System.out.println(addrCd + " : " + addrCdNm);
				
				HospCodeDTO dto = new HospCodeDTO(addrCd, addrCdNm);
				codeList.add(dto);
			}
		}
		else {
			codeList = null;
		}
		
		return codeList;
	}
	
	// 전송받은 주소에 있는 병원 목록 가져오기
	public List<HospDTO> getHosp(String sidoCd, String sgguCd, String emdongNm, String yadmNm) throws Exception {
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551182/hospInfoService/getHospBasisList"); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=s0xQddu4BKfmbuvhDl1duyzfshkK1l67xRfdoSeidOIhQwpAFNSTPEZLrh1zqpqPhodkjpVJQzgQ6llqriDIDQ%3D%3D"); /*Service Key*/
		urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("-", "UTF-8")); /*서비스키*/
		urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*json 형태*/
		urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("200", "UTF-8")); /*한 페이지 결과 수*/
		urlBuilder.append("&" + URLEncoder.encode("sidoCd","UTF-8") + "=" + URLEncoder.encode(sidoCd, "UTF-8")); /*시도코드*/
		urlBuilder.append("&" + URLEncoder.encode("sgguCd","UTF-8") + "=" + URLEncoder.encode(sgguCd, "UTF-8")); /*시군구코드*/
		urlBuilder.append("&" + URLEncoder.encode("emdongNm","UTF-8") + "=" + URLEncoder.encode(emdongNm, "UTF-8")); /*읍면동명*/
		urlBuilder.append("&" + URLEncoder.encode("yadmNm","UTF-8") + "=" + URLEncoder.encode(yadmNm, "UTF-8")); /*병원명 (UTF-8 인코딩 필요)*/
//		urlBuilder.append("&" + URLEncoder.encode("zipCd","UTF-8") + "=" + URLEncoder.encode("2010", "UTF-8")); /*2010:종합병원, 2030:병원, 2040:요양병원, 2050:치과, 2060:한방, 2070:의원, 2080:보건기관, 2090:조산원*/
//		urlBuilder.append("&" + URLEncoder.encode("clCd","UTF-8") + "=" + URLEncoder.encode("11", "UTF-8")); /*종별코드*/
//		urlBuilder.append("&" + URLEncoder.encode("dgsbjtCd","UTF-8") + "=" + URLEncoder.encode("01", "UTF-8")); /*진료과목코드*/
//		urlBuilder.append("&" + URLEncoder.encode("xPos","UTF-8") + "=" + URLEncoder.encode("127.09854004628151", "UTF-8")); /*x좌표(소수점 15)*/
//		urlBuilder.append("&" + URLEncoder.encode("yPos","UTF-8") + "=" + URLEncoder.encode("37.6132113197367", "UTF-8")); /*y좌표(소수점 15)*/
//		urlBuilder.append("&" + URLEncoder.encode("radius","UTF-8") + "=" + URLEncoder.encode("3000", "UTF-8")); /*단위 : 미터(m)*/

		StringBuilder sb = this.urlConnection(urlBuilder);
//		System.out.println("병원 검색 JSON 전체 : " + sb.toString());

		JsonParser parser = new JsonParser();
		JsonElement data = parser.parse(sb.toString());
		
		int totalCount = data.getAsJsonObject().getAsJsonObject("response").getAsJsonObject("body").get("totalCount").getAsInt();
		System.out.println("검색된 병원의 개수 : " + totalCount);
		
		List<HospDTO> hospList = new ArrayList<>();
		if(totalCount > 0) {
			JsonObject obj = data.getAsJsonObject().getAsJsonObject("response").getAsJsonObject("body").getAsJsonObject("items");
//			System.out.println("병원 목록 : " + obj);
			System.out.println();
			
			boolean isArray = obj.get("item").isJsonArray();
			if(isArray) {
				JsonArray arr = obj.getAsJsonArray("item");
				for(JsonElement tmp : arr) {
					String hospName = tmp.getAsJsonObject().get("yadmNm").getAsString();  // 병원명
					String type = tmp.getAsJsonObject().get("clCdNm").getAsString(); // 종별코드명 - (ex : 종합병원)  
					String addr = tmp.getAsJsonObject().get("addr").getAsString();  // 주소
					
					String telNo = "";
					boolean telNoCheck = tmp.getAsJsonObject().has("telno");
					if(telNoCheck) {
						telNo = tmp.getAsJsonObject().get("telno").getAsString();  // 전화번호
					}
					
					String url = "";
					boolean urlCheck = tmp.getAsJsonObject().has("hospUrl");
					if(urlCheck) {
						url = tmp.getAsJsonObject().get("hospUrl").getAsString();  // 홈페이지					
					}
					
					String xPos = "";
					boolean xPosCheck = tmp.getAsJsonObject().has("XPos");
					if(xPosCheck) {
						xPos = tmp.getAsJsonObject().get("XPos").getAsString();  // x좌표
					}
					
					String yPos = "";
					boolean yPosCheck = tmp.getAsJsonObject().has("YPos");
					if(yPosCheck) {
						yPos = tmp.getAsJsonObject().get("YPos").getAsString();  // y좌표
					}
					
//					System.out.println(hospName + " : " + type + " : " + addr + " : " + telNo + " : " + 
//							url + " : " + xPos + " : " + yPos);
					
					HospDTO dto = new HospDTO(hospName, type, addr, telNo, url, xPos, yPos);
					hospList.add(dto);				
				}        	        	
			}
			else {
				JsonObject hospInfo = obj.getAsJsonObject("item");
				String hospName = hospInfo.get("yadmNm").getAsString();  // 병원명
				String type = hospInfo.get("clCdNm").getAsString(); // 종별코드명 - (ex : 종합병원)  
				String addr = hospInfo.get("addr").getAsString();  // 주소
				String telNo = hospInfo.get("telno").getAsString();  // 전화번호
				
				String url = "";
				boolean urlCheck = hospInfo.getAsJsonObject().has("hospUrl");
				if(urlCheck) {
					url = hospInfo.getAsJsonObject().get("hospUrl").getAsString();  // 홈페이지					
				}
				
				String xPos = hospInfo.getAsJsonObject().get("XPos").getAsString();  // x좌표
				String yPos = hospInfo.getAsJsonObject().get("YPos").getAsString();  // y좌표
//				System.out.println(hospName + " : " + type + " : " + addr + " : " + telNo + " : " + 
//						url + " : " + xPos + " : " + yPos);
				
				HospDTO dto = new HospDTO(hospName, type, addr, telNo, url, xPos, yPos);
				hospList.add(dto);	
			}
		}
		
		return hospList;
	}
}

