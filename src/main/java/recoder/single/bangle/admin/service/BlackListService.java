package recoder.single.bangle.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.admin.DAO.BlackListDAO;
import recoder.single.bangle.admin.DTO.BlackMemberDTO;

@Service
public class BlackListService {
	
	@Autowired
	private BlackListDAO blackListDAO;

	public List<BlackMemberDTO> getBlackList() {
		return blackListDAO.getBlackList();
	}
	
	public boolean unblock(String id) {
		int result = blackListDAO.unblock(id);
		if (result > 0) return true;
		else return false;
	}
	
	public boolean block(String id, String reason) {
		int result = blackListDAO.block(id, reason);
		if (result > 0) return true;
		else return false;
	}

	public List<BlackMemberDTO> searchByBlockedId(String id) {
		return blackListDAO.searchByBlockedId(id);
	}
}
