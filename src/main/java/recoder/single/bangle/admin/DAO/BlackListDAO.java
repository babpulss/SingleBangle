package recoder.single.bangle.admin.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.admin.DTO.BlackMemberDTO;
import recoder.single.bangle.member.DTO.MemberDTO;

@Repository
public class BlackListDAO {

	@Autowired
	private SqlSessionTemplate sst;
	
	public List<BlackMemberDTO> getBlackList() {
		return sst.selectList("Admin.getBlackList");
	}
	
	public int unblock(String id) {
		return sst.delete("Admin.unblock", id);
	}
	
	public int block(String id, String reason) {
		Map<String, String> param = new HashMap<>();
		param.put("id", id);
		param.put("reason", reason);
		return sst.insert("Admin.block", param);
	}

	public BlackMemberDTO searchByBlockedId(String id) {
		return sst.selectOne("Admin.searchByBlockedId", id);
	}
	
	public MemberDTO searchID(String id) {
		return sst.selectOne("Member.selectById", id);
	}

	public BlackMemberDTO checkId(String id) {
		return sst.selectOne("Admin.checkId");
	}

}
