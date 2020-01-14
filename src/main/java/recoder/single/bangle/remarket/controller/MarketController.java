package recoder.single.bangle.remarket.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import recoder.single.bangle.remarket.DTO.MarketDTO;

@Controller
@RequestMapping("/market")
public class MarketController {
	@Autowired
	private HttpSession session;

	@Autowired
	private HttpServletRequest request;

	@Autowired
	private HttpServletResponse response;
	
	@RequestMapping("/boardList.do") //게시글 전체 리스트
	public String board(Model model, MarketDTO dto) {
		System.out.println("boardList 도착~.~");
		List<String> fileList = new ArrayList<String>();
		try {
			List<MarketDTO> list = service.board();
			for(int i = 0; i < list.size(); i++) {
				int board_seq = list.get(i).getSeq();
				String sys_name = file_dao.review(board_seq);
				fileList.add(sys_name);
			}	
			model.addAttribute("fileList", fileList);
			model.addAttribute("list", list);
			return "board/board";
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping("/delete.do")
	public String delete() {
		int seq = Integer.parseInt(request.getParameter("seq"));
		System.out.println("삭제시퀀스 : " + seq);
		//		System.out.println("delete.do 도착");
		service.delete(seq);
		int board_seq = seq;
		file_dao.delete(board_seq); //board삭제할때 file에서도 삭제
		return "redirect:/board/boardList.do";
	}

	@RequestMapping("/update.do")
	public String update(Model model) {
		int seq = Integer.parseInt(request.getParameter("seq"));
		//		System.out.println("수정할 글 번호 : " + seq); //ok
		MarketDTO dto = service.writedetail(seq);
		model.addAttribute("dto", dto);
		return "board/updateBoard";
	}

	@RequestMapping("/writeboard.do") //게시판에서 글쓰기버튼 클릭
	public String writeBoard() {
		System.out.println("writeboard.do 도착");
		return "board/writeboard";
	}
	
	@RequestMapping("/reportBoard.do") 
	public String reportBoard() {
		return "board/report";
	}
	
	@RequestMapping("/report.do") 
	public String report(Model model) {
		int seq = Integer.parseInt(request.getParameter("seq"));
//		System.out.println("신고할 글 번호 : " + seq);
		model.addAttribute("seq", seq);
		return "board/reportdetail";
	}
	
	
	@RequestMapping("/reportProc.do")
	public String reportProc(Model model) {
		String reason = request.getParameter("report");
		int seq = Integer.parseInt(request.getParameter("seq"));
		String id = (String) session.getAttribute("id");
		System.out.println("신고자 : " + id);
//		System.out.println("신고사유 : " + report + " seq : " + seq);
		MarketDTO dto = service.writedetail(seq);
		service.report(dto, reason, id);
		return "home";
	}

	@RequestMapping("/write.do") //writeboard에서 글쓰기 버튼 클릭
	public String write(MarketDTO dto, Model model) {
		System.out.println("글쓰기 누르고 write.do도착");
		try {
			String id = (String)session.getAttribute("id");//ok
			MemberDTO myInfo = (MemberDTO) session.getAttribute("myInfo");
			String place = myInfo.getAdd1();
			System.out.println("글쓴이 사는 지역 : " + place);
			String path = session.getServletContext().getRealPath("files");
			service.write(dto.getTitle(), dto.getPrice(), dto.getContent(), dto.getCategory(), place , path, id);
			List<MarketDTO> list = service.board();
			ModelAndView mav = new ModelAndView();
			model.addAttribute("list", list);
			return "redirect:/board/boardList.do";
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping("/writedetail.do") //게시글상세
	public String writedetail(Model model) {
		System.out.println("도착");
		try {
			int seq = Integer.parseInt(request.getParameter("seq"));
			System.out.println("컨트롤러 : "  + seq);
			MarketDTO dto = service.writedetail(seq); //seq값 넘기기
			model.addAttribute("dto", dto);
			//			model.addAttribute("list", list);
			return "board/writedetail";
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping("/search.do")
	public String search(Model model) {
		String category = (String) request.getParameter("category");
		String title = (String) request.getParameter("title");
		//		System.out.println("category : " + category);
		try {
			if(category.contentEquals("전체")) {
				System.out.println("전부출력하기~~");
				List<String> fileList = new ArrayList<>();
				List<MarketDTO> list = service.searchNoCategory(title);
				System.out.println("검색 몇개 ? " + list.size());
				for(int i = 0; i < list.size(); i++) {
					int board_seq = list.get(i).getSeq();
					System.out.println("검색된seq" + board_seq);
					String sys_name = file_dao.searchReview(board_seq);
					fileList.add(sys_name);
					model.addAttribute("fileList", fileList);
					model.addAttribute("list", list);
				}
			}else {
				List<String> fileList = new ArrayList<>();
				List<MarketDTO> list = service.search(title, category);
				System.out.println("검색 몇개 ? " + list.size());
				for(int i = 0; i < list.size(); i++) {
					int board_seq = list.get(i).getSeq();
					System.out.println("검색된seq" + board_seq);
					String sys_name = file_dao.searchReview(board_seq);
					fileList.add(sys_name);
					model.addAttribute("fileList", fileList);
					model.addAttribute("list", list);
				}
			}

		}catch(Exception e) {
			e.printStackTrace();
		}
		return "board/board";

	}
}
