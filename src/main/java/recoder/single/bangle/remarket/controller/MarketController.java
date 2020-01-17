package recoder.single.bangle.remarket.controller;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import configuration.Configuration;
import recoder.single.bangle.member.DTO.MemberDTO;
import recoder.single.bangle.remarket.DAO.MarketDAO;
import recoder.single.bangle.remarket.DAO.MarketFileDAO;
import recoder.single.bangle.remarket.DTO.MarketDTO;
import recoder.single.bangle.remarket.DTO.MarketReplyDTO;
import recoder.single.bangle.remarket.service.MarketReplyService;
import recoder.single.bangle.remarket.service.MarketService;

@Controller
@RequestMapping("/market")
public class MarketController {

	@Autowired
	private MarketDAO dao;

	@Autowired
	private MarketService service;

	@Autowired
	private MarketReplyService reService;

	@Autowired
	private MarketFileDAO file_dao;

	@Autowired
	private HttpSession session;

	@Autowired
	private HttpServletRequest request;

	@Autowired
	private HttpServletResponse response;

	@RequestMapping("/boardList.do") //게시글 전체 리스트
	public String board(Model model, MarketDTO dto) {
		try {
			String navi = dao.getPageNavi(1);
			int cpage=1;
			String page = request.getParameter("cpage");
			if(page != null) {
				cpage = Integer.parseInt(page);
			}
			int start = cpage * Configuration.recordCountPerPage - (Configuration.recordCountPerPage -1 );
			int end = cpage * Configuration.recordCountPerPage;
			List<MarketDTO> navilist = dao.selectByPage(start, end);
			System.out.println(start + " : " + end);
			model.addAttribute("navilist", navilist);
			model.addAttribute("navi", navi);

			List<String> fileList = new ArrayList<String>();
			List<MarketDTO> list = service.board();

			for(int i = 0; i < list.size(); i++) {
				int board_seq = list.get(i).getSeq();
				System.out.println(board_seq);
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
		service.delete(seq);
		//댓글삭제
		int board_seq = seq;
		file_dao.delete(board_seq); //board삭제할때 file에서도 삭제
		int boardSeq = board_seq;
		reService.deleteUseBoardSeq(boardSeq);
		return "redirect:/board/boardList.do";
	}

	@RequestMapping("/update.do")
	public String update(Model model) {
		int seq = Integer.parseInt(request.getParameter("seq"));
		System.out.println("수정할 글 번호 : " + seq); //ok
		MarketDTO dto = service.writedetail(seq);
		model.addAttribute("dto", dto);
		return "board/updateBoard";
	}

	@RequestMapping("/updateProc.do")//게시글 업데이트
	public String updateProc(MarketDTO dto, Model model) {
		String path = session.getServletContext().getRealPath("files");
		service.updateProc(dto.getTitle(), dto.getPrice(), dto.getContent(), dto.getCategory(), dto.getSeq(), path);
		return "home";
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
	public String report(Model model) {//신고하기 버튼 누름
		//		int seq = Integer.parseInt(request.getParameter("seq"));
		String url = request.getParameter("url");
		model.addAttribute("url", url);
		return "board/reportdetail";
	}


	@RequestMapping("/reportProc.do")
	public String reportProc(Model model) {
		String url = request.getParameter("url");
		String reason = request.getParameter("report");
		//		int seq = Integer.parseInt(request.getParameter("seq"));
		String id = (String) session.getAttribute("id");
		System.out.println("신고자 : " + id + " 링크 : " + url + " 신고사유 : " + reason);
		service.report(id, url, reason);
		return "home";
	}

	@RequestMapping("/write.do") //writeboard에서 글쓰기 버튼 클릭
	public String write(MarketDTO dto, Model model) {
		try {
			String id = (String)session.getAttribute("id");//ok
			MemberDTO myInfo = (MemberDTO) session.getAttribute("myInfo");
			String place = myInfo.getAddress1();
			String path = session.getServletContext().getRealPath("files");
			String content = dto.getContent();
			content.replace("<", "&lt");
			content.replace(">", "&gt");
			content.replace("&", "&amp");
			service.write(dto.getTitle(), dto.getPrice(), content, dto.getCategory(), place , path, id);
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
			StringBuffer url = request.getRequestURL();
			String realUrl = url + "?seq=" + seq;
			model.addAttribute("realUrl", realUrl);
			int boardSeq = seq;
			List<MarketReplyDTO> list = reService.list(boardSeq);
			model.addAttribute("list", list);
			return "board/marketdetail";
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

			}else if(title == "") {
				List<String> fileList = new ArrayList<>();
				List<MarketDTO> list = service.searchNoTitle(category);
				for(int i = 0; i < list.size(); i++) {
					int board_seq = list.get(i).getSeq();
					System.out.println("검색된seq" + board_seq);
					String sys_name = file_dao.searchReview(board_seq);
					fileList.add(sys_name);
					model.addAttribute("fileList", fileList);
					model.addAttribute("list", list);
				}
			}
			else {
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


	@RequestMapping("/filedownload.do")
	public void filedownload() {
		String sys_name = request.getParameter("sys_name");//다운할 파일 이름 출력o
		String path = session.getServletContext().getRealPath("files"); //다운위치 출력o
		String fullPath = path + "/" + sys_name;

		File f = new File(fullPath);

		try(
				FileInputStream fis = new FileInputStream(f);
				DataInputStream fileDis = new DataInputStream(fis);
				ServletOutputStream sos = response.getOutputStream();
				){
			byte[] fileContents = new byte[(int)f.length()];
			fileDis.readFully(fileContents); // 파일 내용 준비 완료

			response.reset();//response 백지화
			response.setContentType("application/octet-stream");

			String encFileName = new String(sys_name.getBytes("utf8"),"iso-8859-1");

			response.setHeader("Content-Disposition", "attachment; filename=\""+ encFileName +"\"");
			response.setHeader("Content-Length", String.valueOf(f.length()));

			sos.write(fileContents);
			sos.flush();

		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
