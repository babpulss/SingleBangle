package recoder.single.bangle.remarket.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.remarket.DTO.MarketFileDTO;

@Repository
public class MarketFileDAO {
	
	@Autowired
	private SqlSessionTemplate jdbc;
	
	public int insert(MarketFileDTO dto) throws Exception {
		return jdbc.insert("MarketFile.insert", dto);
	}
	
	public int update(MarketFileDTO dto) {
		return jdbc.update("MarketFile.update", dto);
	}
	
	public int delete(int board_seq) {
		return jdbc.delete("MarketFile.delete", board_seq);
	}
	
	public List<MarketFileDTO> selectAll() {
		return jdbc.selectList("MarketFile.selectAll");
	}
	
	public List<MarketFileDTO> selectByPage(int start, int end) throws Exception{
		HashMap<String, Object> param = new HashMap<>();
		param.put("start", start);
		param.put("end", end);
		return jdbc.selectList("MarketFile.selectByPage", param);
	}
	
	public String review (int board_seq) {
		return jdbc.selectOne("MarketFile.review", board_seq);
	}
	
//	public List<FileDTO> selectByPageUseTitle(int board_seq, int start, int end) throws Exception{
//		String sql = "select * from (select marketFile.*,row_number() over(order by board_seq desc)rown " + 
//				"from marketFile where board_seq = ? and (board_seq, seq) in (select board_seq, max(seq) from marketFile group by board_seq) order by 1 desc) " + 
//				"where (rown between ? and ?)";
//		return jdbc.query(sql, new Object[] {board_seq, start, end}, new RowMapper<FileDTO>() {
//			@Override
//			public FileDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
//				FileDTO dto = new FileDTO();
//				dto.setSeq(rs.getInt("seq"));
//				dto.setBoard_seq(rs.getInt("board_seq"));
//				dto.setOri_name(rs.getString("ori_name"));
//				dto.setSys_name(rs.getString("sys_name"));
//				return dto;
//			}
//		});
//	}
	
	public MarketFileDTO selectByPageUseTitle(int board_seq, int start, int end) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("board_seq", board_seq);
		param.put("start", start);
		param.put("end", end);
		return jdbc.selectOne("MarketFile.selectByPageUseTitle", param);
	}
	
	public String searchReview(int board_seq) {
		System.out.println(board_seq);
		return jdbc.selectOne("MarketFile.searchReview", board_seq);

	}
}
