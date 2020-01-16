package recoder.single.bangle.remarket.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.remarket.DTO.MsgDTO;

@Repository
public class MsgDAO {
	@Autowired
	private JdbcTemplate jdbc;
	
	@Autowired
	private HttpServletRequest request;
	
	public List<MsgDTO> selectAllMsg(String receiver)throws Exception{
		System.out.println("receiver : " + receiver);
		String sql = "select * from msgBox where receiver=?";
		return jdbc.query(sql, new RowMapper<MsgDTO>() {
			@Override
			public MsgDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MsgDTO dto = new MsgDTO();
				dto.setSeq(rs.getInt("seq"));
				dto.setSender(rs.getString("sender"));
				dto.setReceiver(rs.getString("receiver"));
				dto.setTitle(rs.getString("title"));
				dto.setContents(rs.getString("contents"));
				dto.setViewCount(rs.getInt("viewCount"));
				return dto;
			}
		},receiver);
	}
	
	public MsgDTO msgDetail(int seq) throws Exception{
		String sql = "select * from msgBox where seq = ?";
		return jdbc.queryForObject(sql, new Object[] {seq}, new RowMapper<MsgDTO>() {
			@Override
			public MsgDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MsgDTO dto = new MsgDTO();
				dto.setSeq(rs.getInt("seq"));
				dto.setSender(rs.getString("sender"));
				dto.setReceiver(rs.getString("receiver"));
				dto.setTitle(rs.getString("title"));
				dto.setContents(rs.getString("contents"));
				return dto;
			}
		});
	}
	
	public int viewCount(int seq) throws Exception{
		String sql = "update msgBox set viewCount =+ viewCount+1 where seq=?";
		return jdbc.update(sql, seq);
	}
	
	public int notReadMsg(String receiver) throws Exception{
		String sql = "select count(*) from msgBox where receiver = ? and viewCount < 1";
		return jdbc.queryForObject(sql, Integer.class, receiver);
	}
	
	public int writeMsg(String sender, String receiver, String title, String contents) throws Exception{
		System.out.println("쪽지 입력창 도착");
		String sql = "insert into msgBox values(msg_seq.nextval, ?, ?, ?, ?, 0)";
		return jdbc.update(sql, sender, receiver, title, contents);
	}

}
