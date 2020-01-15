package recoder.single.bangle.remarket.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import recoder.single.bangle.remarket.DAO.MsgDAO;

@Service
public class MsgService {
	
	@Autowired
	private MsgDAO dao;
	
	@Autowired
	private HttpSession session;

	@Autowired
	private HttpServletRequest request;
	
	@Transactional("memberManager")
	public void writeMsg(String sender, String receiver, String title, String contents) {
		try {
			dao.writeMsg(sender, receiver, title, contents);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
