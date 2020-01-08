package recoder.single.bangle.member.DAO;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.member.DTO.MemberDTO;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSessionTemplate sst;
	
	public int insert(MemberDTO dto) throws Exception {
		return sst.insert("Member.insert", dto);
	}
	
	public int isIdExist(String id) throws Exception {
		return sst.selectOne("Member.isIdExist", id);
	}
	
	public int loginCheck(String id, String pw) throws Exception {
		Map<String, String> param = new HashMap<>();
		param.put("id", id);
		param.put("pw", pw);
		return sst.selectOne("Member.loginCheck", param);
	}
	
	
	
	public int deleteById(String id) throws Exception {
		return sst.delete("Member.deleteById", id);
	}
}
