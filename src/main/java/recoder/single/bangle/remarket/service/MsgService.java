package recoder.single.bangle.remarket.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import recoder.single.bangle.remarket.DAO.MsgDAO;
import recoder.single.bangle.remarket.DTO.MsgDTO;

@Service
public class MsgService {
	
	@Autowired
	private MsgDAO dao;

	@Autowired
	private HttpSession session;

	@Autowired
	private HttpServletRequest request;

	@Transactional("tx")
	public void writeMsg(String sender, String receiver, String title, String contents) {
		try {
			dao.writeMsg(sender, receiver, title, contents);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Transactional("tx")
	public List<MsgDTO> msgList(String receiver) {
		try {
			List<MsgDTO> list = dao.selectAllMsg(receiver);
			return list;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("메세지 리스트 서비스 오류");
			return null;
		}
	}
	
	@Transactional("tx")
	public MsgDTO msgDetail(int seq) {
		try {
			dao.viewCount(seq);
			MsgDTO dto = dao.msgDetail(seq);
			return dto;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("메세지 상세보기 서비스 오류");
			return null;
		}
	}
}
