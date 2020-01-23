package recoder.single.bangle.restaurant.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	
	
	@RequestMapping("/rstList.rst")
	public String rstList(Model model){
		List<RestaurantDTO> list = rstSvc.rstList();
		model.addAttribute("list", list);
		System.out.println("혼밥/혼술 게시판에 있는 글의 개수 : " + list.size());
		System.out.println();
		
		return "restaurant/rstList";
	}
	
	@RequestMapping("/rstWrite.rst")
	public String rsstWrite() {
		return "restaurant/rstWrite";
	}
	
	@RequestMapping("/rstWriteProc.rst")
	public String rstWriteProc(RestaurantDTO dto, Model model) {
		int fileNum = dto.getFiles().length;
		System.out.println("내용 개수 : " + fileNum);
		System.out.println("제목 : " + dto.getTitle());
		System.out.println();
		
		for(int i = 0; i < fileNum; i++) {
			System.out.println("파일 : " + dto.getFiles()[i].getOriginalFilename());
			System.out.println("내용 : " + dto.getContents()[i]);
			System.out.println();
		}
		
		String writer = ((MemberDTO) session.getAttribute("loginInfo")).getId();
		dto.setWriter(writer);
		
		String uploadPath = session.getServletContext().getRealPath("/files");
		System.out.println("사진 저장 경로 : " + uploadPath);
		
		int insertResult = rstSvc.rstWrite(dto, uploadPath);
		model.addAttribute("insertResult", insertResult);
		System.out.println();
		
		return "restaurant/rstWriteCheck";
	}
	
	@RequestMapping("rstDetail.rst")
	public String rstDetail(int seq, Model model) {
		RestaurantDTO dto = rstSvc.rstDetail(seq);
		model.addAttribute("dto", dto);
		
		List<RestaurantFileDTO> filesList = rstSvc.fileList(seq);
		model.addAttribute("filesList", filesList);
		
		System.out.println("현재 글 번호 : " + seq);
		
		return "restaurant/rstDetail";
	}
}
