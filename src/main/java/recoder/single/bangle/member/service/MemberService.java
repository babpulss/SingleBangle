package recoder.single.bangle.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.member.DAO.MemberDAO;
import recoder.single.bangle.member.DTO.MemberDTO;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO dao;
	
	public int signUp(MemberDTO dto) {
		int signUpResult = 0;
		try {
			signUpResult = dao.insert(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return signUpResult;
	}
	
	public int idDuplCheck(String id) {
		int duplResult = 0;
		try {
			duplResult = dao.isIdExist(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return duplResult;
	}
	
	public int login(MemberDTO dto) {
		int loginResult = 0;
		try {
			loginResult = dao.loginCheck(dto.getId(), dto.getPw());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return loginResult;
	}
	
	public MemberDTO myInfo(String id) {
		MemberDTO infoResult = null;
		try {
			infoResult = dao.selectById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return infoResult;
	}
	
	public int modifyInfo(MemberDTO dto) {
		int updateResult = 0;
		try {
			updateResult = dao.update(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return updateResult;
	}
	
	public int withdraw(String id) {
		int deleteResult = 0;
		try {
			deleteResult = dao.deleteById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return deleteResult;
	}
}
