package recoder.single.bangle.admin.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.admin.DTO.BlackMemberDTO;

@Repository
public class BlackListDAO {

	@Autowired
	private SqlSessionTemplate sst;
	
	public List<BlackMemberDTO> getBlackList()  throws Exception {
		return sst.selectList("Admin.getBlackList");
	}
	
	public int unblock(String id)  throws Exception {
		return sst.delete("Admin.unblock", id);
	}
	
	public int block(BlackMemberDTO dto)  throws Exception {
		return sst.insert("Admin.block", dto);
	}

	public BlackMemberDTO searchByBlockedId(String id)  throws Exception {
		return sst.selectOne("Admin.searchByBlockedId", id);
	}

	public int checkId(String id)  throws Exception {
		Integer result = sst.selectOne("Admin.checkId", id);
		return result == null ? 0 : result;
	}
}
