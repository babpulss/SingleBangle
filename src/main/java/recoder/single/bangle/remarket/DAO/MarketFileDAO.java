package recoder.single.bangle.remarket.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.remarket.DTO.MarketFileDTO;

@Repository
public class MarketFileDAO {
	
	@Autowired
	private JdbcTemplate jdbc;
	
	public int insert(MarketFileDTO dto) {
		String sql = "insert into marketFile values (file_seq.nextval,?,?,?)";
		return jdbc.update(sql, dto.getBoard_seq(), dto.getOri_name(), dto.getSys_name());
	}
	
	public int update(MarketFileDTO dto, int board_seq) {
		String sql = "update marketFile set ori_name=?, sys_name=? where board_seq=?";
		return jdbc.update(sql, dto.getOri_name(), dto.getSys_name(), board_seq);
	}
	
	public int delete(int board_seq) {
		String sql = "delete from marketFile where board_seq = ?";
		return jdbc.update(sql, board_seq);
	}
	
	public List<MarketFileDTO> selectAll() {
		String sql = "select * from marketFile";
		return jdbc.query(sql, new RowMapper<MarketFileDTO>() {
			@Override
			public MarketFileDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MarketFileDTO dto = new MarketFileDTO();
				dto.setBoard_seq(rs.getInt("board_seq"));
				dto.setSys_name(rs.getString("sys_name"));
				dto.setOri_name(rs.getString("ori_name"));
				return dto;
			}
		});
	}
	
	public String review (int board_seq) {
		String sql = "select sys_name from marketFile where seq=(select max(seq) from marketFile where board_seq = ?)"; //한 게시글에서 seq값 가장 큰 하나만 출력
		return jdbc.queryForObject(sql, String.class, board_seq);
	}
	
	public String searchReview(int board_seq) {
		System.out.println(board_seq);
		String sql = "select sys_name from marketFile where seq=(select max(seq) from marketFile where board_seq = ?)"; //한 게시글에서 seq값 가장 큰 하나만 출력
		return jdbc.queryForObject(sql, String.class, board_seq);
	}
}
