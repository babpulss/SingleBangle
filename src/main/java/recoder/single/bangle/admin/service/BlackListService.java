package recoder.single.bangle.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.admin.DAO.BlackListDAO;
import recoder.single.bangle.admin.DTO.BlackMember;

@Service
public class BlackListService {
	
	@Autowired
	private BlackListDAO blackListDAO;

	public List<BlackMember> getBlackList() {
		return blackListDAO.getBlackList();
	}
	
	public int unblock(String id) {
		return blackListDAO.unblock(id);
	}
}
