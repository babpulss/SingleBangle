package recoder.single.bangle.account.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.account.DAO.AccountDAO;
import recoder.single.bangle.account.DTO.AccountDTO;
import recoder.single.bangle.member.DTO.MemberDTO;

@Service
public class AccountService {

	@Autowired
	private AccountDAO dao;

	// 월별 수입/지출 
	public List<AccountDTO> monthListById(HttpSession session) throws Exception {
		MemberDTO memberdto = (MemberDTO)session.getAttribute("loginInfo");
		String id = memberdto.getId();
		
		return dao.getMyAccountAll(id);
	
	}

	// 월 세부 통계
	public List<AccountDTO> ListAllByFormedReportingDate(HttpSession session,String formedDate) throws Exception {
		String id = (String) session.getAttribute("id");
		return dao.getMyAccountAllByFormedReportingDate(id,formedDate);
	}

	// 카드 수입/지출 합계
	public int cardSummary(List<AccountDTO> list){

		int cardIn = 0;
		int cardOut = 0;


		for(AccountDTO tmp : list) {
			if(tmp.getPayments().equals("카드")&&tmp.getSpec().equals("지출")) {
				cardIn += tmp.getIncome();
				cardOut += tmp.getExpense();
			}
		}
		return cardOut - cardIn;

	}
	// 현금 수입/지출 합계
	public int cashSummary(List<AccountDTO> list){

		int cashIn = 0;
		int cashOut = 0;


		for(AccountDTO tmp : list) {
			if(tmp.getPayments().equals("현금")&&tmp.getSpec().equals("지출")) {
				cashIn += tmp.getIncome();
				cashOut += tmp.getExpense();
			}
		}
		return cashOut - cashIn;

	}
	// 수입 합계
	public int incomeSummary(List<AccountDTO> list){

		int in = 0;

		for(AccountDTO tmp : list) {
			in += tmp.getIncome();
		}
		return in;

	}
	// 지출 합계
	public int outcomeSummary(List<AccountDTO> list){

		int out = 0;

		for(AccountDTO tmp : list) {
			out += tmp.getExpense();

		}
		return out;

	}
	// 회원 이름 뽑기
	public String getUserName(List<AccountDTO> list) {
		return list.get(0).getUserName();		
	}
	
	// 가계부 입력
	public int insertAccountData(AccountDTO dto) {
		
		return dao.insertData(dto);
	}
	
	//가계부 월 전체삭제
	public int deleteAccountByMonth(String formedReportingDate) {
		
		return dao.deleteAccountByMonth(formedReportingDate);
	}
	
	public int modifyAccountData(AccountDTO dto) {
		return dao.modifyAccountUpdate(dto);
	}
}
