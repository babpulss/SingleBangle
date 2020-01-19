package recoder.single.bangle.remarket.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import configuration.Configuration;
import recoder.single.bangle.remarket.DTO.MarketDTO;

@Repository
public class MarketDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(String title, int price, String content, String id, String category, String place) throws Exception{
		String sql = "insert into market values(market_seq.nextval,?,?,?,?,?,?,sysdate,0)";
		return jdbc.update(sql, title, price, content, id, category, place);
	}
	
	public int insertReport(String id, String url, String reason)throws Exception{
		String sql = "insert into report values(report_seq.nextval,?,sysdate,?,?)";
		return jdbc.update(sql, id, url, reason);
	}	
	
	public int insertFile(String id) throws Exception{
		String sql = "select max(seq) from market where writer = ?";
		return jdbc.queryForObject(sql, Integer.class, id);
		};
		
	public int delete(int seq) throws Exception{
		System.out.println("삭제dao 도착");
		String sql = "delete from market where seq = ?";
		return jdbc.update(sql, seq);
	}
	
	public int update(String title, int price, String content, String category, int seq) throws Exception{
		String sql = "update market set title = ?, price = ?, content =?, category = ? where seq = ?";
		return jdbc.update(sql, title, price, content, category, seq); 
	}
	
	public List<MarketDTO> getBoardList() throws Exception{
		String sql = "select * from market order by 1 desc";
		return jdbc.query(sql, new RowMapper<MarketDTO>() {
			@Override
			public MarketDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MarketDTO dto = new MarketDTO();
				dto.setSeq(rs.getInt("seq"));
				dto.setTitle(rs.getString("title"));
				dto.setPrice(rs.getInt("price"));
				dto.setContent(rs.getString("content"));
				dto.setPlace(rs.getString("place"));
				dto.setWriter(rs.getString("writer"));
				dto.setWriteDate(rs.getTimestamp("writeDate"));
				dto.setViewCount(rs.getInt("viewCount"));
				return dto;
			}
		});
	}
	
	public MarketDTO writeDetail(int seq) throws Exception{
		String sql = "select * from market where seq = ?";
		return jdbc.queryForObject(sql, new Object[] {seq}, new RowMapper<MarketDTO>() {
			@Override
			public MarketDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MarketDTO dto = new MarketDTO();
				dto.setSeq(rs.getInt("seq"));
				dto.setCategory(rs.getString("category"));
				dto.setPlace(rs.getString("place"));
				dto.setPrice(rs.getInt("price"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setContent(rs.getString("content"));
				return dto;
			}
		});
	}
	
	public List<MarketDTO> search(String title, String category) throws Exception{
		String sql = "select * from market where title like ? and category = ?";
		System.out.println("category : " + category + "title : " + title);
		title = "%" + title + "%";
		return jdbc.query(sql, new Object[] {title, category}, new RowMapper<MarketDTO>() {
			@Override
			public MarketDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MarketDTO dto = new MarketDTO();
				dto.setSeq(rs.getInt("seq"));
				dto.setTitle(rs.getString("title"));
				dto.setCategory(rs.getString("category"));
				dto.setPrice(rs.getInt("price"));
				dto.setPlace(rs.getString("place"));
				return dto;
			}
		});
	}
	
	public List<MarketDTO> searchNoCategory(String title) throws Exception{
		String sql = "select * from market where title like ?";
		title = "%" + title + "%";
		return jdbc.query(sql, new Object[] {title}, new RowMapper<MarketDTO>() {
			@Override
			public MarketDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MarketDTO dto = new MarketDTO();
				dto.setSeq(rs.getInt("seq"));
				dto.setTitle(rs.getString("title"));
				dto.setCategory(rs.getString("category"));
				dto.setPrice(rs.getInt("price"));
				dto.setPlace(rs.getString("place"));
				return dto;
			}
		});
	}
	
	public List<MarketDTO> searchNoTitle(String category) throws Exception{
		String sql = "select * from market where category = ?";
		return jdbc.query(sql, new Object[] {category}, new RowMapper<MarketDTO>() {
			@Override
			public MarketDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MarketDTO dto = new MarketDTO();
				dto.setSeq(rs.getInt("seq"));
				dto.setTitle(rs.getString("title"));
				dto.setCategory(rs.getString("category"));
				dto.setPrice(rs.getInt("price"));
				dto.setPlace(rs.getString("place"));
				return dto;
			}
		});
	}
	
	public int updateViewCount(int seq) throws Exception{
		String sql = "update market set view_count = view_count+1  where seq = ?";
		return jdbc.update(sql, seq);
	}
	
	public List<MarketDTO> selectByPage(int start, int end) throws Exception{
		String sql = "select * from(select market.*, row_number() over (order by seq desc)rown from market)"
				+ "where rown between ? and ?";
		return jdbc.query(sql, new Object[] {start, end}, new RowMapper<MarketDTO>() {
			@Override
			public MarketDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MarketDTO dto = new MarketDTO();
				dto.setSeq(rs.getInt("seq"));
				dto.setTitle(rs.getString("title"));
				dto.setCategory(rs.getString("category"));
				dto.setPrice(rs.getInt("price"));
				dto.setPlace(rs.getString("place"));
				return dto;
			}
		});
	}

		public int getArticleCount() throws Exception{ //게시판 내의 총 글 수
			String sql = "select count(*) from market";
			return jdbc.queryForObject(sql, Integer.class);
		}

		public String getPageNavi(int currentPage) throws Exception { //게시판에서 페이지 넘기기 (int 값은 모두 예시)
			// 필요정보 : 게시판 내의 총 글의 갯수, 한 페이지에 몇개의 글을 보여줄것인지, 한 화면에 페이지값을 몇개 보여줄것인지
			int recordTotalCount = this.getArticleCount(); //게시판 내의 총 글의 갯수(db에 몇개의 글이 있는지)
			int recordCountPerPage = 10; // 한 페이지에 보여줄 글의 갯수
			int naviCountPerPage = 10; //한 페이지에서 몇개의 네비게이터를 보여줄 것인 지 설정 / 현재 내가 4에 있으면 네비게이터에서는 1부터 10까지 볼 수 있음
			int pageTotalCount = 0;//총 몇개의 페이지인지

			if(recordTotalCount % Configuration.recordCountPerPage > 0) { // recordTotalCount를 recordCountPerPage로 나누었을때 나머지가 0보다 크다면(즉, 나머지가 생긴다면)
				pageTotalCount = recordTotalCount/Configuration.recordCountPerPage +1;
			}else {
				pageTotalCount = recordTotalCount/Configuration.recordCountPerPage;
			}

			if(currentPage < 1) { //페이지값을 1 이하 숫자로 하는 경우
				currentPage = 1;
			}else if(currentPage > pageTotalCount){ // 마지막 페이지값보다 높은 페이지값을 요청하는 경우
				currentPage = pageTotalCount;
			}

			int startNavi = ((currentPage-1) / naviCountPerPage) * naviCountPerPage + 1; //현재 페이지 위치에서 볼 수 있는 네비게이터의 시작 값
			int endNavi = startNavi + naviCountPerPage - 1; //현재 페이지 위치에서 볼 수 있는 네비게이터의 마지막 값.

			if(endNavi > pageTotalCount) { //페이지 끝 값이 비정상적일때/ 총 15페이지가 있을때 15페이지를 선택하면 보여지는 네비는 11-20이 아니라 11-15여야함
				endNavi = pageTotalCount;
			}
			boolean needPrev = true; // < 표시가 필요한지
			boolean needNext = true; // > 표시가 필요한지

			if(startNavi == 1) {
				needPrev = false;
			}
			if(endNavi == pageTotalCount) {
				needNext = false;
			}

			StringBuilder sb = new StringBuilder(); // += 연산자 대신 사용(가독성을 위해)

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
}
