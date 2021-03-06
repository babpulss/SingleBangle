package recoder.single.bangle.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.admin.DAO.BlackListDAO;
import recoder.single.bangle.admin.DTO.BlackMemberDTO;
import recoder.single.bangle.member.DAO.MemberDAO;
import recoder.single.bangle.member.DTO.MemberDTO;

@Service
public class BlackListService {
	
	@Autowired
	private BlackListDAO blackListDAO;
	
	@Autowired
	private MemberDAO memberDAO;

	public List<BlackMemberDTO> getBlackList()  throws Exception {
		return blackListDAO.getBlackList();
	}
	
	public boolean unblock(String id)  throws Exception {
		int result = blackListDAO.unblock(id);
		if (result > 0) return true;
		else return false;
	}
	
	public boolean block(BlackMemberDTO dto)  throws Exception {
		int result = blackListDAO.block(dto);
		if (result > 0) return true;
		else return false;
	}

	public BlackMemberDTO searchByBlockedId(String id)  throws Exception {
		return blackListDAO.searchByBlockedId(id);
	}
	
	public MemberDTO searchId(String id) throws Exception {
		return  memberDAO.selectById(id);
	}

	public int checkId(String id)  throws Exception {
		return blackListDAO.checkId(id);
		
	}
}
