package recoder.single.bangle.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.admin.DAO.BlackListDAO;
import recoder.single.bangle.admin.DTO.BlackMemberDTO;
import recoder.single.bangle.member.DTO.MemberDTO;

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

	public BlackMemberDTO searchByBlockedId(String id) {
		return blackListDAO.searchByBlockedId(id);
	}

	public String searchId(String id) throws Exception {
		MemberDTO dto = blackListDAO.searchID(id);
		return dto.getId();
	}

	public String checkId(String id) throws Exception {
		BlackMemberDTO dto = blackListDAO.checkId(id);
		return dto.getId();
	}

}
