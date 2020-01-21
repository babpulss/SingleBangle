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
		return jdbc.selectOne("Msg.notRead", receiver);
	}
	
	public int writeMsg(MsgDTO dto, String sender) throws Exception{
		Map<String, Object> param = new HashMap<>();
		param.put("sender", sender);
		param.put("receiver", dto.getReceiver());
		param.put("title", dto.getTitle());
		param.put("contents", dto.getContents());
		return jdbc.insert("Msg.writeMsg", param);
	}

}
