package recoder.single.bangle.tipBoard.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import recoder.single.bangle.member.DTO.MemberDTO;
import recoder.single.bangle.tipBoard.DTO.BoardDTO;
import recoder.single.bangle.tipBoard.DTO.CommentDTO;
import recoder.single.bangle.tipBoard.DTO.FileDTO;
import recoder.single.bangle.tipBoard.DTO.ReportDTO;
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
	public String boardList(Model model, @RequestParam(value="currentPage", required=false)String currentPage_) {
		int currentPage;
		if (currentPage_ == null) 
			currentPage = 1;
		else 
			currentPage = Integer.parseInt(currentPage_);
		System.out.println("controller에서 currentPage: " + currentPage);
		
		List<BoardDTO> list = boardService.selectByPage(currentPage);
				
		String getNavi = boardService.getNavi(currentPage);
		
		model.addAttribute("getNavi",getNavi);		
		model.addAttribute("list", list);
		
		return "tipBoard/boardList";
	}
	
	//글 제목 클릭하면 글 상세보기 화면
	@RequestMapping("/detailView.bo")
	public String detailView(int seq, Model model) {

		boardService.viewCount(seq);
		MemberDTO loginDTO = (MemberDTO)session.getAttribute("loginInfo");
		
		if(loginDTO != null) {
			//로그인 해야만 좋아요, 스크랩 가능!
			String id = loginDTO.getId();
			
			int likeCheck = boardService.likeCheck(seq, id);
			model.addAttribute("likeCheck", likeCheck);
			int scrapCheck = boardService.scrapCheck(seq, id);
			model.addAttribute("scrapCheck",scrapCheck);
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
	public String updateTip(BoardDTO dtoB, FileDTO dtoF, Model model) {
		System.out.println("updateTip.bo에 잘 도착!");
		// 여기서 에러 생김!
		String realPath = session.getServletContext().getRealPath("/files");
		String writer = ((MemberDTO) session.getAttribute("loginInfo")).getId();
		dtoB.setWriter(writer);
		int updateResult = boardService.updateTip(realPath, dtoB, dtoF);
		
		System.out.println("Controller에서의 updateResult: "+updateResult);
		
		model.addAttribute("updateResult", updateResult);
		return "tipBoard/boardUpdateCheck";
	}
	
	@RequestMapping("/deleteTip.bo")
	public String deleteTip(int seq, Model model) {
		System.out.println("deleteTip.bo에 잘 도착!");
		
//		게시글 지우면 스크랩리스트에서도 지우기...
		boardService.deleteScrap(seq);
		
//		게시글 지우면 그 게시글의 seq를 rootSeq로 가지는 댓글도 지우기!
		boardService.commentDelete(seq);

//		게시글 지우면 그 게시글이 가진 파일도 지우기
// 		해야됨		
		
		
		int deleteResult = boardService.deleteTip(seq);
		if(deleteResult>0) {
			System.out.println("팁게시판 게시글 삭제 성공!");
		}else {
			System.out.println("팁게시판 게시글 삭제 실패ㅠ");
		}
		model.addAttribute("deleteResult",deleteResult);
		return "tipBoard/deleteResult";
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
	
	@RequestMapping("/tipSearch.bo")
	public String tipSearch(String tipCategory, String searchInput, Model model, @RequestParam(value="currentPage", required=false)String currentPage_) {

		int currentPage;
		if (currentPage_ == null)
			currentPage = 1;
		else
			currentPage = Integer.parseInt(currentPage_);
		// jsp에서 form의 name 값으로 검색 카테고리와 입력값을 보내니까, 그거 받기!	
		String cate = tipCategory;
		String input = searchInput;
		
		// category가 '제목'일때
		// 입력값이 빈 값이면, error 페이지로 보내서  alert창 띄우기
		if(searchInput.contentEquals("")) {
			return "tipBoard/blankErr";
		}else {
		// 입력값이 있고, 카테고리가 title일때, 제목으로 검색 시작	
		if(cate.contentEquals("title")) {
			System.out.println("제목으로 검색 도착!");
		// 전체 글 개수를 구하기 위해서 
		int size = boardService.searchTitleCount(input);
		System.out.println("제목 검색시, 총 글의 개수: "+size);
		
		// 페이지당 글 10개씩으로 자름 => 여기서 문제가 있는듯....
		List<BoardDTO> dtoB = boardService.selectByPageTitle(currentPage, input);
		String getNavi = boardService.getSearchNaviTitle(currentPage, input, cate);
		
		// 위 작업들의 결과를 jsp로 뿌리기 위해 model에 담는다.
		model.addAttribute("searchResult",dtoB);
		model.addAttribute("searchResultSize",size);
		model.addAttribute("getNavi",getNavi);
		
		}else if(cate.contentEquals("contents")) {
			System.out.println("본문으로 검색 도착");
			
			List<BoardDTO> tmp = boardService.searchContents(input);
			List<BoardDTO> dtoB = boardService.selectByPageContents(currentPage, input);
			String getNavi = boardService.getSearchNaviContents(currentPage, input, cate);
			int size = tmp.size();
			//본문으로 검색해서 나온 결과
			model.addAttribute("searchResult",dtoB);
			//본문으로 검색해서 나온 결과의 수
			model.addAttribute("searchResultSize",size);
			model.addAttribute("getNavi",getNavi);
			
		}else if(cate.contentEquals("both")){
			System.out.println("제목+본문으로 검색 도착");
			List<BoardDTO> tmp = boardService.searchBoth(input);
			List<BoardDTO> dtoB = boardService.selectByPageBoth(currentPage, input);
			String getNavi = boardService.getSearchNaviBoth(currentPage, input, cate);
			int size = tmp.size();
			model.addAttribute("searchResult",dtoB);
			model.addAttribute("searchResultSize",size);
			model.addAttribute("getNavi",getNavi);
			}
		}
		return "tipBoard/searchResult";
	}
	
	@RequestMapping("/reportPage.bo")
	public String reportPage(String url, Model model) {
		System.out.println("신고하는 글의 url: " + url);
		model.addAttribute("url",url);
		return "tipBoard/reportPage";
	}
	
	@RequestMapping("/reportProc.bo")
	public String reportProc(String reason,String url, String reporter, Model model) {
		ReportDTO dtoR = new ReportDTO(0,reporter,null,reason,url,null,null);
		int reportResult = boardService.report(dtoR);
		model.addAttribute("reportResult",reportResult);
		return "tipBoard/reportResult";
	}
	
	@RequestMapping(value = "/addComment.bo", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String addComment(CommentDTO dtoC) {
		System.out.println("addComment.bo에 도착!");
		System.out.println(dtoC.toString());
		JsonObject obj = new JsonObject();
	
		int cmtResult = boardService.addComment(dtoC);
		System.out.println("controller에서 댓글 입력 결과: "+cmtResult);
		obj.addProperty("cmtResult", cmtResult);
		return obj.toString();
	}
	
	@RequestMapping(value = "/cmtList.bo", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String cmtList(int rootSeq,Model model, @RequestParam(value="currentPage", required=false)String currentPage_){
		int currentPage;
		if (currentPage_ == null)
			currentPage = 1;
		else
			currentPage = Integer.parseInt(currentPage_ = currentPage_.trim());
		
		System.out.println("cmtList.bo에 도착!");
		

		List<CommentDTO> cmtFullList = boardService.cmtList(rootSeq);
		int cmtCount = cmtFullList.size();
		// 댓글창에서 getFormedDate 사용! getter뿐 아니라 setter도 만들어주기!
	
		List<CommentDTO> cmtList = boardService.selectByPageCmt(currentPage, rootSeq);

		String getNavi = boardService.getCmtNavi(currentPage, rootSeq);
		
		for(int i=0; i<cmtList.size();i++) {
			String formedDate = cmtList.get(i).getFormedDate();
			cmtList.get(i).setFormedDate(formedDate);
		}
		
//		모델에 담지 말고, 
//		model.addAttribute("cmtList", cmtList);
//		model.addAttribute("getNavi",getNavi);
//		
		System.out.println("controller에서 cmtList: "+cmtList);
		
		Gson g = new Gson();
		String toJsonResult = g.toJson(cmtList);
		
		JsonObject obj = new JsonObject();
		
		obj.addProperty("cmtCount", cmtCount);
		obj.addProperty("cmtList", toJsonResult);
		obj.addProperty("getNavi", getNavi);

		return obj.toString();
	}
	
	@RequestMapping("/replyDelete.bo")
	public String replyDelete(int seq,String contents, Model model) {
		//여기서 seq는 댓글의 seq이다.
		System.out.println("replyDelete에 도착!");
		System.out.println("댓글의 seq: "+seq);
		
		int rootSeq = boardService.getRootSeq(seq);
		System.out.println("댓글을 단 글의 seq: "+ rootSeq);
		
		int deleteResult = boardService.cmtDelete(seq);
		System.out.println("댓글 삭제 결과: " + deleteResult);
		
		model.addAttribute("rootSeq",rootSeq);
		model.addAttribute("deleteResult",deleteResult);
		return "tipBoard/cmtDelResult";
	}
	
	@RequestMapping("/replyUpdate.bo")
	public String replyUpdate(int seq, String contents, Model model) {
		System.out.println("replyUpdate에 도착!");
		int rootSeq = boardService.getRootSeq(seq);
		System.out.println("댓글을 단 글의 seq: "+ rootSeq);
		int cmtUpdateResult = boardService.cmtUpdate(seq, contents);
		
		model.addAttribute("rootSeq",rootSeq);
		model.addAttribute("cmtUpdateResult",cmtUpdateResult);		
		return "tipBoard/cmtUpdateResult";
	}
}

