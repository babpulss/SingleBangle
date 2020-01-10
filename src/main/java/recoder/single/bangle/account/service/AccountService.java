package recoder.single.bangle.account.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import recoder.single.bangle.account.DAO.AccountDAO;
import recoder.single.bangle.account.DTO.AccountDTO;

@Component
public class AccountService {

	@Autowired
	private AccountDAO dao;

	private AccountDTO dto;

	public List<AccountDTO> monthListById(HttpSession session) throws Exception {
		String id = (String) session.getAttribute("id");

		return dao.getMyAccountAll(id);
	}

	public List<AccountDTO> ListAllByFormedReportingDate(HttpSession session,String formedDate) throws Exception {
		String id = (String) session.getAttribute("id");
		return dao.getMyAccountAllByFormedReportingDate(id,formedDate);
	}

}
