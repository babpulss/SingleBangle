package recoder.single.bangle.tipBoard.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;

import recoder.single.bangle.member.DTO.MemberDTO;
import recoder.single.bangle.tipBoard.DTO.BoardDTO;
import recoder.single.bangle.tipBoard.DTO.FileDTO;
import recoder.single.bangle.tipBoard.DTO.ScrapDTO;
import recoder.single.bangle.tipBoard.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private HttpSession session;
	
	@Autowired
	private BoardService boardService;

	@RequestMapping("/toBoardWrite.bo")
	public String toBoardWrite() {
		return "tipBoard/tipBoardWrite";
	}
	@RequestMapping("/kakaoLink.bo")
	public String kakaoLink() {
		return "tipBoard/kakao";
	}
	
	//글 작성
	@RequestMapping("/writeProc.bo")
	public String writeProc(BoardDTO dtoB, Model model, FileDTO dtoF) {
		//realPath: 파일이 저장되는 곳!
		String realPath = session.getServletContext().getRealPath("/files");
 		
		System.out.println("realPath: "+realPath);
		
		//writer: 세션에서 가져온 id값 을 dto의 writer에 넣는다! 즉, 게시판의 writer는 로그인한 사람의 id값임!
		String writer = ((MemberDTO)session.getAttribute("loginInfo")).getId();
		dtoB.setWriter(writer);
		System.out.println("dto에 입력된 writer: " + dtoB.getWriter());
		
		// 게시글이 입력되면 writeResult=1, 입력 실패하면 writeResult=0 이다!
		int writeResult = boardService.tipBoardWrite(realPath,dtoB,dtoF);
		System.out.println("게시글 입력 성공 여부: "+writeResult);
		
		//model로 보내는 이유=> 결과 확인하고 jsp에서 결과에 따른 alert창 띄우려고!
		model.addAttribute("writeResult", writeResult);
		return "tipBoard/boardWriteCheck";
	}
	
	//게시판 글 목록 화면
	@RequestMapping("/boardList.bo")
	public String boardList(Model model) {
		List<BoardDTO> list = boardService.boardList();
		model.addAttribute("list", list);
		System.out.println("DB에 있는 글의 개수: " + list.size());
		return "tipBoard/boardList";
	}
	
	//글 제목 클릭하면 글 상세보기 화면
	@RequestMapping("/detailView.bo")
	public String detailView(int seq, Model model) {
	
		boardService.viewCount(seq);
		MemberDTO loginDTO = (MemberDTO)session.getAttribute("loginInfo");
		
		if(loginDTO != null) {
			String id = loginDTO.getId();
			
			int likeCheck = boardService.likeCheck(seq, id);
			model.addAttribute("likeCheck", likeCheck);
		}
		BoardDTO dtoB = boardService.getDto(seq);
		model.addAttribute("detailView",dtoB);	
		
		return "tipBoard/detailView";
	}
	
	@RequestMapping("/updatePage.bo")
	public String updatePage(int seq, Model model) {
		BoardDTO dtoB = boardService.getDto(seq);
		model.addAttribute("dtoB", dtoB);
		return "tipBoard/tipBoardUpdate";
	}
	
	
	@RequestMapping("/updateTip.bo")
	public String updateTip(BoardDTO dtoB, Model model) {
		System.out.println("updateTip.bo에 잘 도착!");
		
		int updateResult = boardService.updateTip(dtoB);
		
		System.out.println("Controller에서의 updateResult: "+updateResult);
		
		model.addAttribute("updateResult", updateResult);
		return "tipBoard/boardUpdateCheck";
	}
	
	@RequestMapping(value = "/like.bo", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String like(int seq, String id) {
		System.out.println("like.bo에 도착!");
		System.out.println("ajax결과: "+seq+" : "+id);
		
		//like 눌렀던 사람인지 검사! likeCheckResult = 1 이면 좋아요 눌렀던 사람, likeCheckResult = 0 이면 좋아요 안 눌렀던 사람!
		int likeCheckResult = boardService.likeCheck(seq, id);
		
		// like 안했던 사람이라면 like insert
		if(likeCheckResult == 0) {
			int result = boardService.likeInsert(seq, id);
			System.out.println("controller에서 likeInsert 결과: "+result);
		// like 했던 사람이라면 like delete
		}else {
			int result = boardService.likeDelete(seq, id);
			
			System.out.println("controller에서 likeDelete 결과: "+result);
		}
		
		int likeCount = boardService.likeCount(seq);
		System.out.println("controller에서 likeCount 결과: "+likeCount);
		
		JsonObject obj = new JsonObject();
		obj.addProperty("seq", seq);
		obj.addProperty("id", id);
		obj.addProperty("likeCount", likeCount);
		obj.addProperty("likeCheckResult", likeCheckResult);
		return obj.toString();
	}
	
	@RequestMapping(value = "/tipScrap.bo", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String scrap(Model model, int seq, int category, String id, String title) {
			System.out.println("tipScrap.bo에 도착!");
		// 그 글을 스크랩했던 사람인지 검사! 
		int scrapCheckResult = boardService.scrapCheck(seq, id);
		
		// 그 글을 스크랩하지 않았다면 스크랩 가능~!
		int scrapResult = 0;
		int scrapCount = 0;
		
		if(scrapCheckResult == 0) {
			MemberDTO dtoM = (MemberDTO) session.getAttribute("loginInfo");
			BoardDTO dtoB = boardService.getDto(seq);
			ScrapDTO dtoS = new ScrapDTO(0,seq,dtoB.getCategory(),dtoB.getTitle(),dtoM.getId(),null); 
			 scrapResult = boardService.scrap(dtoS);
		}
		//스크랩을 하던, 안 하던 count는 해야 함!
		scrapCount = boardService.scrapCount(seq);
		
		JsonObject obj = new JsonObject();
		obj.addProperty("seq", seq);
		obj.addProperty("scrapCheckResult", scrapCheckResult);
		obj.addProperty("scrapResult", scrapResult);
		obj.addProperty("scrapCount", scrapCount);
		return obj.toString();	
	}
	

}

