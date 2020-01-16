package recoder.single.bangle.tipBoard.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.tipBoard.DTO.BoardDTO;
import recoder.single.bangle.tipBoard.DTO.ScrapDTO;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSessionTemplate sst;
	
	public int write(BoardDTO dto) throws Exception{
		System.out.println(dto);
		return sst.update("Tip.insert", dto);
	}
	
	public List<BoardDTO> boardList() throws Exception{
		return sst.selectList("Tip.selectAll");
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
		
		public List<ScrapDTO> myScrap(String id) throws Exception{
			return sst.selectList("Tip.myScrap",id);
		}
		
		public int tipCount() throws Exception{
			return sst.selectOne("Tip.tipCount");
		}
}
