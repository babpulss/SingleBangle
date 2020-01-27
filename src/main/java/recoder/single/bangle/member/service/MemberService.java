package recoder.single.bangle.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.member.DAO.MemberDAO;
import recoder.single.bangle.member.DTO.MemberDTO;
import recoder.single.bangle.tipBoard.DAO.BoardDAO;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO dao;
	
	
	public int signUp(MemberDTO dto) throws Exception {
		int signUpResult = dao.insert(dto);
		return signUpResult;
	}
	
	public int idDuplCheck(String id) throws Exception {
		int duplResult = dao.isIdExist(id);
		return duplResult;
	}
	
	public int login(String id, String pw) throws Exception {
		int loginResult = dao.loginCheck(id, pw);
		return loginResult;
	}
	
	public List<String> findIdResult(String name, String phone) throws Exception {
		List<String> findIdResult = dao.findId(name, phone);
		return findIdResult;
	}
	
	public int findPwResult(String id, String email) throws Exception {
		int findPwResult = dao.findPw(id, email);
		return findPwResult;
	}
	
	public int updatePw(String id, String pw) throws Exception {
		int updatePwResult = dao.updatePw(id, pw);
		return updatePwResult;
	}
	
	public MemberDTO getInfo(String id) throws Exception {
		MemberDTO infoResult = dao.selectById(id);
		return infoResult;
	}
	
	public int modifyInfoProc(MemberDTO dto) throws Exception {
		int updateResult = dao.update(dto);
		return updateResult;
	}
	
	public int pwCheck(String id, String pw) throws Exception {
		int pwCheckResult = dao.pwCheck(id, pw);
		return pwCheckResult;
	}
	
	public int withdraw(String id) throws Exception {
		int deleteResult = dao.deleteById(id);
		return deleteResult;
	}
	
	
	// 마이스크랩 페이지네이션
	public String myScrapPagination(int totalScraps, int currentPage) {
		int countPerPage = 10;
		int articlesPerPage = 10;
		int totalPage;
		if (totalScraps % articlesPerPage == 0)
			totalPage = totalScraps / articlesPerPage;
		else 
			totalPage = totalScraps / articlesPerPage + 1;
		
		int startCount = (currentPage - 1) / countPerPage * countPerPage + 1;
		int lastCount = startCount + countPerPage - 1;
		if (lastCount > totalPage)
			lastCount = totalPage;
		
		StringBuilder sb = new StringBuilder();

		if (startCount != 1) {
			sb.append("<a href='/member/myScrap.mem?currentPage=");
			sb.append(startCount - 1 + "'>");
			sb.append(" < ");
			sb.append("</a>");
		}
		for (int i = startCount; i < lastCount + 1; i++) {
			if (i == currentPage) {
				sb.append(" " + i + " ");
				continue;
			}
			sb.append("<a href='/member/myScrap.mem?currentPage=" + i + "'>");
			sb.append(" " + i + " ");
			sb.append("</a>");
		}
		if (lastCount != totalPage) {
			sb.append("<a href='/member/myScrap.mem?currentPage=");
			sb.append(lastCount + 1 + "'>");
			sb.append(" > ");
			sb.append("</a>");
		}
		
		return sb.toString();
	}
}
