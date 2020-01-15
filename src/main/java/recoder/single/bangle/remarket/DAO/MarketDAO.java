package recoder.single.bangle.remarket.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

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
}
