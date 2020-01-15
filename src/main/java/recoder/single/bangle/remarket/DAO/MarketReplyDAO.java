package recoder.single.bangle.remarket.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.remarket.DTO.MarketReplyDTO;

@Repository
public class MarketReplyDAO {
	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(String recontent, String id, int boardseq) throws Exception{
		String sql = "insert into marketReply values(marketReply_seq.nextval, ?, sysdate, ?, ?)";
		return jdbc.update(sql, recontent, id, boardseq);
	}
	
	public List<MarketReplyDTO> list(int boardSeq){
		String sql = "select * from marketReply where boardSeq = ?";
		return jdbc.query(sql, new Object[]{boardSeq},new RowMapper<MarketReplyDTO>() {
			@Override
			public MarketReplyDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MarketReplyDTO dto = new MarketReplyDTO();
				dto.setRecontent(rs.getString("recontent"));
				dto.setWriter(rs.getString("writer"));
				dto.setBoardSeq(rs.getInt("boardSeq"));
				dto.setSeq(rs.getInt("seq"));
				return dto;
			}
		});
	}
	
	public int delete(int seq) throws Exception{
		String sql = "delete from marketReply where seq = ?";
		return jdbc.update(sql, seq);
	}
	
	public int deleteUseBoardSeq(int boardSeq) throws Exception{
		String sql = "delete from marketReply where boardSeq = ?";
		return jdbc.update(sql, boardSeq);
	}
	
	public int update(String recontent, int seq) throws Exception{
		String sql = "update marketReply set recontent = ?, writeDate = sysdate where seq = ?";
		return jdbc.update(sql, recontent, seq);
	}
}
