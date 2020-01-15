package recoder.single.bangle.remarket.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.remarket.DAO.MarketReplyDAO;
import recoder.single.bangle.remarket.DTO.MarketReplyDTO;

@Service
public class MarketReplyService {
	
	@Autowired
	private MarketReplyDAO dao;

	@Autowired
	private HttpSession session;

	@Autowired
	private HttpServletRequest request;

	public void insert(String recontent, String id, int boardSeq) {
		try {
			dao.insert(recontent, id, boardSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public List<MarketReplyDTO> list(int boardSeq) {
		List<MarketReplyDTO> list = dao.list(boardSeq);
		return list;
	}
	
	public void delete(int seq) {
		try {
			dao.delete(seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteUseBoardSeq(int boardSeq) {
		try {
			dao.deleteUseBoardSeq(boardSeq);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int update(String recontent, int seq) {
		try {
			int updateReply = dao.update(recontent, seq);
			System.out.println("댓글 수정? : " + updateReply);
			return updateReply;
		}catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}	
}
