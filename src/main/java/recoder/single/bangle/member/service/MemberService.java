package recoder.single.bangle.member.service;

import java.util.List;

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
	
	public int login(String id, String pw) {
		int loginResult = 0;
		try {
			loginResult = dao.loginCheck(id, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return loginResult;
	}
	
	public List<String> findIdResult(String name, String phone) {
		List<String> findIdResult = null;
		try {
			findIdResult = dao.findId(name, phone);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return findIdResult;
	}
	
	public int findPwResult(String id, String email) {
		int findPwResult = 0;
		try {
			findPwResult = dao.findPw(id, email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return findPwResult;
	}
	
	public int updatePw(String id, String pw) {
		int updatePwResult = 0;
		try {
			updatePwResult = dao.updatePw(id, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return updatePwResult;
	}
	
	public MemberDTO getInfo(String id) {
		MemberDTO infoResult = null;
		try {
			infoResult = dao.selectById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return infoResult;
	}
	
	public int modifyInfoProc(MemberDTO dto) {
		int updateResult = 0;
		try {
			updateResult = dao.update(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return updateResult;
	}
	
	public int pwCheck(String id, String pw) {
		int pwCheckResult = 0;
		try {
			pwCheckResult = dao.pwCheck(id, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pwCheckResult;
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
