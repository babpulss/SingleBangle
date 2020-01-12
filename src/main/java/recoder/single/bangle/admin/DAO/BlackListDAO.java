package recoder.single.bangle.admin.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.admin.DTO.BlackMember;

@Repository
public class BlackListDAO {

	@Autowired
	private SqlSessionTemplate sst;
	
	public List<BlackMember> getBlackList() {
		return sst.selectList("Admin.getBlackList");
	}
	
	public int unblock(String id) {
		return sst.delete("Admin.unblock", id);
	}
}
