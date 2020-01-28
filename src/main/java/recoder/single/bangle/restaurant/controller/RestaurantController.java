package recoder.single.bangle.restaurant.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import recoder.single.bangle.member.DTO.MemberDTO;
import recoder.single.bangle.restaurant.DTO.RestaurantDTO;
import recoder.single.bangle.restaurant.DTO.RestaurantFileDTO;
import recoder.single.bangle.restaurant.service.RestaurantService;

@Controller
@RequestMapping("/restaurant")
public class RestaurantController {

	@Autowired
	private HttpSession session;
	
	@Autowired
	private RestaurantService rstSvc;
	
	
	
	@RequestMapping("/rstListN.rst")
	public String rstListN(Model model){
		try {
			List<RestaurantDTO> list = rstSvc.rstListN();
			model.addAttribute("list", list);
			System.out.println("승인대기 중인 혼밥/혼술 글의 개수 : " + list.size());
			System.out.println();
			
			return "restaurant/rstListN";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		}
	}
	
	@RequestMapping("/rstListY.rst")
	public String rstListY(Model model){
		try {
			List<RestaurantDTO> list = rstSvc.rstListY();
			for(int i = 0; i < list.size(); i++) {
				String formedDate = list.get(i).getFormedDate1();
				list.get(i).setFormedDate1(formedDate);
			}
			model.addAttribute("list", list);
			System.out.println("승인된 혼밥/혼술 글의 개수 : " + list.size());
			System.out.println();
			
			Gson g = new Gson();
			String toJsonResult = g.toJson(list);
			model.addAttribute("jsonResult", toJsonResult);
			
			return "restaurant/rstListY";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		}
	}
	
	@RequestMapping("/rstWrite.rst")
	public String rsstWrite() {
		return "restaurant/rstWrite";
	}
	
	@RequestMapping("/rstWriteProc.rst")
	public String rstWriteProc(RestaurantDTO dto, Model model) {
		try {
			int fileNum = dto.getFiles().length;
			System.out.println("내용 개수 : " + fileNum);
			System.out.println("제목 : " + dto.getTitle());
			System.out.println();
			
			for(int i = 0; i < fileNum; i++) {
//				System.out.println("파일 : " + dto.getFiles()[i].getOriginalFilename());
//				System.out.println("내용 : " + dto.getContents()[i]);
//				System.out.println();
			}
			
			String writer = ((MemberDTO) session.getAttribute("loginInfo")).getId();
			dto.setWriter(writer);
			
			String uploadPath = session.getServletContext().getRealPath("/files");
//			System.out.println("사진 저장 경로 : " + uploadPath);
			
			int insertResult = rstSvc.rstWrite(dto, uploadPath);
			model.addAttribute("insertResult", insertResult);
			System.out.println();
			
			return "restaurant/rstWriteCheck";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		}
	}
	
	@RequestMapping("rstDetail.rst")
	public String rstDetail(int seq, Model model) {
		try {
			RestaurantDTO dto = rstSvc.rstDetail(seq);
			model.addAttribute("dto", dto);
			
			List<RestaurantFileDTO> filesList = rstSvc.fileList(seq);
			model.addAttribute("filesList", filesList);
			
			System.out.println("현재 글 번호 : " + seq);
			System.out.println();
			
			return "restaurant/rstDetail";
			
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		}
	}
	
	@RequestMapping("rstApproval.rst")
	public String rstApproval(int seq, Model model) {
		try {
			int approvalResult = rstSvc.rstApproval(seq);
			model.addAttribute("approvalResult", approvalResult);
			
			return "restaurant/rstApprovalCheck";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		}
	}
	
	@RequestMapping("rstDelete.rst")
	public String rstDelete(int seq, Model model) {
		try {
			int deleteResult = rstSvc.rstDelete(seq);
			model.addAttribute("deleteResult", deleteResult);
			
			return "restaurant/rstDeleteCheck";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error";
		}
	}
}
