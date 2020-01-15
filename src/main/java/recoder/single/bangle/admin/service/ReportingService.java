package recoder.single.bangle.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.admin.DAO.ReportingDAO;
import recoder.single.bangle.admin.DTO.ReportingDTO;

@Service
public class ReportingService {

	@Autowired
	private ReportingDAO dao;
	
	public List<ReportingDTO> getReportingList() {
		return dao.getReportingList();
	}
	
	public boolean confirmReporting(int seq) {
		int result = dao.confirmReporting(seq);
		if (result > 0) return true;
		else return false;
	}

	public boolean addReporting(String id, String reason, String url) {
		int result = dao.addReporting(id, reason, url);
		if (result > 0) return true;
		else return false;
	}

}
