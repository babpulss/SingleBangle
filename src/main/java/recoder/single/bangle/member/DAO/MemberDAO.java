package recoder.single.bangle.member.DAO;

import java.util.HashMap;
import java.util.List;
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
	
	public List<String> findId(String name, String phone) throws Exception{
		Map<String, String> param = new HashMap<>();
		param.put("name", name);
		param.put("phone", phone);
		return sst.selectList("Member.findId", param);
	}
	
	public int findPw(String id, String email) throws Exception {
		Map<String, String> param = new HashMap<>();
		param.put("id", id);
		param.put("email", email);
		return sst.selectOne("Member.findPw", param);
	}
	
	public int updatePw(String id, String pw) throws Exception {
		Map<String, String> param = new HashMap<>();
		param.put("id", id);
		param.put("pw", pw);
		return sst.update("Member.updatePw", param);
	}
	
	public MemberDTO selectById(String id) throws Exception {
		return sst.selectOne("Member.selectById", id);
	}
	
	public int update(MemberDTO dto) throws Exception {
		return sst.update("Member.update", dto);
	}
	
	public int pwCheck(String id, String pw) throws Exception {
		Map<String, String> param = new HashMap<>();
		param.put("id", id);
		param.put("pw", pw);
		return sst.selectOne("Member.pwCheck", param);
	}
	
	public int deleteById(String id) throws Exception {
		return sst.delete("Member.deleteById", id);
	}
}
