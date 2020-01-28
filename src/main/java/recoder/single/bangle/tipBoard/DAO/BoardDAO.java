package recoder.single.bangle.tipBoard.DAO;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.tipBoard.DTO.BoardDTO;
import recoder.single.bangle.tipBoard.DTO.CommentDTO;
import recoder.single.bangle.tipBoard.DTO.ReportDTO;
import recoder.single.bangle.tipBoard.DTO.ScrapDTO;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSessionTemplate sst;
	
	public int write(BoardDTO dto) throws Exception{
		System.out.println(dto);
	
		return sst.update("Tip.insert", dto);
	}

	public BoardDTO getDto(int seq) throws Exception{
		System.out.println("seq: "+seq);
		return sst.selectOne("Tip.selectOne", seq);
	}

	//getMaxSeq()는 글 작성자를 기준으로 seq를 뽑아온다!
		public int getMaxSeq(String writer) throws Exception{
			System.out.println("writer: "+writer);
			return sst.selectOne("Tip.getMaxSeq",writer);
			
		}
		
		public int updateTip(BoardDTO dtoB) throws Exception{
			int tmp = sst.update("Tip.updateTip", dtoB);
			System.out.println("업데이트결과: "+tmp);
			return tmp;
		}
		
		public int deleteTip(int seq) throws Exception{
			return sst.delete("Tip.deleteTip",seq);
		}
		
		public int likeCheck(int seq, String id) throws Exception{
//			매개변수 2개니까 map에 넣어준다! <String,Object> 이거는 map의 자료형!
			Map<String,Object> param = new HashMap<>();
			param.put("seq", seq);
			param.put("id", id);
			return sst.selectOne("Tip.likeCheck",param);
		}
		
		public int likeInsert(int seq, String id) throws Exception{
			Map<String, Object> param = new HashMap<>();
			param.put("seq", seq);
			param.put("id", id);
			return sst.insert("Tip.likeInsert", param);
		}
		
		public int likeDelete(int seq, String id) throws Exception{
			Map<String, Object> param = new HashMap<>();
			param.put("seq", seq);
			param.put("id", id);
			return sst.delete("Tip.likeDelete", param);
		}
		
		public int likeCount(int seq) throws Exception{
			int tmp = sst.selectOne("Tip.likeCount",seq);
			System.out.println("좋아요 수: "+tmp);
			return tmp;
		}
		
		public int likePlus(int seq) throws Exception {
			return sst.update("Tip.likePlus", seq);
		}
		
		public int likeMinus(int seq) throws Exception {
			return sst.update("Tip.likeMinus", seq);
		}
		
		public int viewCount(int seq) throws Exception{
			return sst.update("Tip.viewCount",seq);
		}
		
		public int scrap(ScrapDTO dtoS) throws Exception{
			return sst.insert("Tip.scrap",dtoS);
		}
		
		public int deleteScrap(int seq) throws Exception{
			return sst.delete("Tip.deleteScrap", seq);
		}
		
		public int deleteScrapBySeq(int seq) throws Exception{
			return sst.delete("Tip.deleteScrapBySeq", seq);
		}
		
		public int scrapCheck(int seq, String id) throws Exception{
			Map<String, Object> param = new HashMap<>();
			param.put("seq", seq);
			param.put("id", id);
			return sst.selectOne("Tip.scrapCheck",param);
		}
		
		public int scrapCount(int seq) throws Exception{
			return sst.selectOne("Tip.scrapCount",seq);
		}
		
		public int scrapPlus(int seq) throws Exception{
			return sst.update("Tip.scrapPlus",seq);
		}
		
		public List<ScrapDTO> myScrap(String id, int currentPage) throws Exception{
			Map<String, Object> map = new HashMap<>();
			int end = currentPage * 10;
			int start = end - 9; 
			map.put("id", id);
			map.put("currentPage", currentPage);
			map.put("start", start);
			map.put("end", end);
			return sst.selectList("Tip.myScrap",map);
		}
		public int myScrapCount(String id) throws Exception{
			return sst.selectOne("Tip.myScrapCount",id);
		}
		
		public int tipCount() throws Exception{
			return sst.selectOne("Tip.tipCount");
		}
		
		public List<CommentDTO> selectByPageCmt(int startNum, int endNum, int seq) throws Exception{
			Map<String, Object> param = new HashMap<>();
			param.put("startNum", startNum);
			param.put("endNum", endNum);
			param.put("seq", seq);
			return sst.selectList("Tip.selectByPageCmt", param);
		}
		
		public List<BoardDTO> selectByPage(int startNum, int endNum) throws Exception{
			Map<String, Object> param = new HashMap<>();
			param.put("startNum", startNum);
			param.put("endNum", endNum);
			return sst.selectList("Tip.selectByPage", param);
		}
		
		public List<BoardDTO> selectByPageTitle(int startNum, int endNum, String input) throws Exception{
			Map<String, Object> param = new HashMap<>();
			param.put("startNum", startNum);
			param.put("endNum", endNum);
			param.put("input", input);
			
			return sst.selectList("Tip.selectByPageTitle", param);
		}
		
		public List<BoardDTO> selectByPageContents(int startNum, int endNum, String input) throws Exception{
			Map<String, Object> param = new HashMap<>();
			param.put("startNum", startNum);
			param.put("endNum", endNum);
			param.put("input", input);
			return sst.selectList("Tip.selectByPageContents", param);
		}
		
		public List<BoardDTO> selectByPageBoth(int startNum, int endNum, String input) throws Exception{
			Map<String, Object> param = new HashMap<>();
			param.put("startNum", startNum);
			param.put("endNum", endNum);
			param.put("input", input);
			return sst.selectList("Tip.selectByPageBoth", param);
		}
		
		public int searchTitleCount(String title) throws Exception{
			return sst.selectOne("Tip.searchTitleCount", title);
		}
		
		public List<BoardDTO> searchContents(String contents) throws Exception{
			return sst.selectList("Tip.searchContents", contents);
		}
		
		public List<BoardDTO> searchBoth(String both) throws Exception{
			return sst.selectList("Tip.searchBoth", both);
		}
		
		public int report(ReportDTO dtoR) throws Exception{
			return sst.insert("Tip.report",dtoR);
		}
		
		public int addComment(CommentDTO dtoC) throws Exception{
			return sst.insert("Tip.addComment",dtoC);
		}
		
		public List<CommentDTO> cmtList(int rootSeq) throws Exception{
			return sst.selectList("Tip.cmtList", rootSeq);
		}
		
		public int cmtDelete(int seq) throws Exception{
			return sst.delete("Tip.cmtDelete", seq);
		}
		
		public int commentDelete(int seq) throws Exception{
			return sst.delete("Tip.commentDelete", seq);
		}
		
		public int cmtCount(int seq) throws Exception{
			//여기서 seq는 게시글의 seq이므로 rootSeq이다.
			return sst.selectOne("Tip.cmtCount", seq);
		}
		
		public int getRootSeq(int seq) throws Exception{
			return sst.selectOne("Tip.getRootSeq", seq);
		}
		
		public int cmtUpdate(int seq, String contents) throws Exception{
			Map<String, Object> param = new HashMap<>();
			param.put("seq", seq);
			param.put("contents", contents);
			return sst.update("Tip.cmtUpdate",param );
		}
		
}
