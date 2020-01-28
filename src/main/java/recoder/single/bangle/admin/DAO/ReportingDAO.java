package recoder.single.bangle.admin.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.admin.DTO.ReportingDTO;

@Repository
public class ReportingDAO {

	@Autowired
	private SqlSessionTemplate sst;
	
	public List<ReportingDTO> getReportingList() throws Exception {
		return sst.selectList("Admin.getReportingList");
	}
	
	public int deleteReporting(int seq)  throws Exception {
		return sst.delete("Admin.deleteReporting", seq);
	}

	public int confirmReporting(int seq)  throws Exception {
		return sst.update("Admin.confirmReporting", seq);
	}

	public int addReporting(String id, String reason, String url)  throws Exception {
		Map<String, String> param = new HashMap<>();
		param.put("id", id);
		param.put("reason", reason);
		param.put("url", url);
		return sst.insert("Admin.addReporting", param);
	}
}
