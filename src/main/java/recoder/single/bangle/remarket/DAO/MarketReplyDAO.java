package recoder.single.bangle.remarket.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import configuration.Configuration;
import recoder.single.bangle.remarket.DTO.MarketReplyDTO;

@Repository
public class MarketReplyDAO {
	@Autowired
	private SqlSessionTemplate jdbc;

	public int insert(String recontent, String writer, int boardSeq) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("recontent", recontent);
		param.put("writer", writer);
		param.put("boardSeq", boardSeq);
		return jdbc.update("MarketReply.insert", param);
	}

	public List<MarketReplyDTO> list(int boardSeq){
		return jdbc.selectList("MarketReply.list", boardSeq);
	}

	public int delete(int seq) throws Exception{
		return jdbc.delete("MarketReply.delete", seq);
	}

	public int deleteUseBoardSeq(int boardSeq) throws Exception{
		return jdbc.delete("MarketReply.deleteUseBoardSeq", boardSeq);
	}

	public int update(String recontent, int seq) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("recontent", recontent);
		param.put("seq", seq);
		return jdbc.update("MarketReply.update", param);
	}

	//댓글페이징//
	public List<MarketReplyDTO> selectByPage(int start, int end, int boardSeq) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("start", start);
		param.put("end", end);
		param.put("boardSeq", boardSeq);
		return jdbc.selectList("MarketReply.selectByPage", param);
	}

	public int getArticleCount(int boardSeq) throws Exception{
		return jdbc.selectOne("MarketReply.getArticleCount", boardSeq);
	}

	public String getPageNavi(int currentPage, int boardSeq) throws Exception { 
		int recordTotalCount = this.getArticleCount(boardSeq); 
		int recordCountPerPage = 10; 
		int naviCountPerPage = 10; 
		int pageTotalCount = 0;

		if(recordTotalCount % Configuration.recordCountPerPage > 0) { 
			pageTotalCount = recordTotalCount/Configuration.recordCountPerPage +1;
		}else {
			pageTotalCount = recordTotalCount/Configuration.recordCountPerPage;
		}

		if(currentPage < 1) { 
			currentPage = 1;
		}else if(currentPage > pageTotalCount){ 
			currentPage = pageTotalCount;
		}

		int startNavi = ((currentPage-1) / naviCountPerPage) * naviCountPerPage + 1;
		int endNavi = startNavi + naviCountPerPage - 1; 

		if(endNavi > pageTotalCount) { 
			endNavi = pageTotalCount;
		}
		boolean needPrev = true; 
		boolean needNext = true; 

		if(startNavi == 1) {
			needPrev = false;
		}
		if(endNavi == pageTotalCount) {
			needNext = false;
		}

		StringBuilder sb = new StringBuilder(); 

		if(needPrev) {
			sb.append("<a href='marketDetail.do?seq="+boardSeq+"&cpage="+(startNavi - 1)+"'> < </a>");
		}
		for(int i = startNavi; i <= endNavi; i++) {
			sb.append("<a href='marketDetail.do?seq="+boardSeq+"&cpage="+i+"'>"); 
			sb.append(i + " ");
			sb.append("</a>");
		}
		if(needNext) {
			sb.append("<a href='marketDetail.do?seq="+boardSeq+"&cpage="+(endNavi + 1) +"' > > </a>");
		}
		return sb.toString();
	}
}
