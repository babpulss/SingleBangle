package recoder.single.bangle.remarket.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import utils.Configuration;
import recoder.single.bangle.remarket.DTO.MarketDTO;
import recoder.single.bangle.remarket.DTO.MsgDTO;

@Repository
public class MsgDAO {

	@Autowired
	private SqlSessionTemplate jdbc;

	@Autowired
	private HttpServletRequest request;

	public List<MsgDTO> selectAllMsg(String receiver)throws Exception{
		System.out.println("receiver : " + receiver);
		return jdbc.selectList("Msg.selectAllMsg", receiver);
	}

	public MsgDTO msgDetail(int seq) throws Exception{
		return jdbc.selectOne("Msg.msgDetail", seq);
	}

	public int updateRead(int seq) throws Exception{
		return jdbc.update("Msg.updateRead", seq);
	}

	public int notRead(String receiver) throws Exception{
		int a =  jdbc.selectOne("Msg.notRead", receiver);
		System.out.println(a);
		return a;
	}
	
	public int deleteMsg(int seq) throws Exception{
		return jdbc.delete("Msg.deleteMsg", seq);
	}

	public int writeMsg(MsgDTO dto, String title, String contents, String sender) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("sender", sender);
		param.put("receiver", dto.getReceiver());
		param.put("title", dto.getTitle());
		param.put("contents", contents);
		return jdbc.insert("Msg.writeMsg", param);
	}

	public List<MsgDTO> selectByPage(int start, int end, String receiver) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("start", start);
		param.put("end", end);
		param.put("receiver", receiver);
		return jdbc.selectList("Msg.selectByPage", param);
	}

	public int getArticleCount(String receiver) throws Exception{ //로그인 한 사람이 받은 쪽지 갯수
		return jdbc.selectOne("Msg.getArticleCount", receiver);
	}

	//받은쪽지함 페이징
	public String getPageNavi(int currentPage, String receiver) throws Exception { 
		int recordTotalCount = this.getArticleCount(receiver); 
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
			sb.append("<a href='msgList.do?receiver="+receiver+"&cpage="+(startNavi - 1)+"'> < </a>");
		}
		for(int i = startNavi; i <= endNavi; i++) {
			sb.append("<a href='msgList.do?receiver="+receiver+"&cpage="+i+"'>"); //cpage = currentpage
			sb.append(i + " ");
			sb.append("</a>");
		}
		if(needNext) {
			sb.append("<a href='msgList.do?receiver="+receiver+"&cpage="+(endNavi + 1) +"' > > </a>");
		}
		return sb.toString();
	}
	
	//보낸쪽지함
	public List<MsgDTO> selectBySendPage(int start, int end, String sender) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("start", start);
		param.put("end", end);
		param.put("sender", sender);
		return jdbc.selectList("Msg.selectBySendPage", param);
	}

	public int getSendArticleCount(String sender) throws Exception{ //로그인 한 사람이 받은 쪽지 갯수
		return jdbc.selectOne("Msg.getSendArticleCount", sender);
	}

	//받은쪽지함 페이징
	public String getSendPageNavi(int currentPage, String sender) throws Exception { 
		int recordTotalCount = this.getSendArticleCount(sender);
		System.out.println("sender : " + sender + "int : " + recordTotalCount);
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
			sb.append("<a href='sendMsg.do?sender="+sender+"&cpage="+(startNavi - 1)+"'> < </a>");
		}
		for(int i = startNavi; i <= endNavi; i++) {
			sb.append("<a href='sendMsg.do?sender="+sender+"&cpage="+i+"'>"); //cpage = currentpage
			sb.append(i + " ");
			sb.append("</a>");
		}
		if(needNext) {
			sb.append("<a href='sendMsg.do?sender="+sender+"&cpage="+(endNavi + 1) +"' > > </a>");
		}
		return sb.toString();
	}

}
