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
		
		return list;
	}
	
	public List<AccountDTO> getMyAccountAllByFormedReportingDate(String id,String formedDate){
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		param.put("formedDate", formedDate);
		List<AccountDTO> list = accountJdbc.selectList("account.ListAllByFormedReportingDate", param);
		
		
		return list;
	}
	
	public int insertData(AccountDTO dto) {
		
		return accountJdbc.insert("account.insertAccountData", dto);
	}
	
	public int deleteAccountByMonth(String formedReportingDate) {
		return accountJdbc.delete("account.deleteAccountByMonth", formedReportingDate);
	}
	
	public int modifyAccountUpdate(AccountDTO dto) {
		System.out.println(dto);
		return accountJdbc.update("account.modifyAccount", dto);
	}
}
