package recoder.single.bangle.account.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.account.DTO.AccountDTO;

@Repository
public class AccountDAO {
	
	@Autowired
	private SqlSessionTemplate accountJdbc;
	
	public List<AccountDTO> getMyAccountAll(String id){
		List<AccountDTO> list = accountJdbc.selectList("account.selectAccountAll",id);
		System.out.println(list.get(0));
		return list;
	}
	
	public List<AccountDTO> getMyAccountAllByFormedReportingDate(String id,String formedDate){
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		param.put("formedDate", formedDate);
		List<AccountDTO> list = accountJdbc.selectList("account.ListAllByFormedReportingDate", param);
		System.out.println(list.get(0));
		return list;
	}
}
