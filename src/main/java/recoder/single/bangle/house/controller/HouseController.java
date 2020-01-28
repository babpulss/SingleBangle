package recoder.single.bangle.house.controller;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import recoder.single.bangle.house.DTO.HouseCommentDTO;
import recoder.single.bangle.house.DTO.HouseContentDTO;
import recoder.single.bangle.house.DTO.HouseDTO;
import recoder.single.bangle.house.service.HouseService;
import recoder.single.bangle.member.DTO.MemberDTO;


@RequestMapping("/house")
@Controller
public class HouseController {
	@Autowired
	private HouseService houseService;

	@Autowired
	private HttpSession session;

	@RequestMapping("/houseMain")
	public String houseMain(Model model) {
		//집들이 메인 1~15번째만 내용 가져옴
		try {
			System.out.println("houseMain 도착"); 
			Map<String, Object> rootMap = houseService.selectFirst();
			int total = (int) rootMap.get("total"); //총 페이지

			List<Map<String, Object>> list = (List<Map<String, Object>>) rootMap.get("content"); //제목, 작성자, 조회수, 사진하나
			System.out.println(list);
			model.addAttribute("total", total);
			model.addAttribute("list", list);

		}catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "house/houseMain";
	}

	@ResponseBody
	@RequestMapping(value = "/getHouseContent", produces = "text/html; charset=UTF-8")
	public String getHouseContent(int curPage) {
		//집들이 내용 추가로 가져옴
		try {
			Gson gson = new Gson();
			List<Map<String, Object>> list = houseService.getHouseContent(curPage);
			System.out.println(gson.toJson(list));
			return gson.toJson(list);
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping("/houseDetail")
	public String houseDetail(Model model, int seq) {
		//집들이 상세보기
		try {
			System.out.println("houseDetail 도착");
			Map<String, Object> map = houseService.detail(seq);

			model.addAttribute("houseDTO", map.get("houseDTO")); //제목, 작성자, 조회수
			model.addAttribute("contentList", map.get("contentList")); //이미지 관련
			model.addAttribute("commentList", map.get("commentList")); //댓글
		}catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		return "/house/houseDetail";
	}


	@ResponseBody
	@RequestMapping(value = "/houseCommentWriteProc", produces = "text/html; charset=UTF-8")
	public String houseCommentProc(HouseCommentDTO dto) {
		//집들이 댓글 작성
		try {
			System.out.println("houseCommentProc 도착" );
			MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
			dto.setWriter(loginInfo.getId());
			Map<String, Object> map = houseService.commentWrite(dto);
			Gson gson = new Gson();
			String json = gson.toJson(map);
			System.out.println(json);
			return json;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@ResponseBody
	@RequestMapping(value = "/houseCommentDel", produces = "text/html; charset=UTF-8")
	public String houseCommentDel(int seq) {
		//집들이 댓글 삭제
		try {
			System.out.println("시퀀스" + seq);
			MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
			String id = loginInfo.getId();
			houseService.commentDel(seq, id); //성공 혹은 실패
			return "true";
		}catch (Exception e) {
			e.printStackTrace();
			return "false"; //에러
		}
	}

	@RequestMapping("/houseWriter")
	public String houseWriter() {
		//집들이 작성 페이지
		System.out.println("houseWriter 도착");
		return "/house/houseWriter";
	}

	@RequestMapping(value =  "/housWriterProc", method=RequestMethod.POST)
	public String housWriterProc(String title, String[] imgTitle, String[] imgContent, MultipartFile[] img) {
		//집들이 작성 proc
		System.out.println("housWriterProc 도착");
		try {
			MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
			String writer = loginInfo.getId();
			HouseDTO houseDTO = new HouseDTO(0, writer, title, null, 0);
			List<HouseContentDTO> contentList = new ArrayList<>();

			for(int i= 0; i<imgTitle.length; i++) { 
				contentList.add( 
						new HouseContentDTO(0, 0, imgTitle[i], imgContent[i], null, null) 
						); 
			}


			houseService.writeHouse(houseDTO, contentList, img);

		}catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/house/houseMain";
	}
	@RequestMapping("/houseUpdate")
	public String houseUpdate(Model model,int seq) {
		//집들이 수정 이동
		try {
			MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
			String id = loginInfo.getId();
			Map<String, Object> map = houseService.updateView(seq);
			if(map.size() > 0) {
				model.addAttribute("stat", 1);
				model.addAttribute("houseDTO", map.get("houseDTO")); //제목, 작성자, 조회수
				model.addAttribute("contentList", map.get("contentList")); //이미지 관련
			}else {
				model.addAttribute("stat", -1);
			}	
			return "house/houseUpdate";
		}catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}


	@RequestMapping("/houseUpdateProc")
	public String houseUpdateProc(String title, String[] imgTitle, String[] imgContent, MultipartFile[] img, String stat) { 
		//집들이 수정 
		try { 
			System.out.println("houseUpdateProc 도착");
			System.out.println(stat);

			MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo"); 
			String writer = loginInfo.getId();
			HouseDTO houseDTO = new HouseDTO(0, writer, title, null, 0); 
			List<HouseContentDTO> contentList = new ArrayList<>();

			for(int i= 0; i<imgTitle.length; i++) {
				contentList.add( 
					new HouseContentDTO(0, 0, imgTitle[i], imgContent[i], null, null) 
				); 
			} 
			
			houseService.updateBySeq(houseDTO, contentList, img, stat);
			return "redirect:/house/houseMain";
		}catch(Exception e) { 
			e.printStackTrace(); 
			return "error"; 
		}
	}


	@RequestMapping("houseDelete")
	public String houseDelete(Model model, int seq) {
		try {
			MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
			String id = loginInfo.getId();
			System.out.println("id" + id);
			System.out.println("시퀀스" + seq);
			if(houseService.deleteBySeq(id, seq)) {
				model.addAttribute("stat", 1);
			}else {
				model.addAttribute("stat", -1);
			}
			return "/house/houseDelete";
		}catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
}
