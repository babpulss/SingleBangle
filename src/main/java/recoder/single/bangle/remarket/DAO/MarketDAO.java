package recoder.single.bangle.remarket.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import configuration.Configuration;
import recoder.single.bangle.remarket.DTO.MarketDTO;
import recoder.single.bangle.tipBoard.DTO.ReportDTO;

@Repository
public class MarketDAO {
	
	@Autowired
	private SqlSessionTemplate jdbc;

	public int insert(MarketDTO dto, String content, String writer, String place, String gender) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("title", dto.getTitle());
		param.put("price", dto.getPrice());
		param.put("content", content);
		param.put("writer", writer);
		param.put("category", dto.getCategory());
		param.put("place", place);
		param.put("gender", gender);
		return jdbc.insert("Market.insert", param);
	}
	
	public int updateSellDone(int seq) throws Exception{
		return jdbc.update("Market.updateSellDone", seq);
	}

	public int insertFile(String writer) throws Exception{
		return jdbc.selectOne("Market.insertFile", writer);
	};

	public int delete(int seq) throws Exception{
		return jdbc.delete("Market.delete", seq);
	}

	public int update(MarketDTO dto, String content, String writer) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("title", dto.getTitle());
		param.put("price", dto.getPrice());
		param.put("content", content);
		param.put("writer", writer);
		param.put("category", dto.getCategory());
		param.put("seq", dto.getSeq());
		return jdbc.update("Market.update", param);
	}

	public List<MarketDTO> getBoardList() throws Exception{
		return jdbc.selectList("Market.getBoardList");
	}

	public MarketDTO writeDetail(int seq) throws Exception{ //게시글상세
		return jdbc.selectOne("Market.writeDetail", seq);
	}
	
	public void reportProc(String id, ReportDTO dto) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("reason", dto.getReason());
		param.put("reportedUrl", dto.getReportedUrl());
		System.out.println(id + " : " + dto.getReason() + " : " + dto.getReportedUrl());
		jdbc.insert("Market.reportProc", dto);
	}

	public List<MarketDTO> search(String title, String category) throws Exception{
		title = "%" + title + "%";
		Map<String, String> param = new HashMap<>();
		param.put("title", title);
		param.put("category", category);
		return jdbc.selectList("Market.search", param);
	}

	public List<MarketDTO> searchNoCategory(String title) throws Exception{
		title = "%" + title + "%";
		return jdbc.selectList("Market.searchNoCategory", title);
	}

	public List<MarketDTO> searchNoTitle(String category) throws Exception{
		return jdbc.selectList("Market.searchNoTitle", category);
	}

	public List<MarketDTO> selectByPage(int start, int end) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("start", start);
		param.put("end", end);
		return jdbc.selectList("Market.selectByPage", param);
	}

		public int getArticleCount() throws Exception{ //게시판 내의 총 글 수
			return jdbc.selectOne("Market.getArticleCount");
		}
		
		//전체 게시판리스트 페이징
		public String getPageNavi(int currentPage) throws Exception { 
			int recordTotalCount = this.getArticleCount(); 
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
				sb.append("<a href='boardList.do?cpage="+(startNavi - 1)+"'> < </a>");
			}
			for(int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href='boardList.do?cpage="+i+"'>"); //cpage = currentpage
				sb.append(i + " ");
				sb.append("</a>");
			}
			if(needNext) {
				sb.append("<a href='boardList.do?cpage="+(endNavi + 1) +"' > > </a>");
			}
			return sb.toString();
		}
		
		public List<MarketDTO> selectByPageUseTitle(String title, int start, int end) throws Exception{
			title = "%" + title + "%";
			Map<String, Object> param = new HashMap<>();
			param.put("title", title);
			param.put("start", start);
			param.put("end", end);
			return jdbc.selectList("Market.selectByPageUseTitle", param);
		}
	
		public int getArticleCountUseTitle(String title) throws Exception{ //검색 내의 총 글 수
			return jdbc.selectOne("Market.getArticleCountUseTitle", title);
		}
		
		public String getPageNaviUseTitle(int currentPage, String title) throws Exception {
			int recordTotalCount = this.getArticleCountUseTitle(title);
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
				sb.append("<a href='search.do?category=전체&title="+title+"&cpage="+(startNavi - 1)+"'> < </a>");
			}
			for(int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href='search.do?category=전체&title="+title+"&cpage="+i+"'>"); //cpage = currentpage
				sb.append(i + " ");
				sb.append("</a>");
			}
			if(needNext) {
				sb.append("<a href='search.do?category=전체&title="+title+"&cpage="+(endNavi + 1) +"' > > </a>");
			}
			return sb.toString();
		}
		
		
		public List<MarketDTO> selectByPageUseCategory(String category, int start, int end) throws Exception{
			Map<String, Object> param = new HashMap<>();
			param.put("category", category);
			param.put("start", start);
			param.put("end", end);
			return jdbc.selectList("Market.selectByPageUseCategory", param);
		}
		//check
		
		public int getArticleCountUseCategory(String category) throws Exception{ //검색 내의 총 글 수
			return jdbc.selectOne("Market.getArticleCountUseCategory", category);
		}		
		
		public String getPageNaviUseCaTi(int currentPage, String category, String title) throws Exception { 
			int recordTotalCount = this.getArticleCountUseCaTi(category, title);
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
				sb.append("<a href='search.do?category="+category+"&title="+title+"&cpage="+(startNavi - 1)+"'> < </a>");
			}
			for(int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href='search.do?category="+category+"&title="+title+"&cpage="+i+"'>"); //cpage = currentpage
				sb.append(i + " ");
				sb.append("</a>");
			}
			if(needNext) {
				sb.append("<a href='search.do?category="+category+"&cpage="+(endNavi + 1) +"' > > </a>");
			}
			return sb.toString();
		}
		
		//카테고리 제목 동시에 검색하기
		public List<MarketDTO> selectByPageUseCaTi(String category, String title, int start, int end) throws Exception{
			title = "%" + title + "%";
			Map <String, Object> param = new HashMap<>();
			param.put("category", category);
			param.put("title", title);
			param.put("start", start);
			param.put("end", end);
			return jdbc.selectList("Market.selectByPageUseCaTi", param);
		}
		
		public int getArticleCountUseCaTi(String category, String title) throws Exception{ //검색 내의 총 글 수
			Map<String, Object> param = new HashMap<>();
			param.put("category", category);
			param.put("title", title);
			return jdbc.selectOne("Market.getArticleCountUseCaTi", param);
		}
		
		
		public String getPageNaviUseCategory(int currentPage, String category) throws Exception { 
			int recordTotalCount = this.getArticleCountUseCategory(category); 
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
				sb.append("<a href='search.do?category="+category+"&cpage="+(startNavi - 1)+"'> < </a>");
			}
			for(int i = startNavi; i <= endNavi; i++) {
				sb.append("<a href='search.do?category="+category+"&cpage="+i+"'>"); 
				sb.append(i + " ");
				sb.append("</a>");
			}
			if(needNext) {
				sb.append("<a href='search.do?category="+category+"&cpage="+(endNavi + 1) +"' > > </a>");
			}
			return sb.toString();
		}
}
