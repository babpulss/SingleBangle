package recoder.single.bangle.remarket.service;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Base64Utils;

import recoder.single.bangle.remarket.DAO.MarketDAO;
import recoder.single.bangle.remarket.DAO.MarketFileDAO;
import recoder.single.bangle.remarket.DTO.MarketDTO;
import recoder.single.bangle.remarket.DTO.MarketFileDTO;

@Service
public class MarketService {
	@Autowired
	private MarketDAO dao;

	@Autowired
	private MarketFileDAO file_dao;

	@Autowired
	private HttpSession session;

	@Autowired
	private HttpServletRequest request;

	@Transactional("memberManager")
	public List<MarketDTO> board() {
		try {
			List<MarketDTO> list = dao.getBoardList();
			return list;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Transactional("memberManager")//글 수정
	public void updateProc(String title, int price, String content, String category, int seq, String path) { //글수정
		File filePath = new File(path);
		String rootPath = session.getServletContext().getRealPath("files"); //경로지정
		Pattern p = Pattern.compile("<img.+?src=\"(.+?)\".+?data-filename=\"(.+?)\".*?>");
		Matcher m = p.matcher(content);
		StringBuffer sb = new StringBuffer();
		if(!filePath.exists()) {
			filePath.mkdir();
		}
		try {
			List<MarketFileDTO> list = new ArrayList<>();
			while(m.find()) {
				String oriName = m.group(2);
				String sysName = System.currentTimeMillis() + "_" + oriName;
				String mgroup = m.group(1);
				String imgString = m.group(1).split(",")[1];
				byte[] imgBytes = Base64Utils.decodeFromString(imgString); // string값을 byte 배열로 만들어서 리턴시킴
				FileOutputStream fos = new FileOutputStream(rootPath + "/" + sysName);
				DataOutputStream dos = new DataOutputStream(fos);
				dos.write(imgBytes);
				dos.flush();
				dos.close();
				content = content.replaceFirst(Pattern.quote(m.group(1)), "/files/"+sysName);
				MarketFileDTO file_dto = new MarketFileDTO(0, 0, oriName, sysName);
				list.add(file_dto);
			}		
			dao.update(title, price, content, category, seq);
			int board_seq = seq;
			for(MarketFileDTO tmp : list) {
				tmp.setBoard_seq(board_seq);
				file_dao.update(tmp, board_seq);
			}

		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("글 업로드 오류");
		}
	}

	@Transactional("memberManager")
	public void delete(int seq) {
		System.out.println("삭제서비스 도착");
		try {
			int result = dao.delete(seq); //삭제성공
			int board_seq = seq;
			file_dao.delete(board_seq);
		}catch(Exception e) {
			e.printStackTrace();

		}
	}

	@Transactional("memberManager")
	public void report(String id, String url, String reason) {
		try {
			dao.insertReport(id, url, reason);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("신고게시판 글작성 오류");
		}

	}

	@Transactional("memberManager")
	public void write(String title, int price, String content, String category, String place, String path, String id) {
		File filePath = new File(path);
		String rootPath = session.getServletContext().getRealPath("files"); //경로지정
		Pattern p = Pattern.compile("<img.+?src=\"(.+?)\".+?data-filename=\"(.+?)\".*?>");
		Matcher m = p.matcher(content);
		StringBuffer sb = new StringBuffer();
		if(!filePath.exists()) {
			filePath.mkdir();
		}
		try {
			List<MarketFileDTO> list = new ArrayList<>();
			while(m.find()) {
				String oriName = m.group(2);
				String sysName = System.currentTimeMillis() + "_" + oriName;
				String mgroup = m.group(1);
				String imgString = m.group(1).split(",")[1];
				byte[] imgBytes = Base64Utils.decodeFromString(imgString); // string값을 byte 배열로 만들어서 리턴시킴
				FileOutputStream fos = new FileOutputStream(rootPath + "/" + sysName);
				DataOutputStream dos = new DataOutputStream(fos);
				dos.write(imgBytes);
				dos.flush();
				dos.close();
				content = content.replaceFirst(Pattern.quote(m.group(1)), "/files/"+sysName);
				MarketFileDTO file_dto = new MarketFileDTO(0, 0, oriName, sysName);
				list.add(file_dto);
			}		
			dao.insert(title, price, content, id, category, place);
			int boardSeq = dao.insertFile(id);
			for(MarketFileDTO tmp : list) {
				tmp.setBoard_seq(boardSeq);
				file_dao.insert(tmp);
			}

		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("글 업로드 오류");
		}
	}

	@Transactional("memberManager")
	public MarketDTO writedetail(int seq) {//게시글 상세
		try {
			MarketDTO dto = dao.writeDetail(seq); // 글 정보가져오기
			//			dao.updateViewCount(seq);//뷰카운트 올라감
			return dto;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Transactional("memberManager")
	public List<MarketDTO> search(String title, String category) {
		try {
			//			System.out.println("검색서비스 : " + title);
			List<MarketDTO> list = dao.search(title, category);
			//			System.out.println("검색서비스 dto : " + dto);
			return list;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("검색기능오류");
			return null;
		}
	}

	@Transactional("memberManager")
	public List<MarketDTO> searchNoCategory(String title) {
		try {
			//			System.out.println("검색서비스 : " + title);
			List<MarketDTO> list = dao.searchNoCategory(title);
			//			System.out.println("검색서비스 dto : " + dto);
			return list;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("검색기능오류");
			return null;
		}
	}

	@Transactional("memberManager")
	public List<MarketDTO> searchNoTitle(String category){
		try {
			List<MarketDTO> list = dao.searchNoTitle(category);
			return list;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("카테고리만 검색하기 오류");
			return null;
		}
	}

	@Transactional("memberManager")
	public MarketDTO report(int seq) {
		try {
			MarketDTO dto = dao.writeDetail(seq);
			return dto;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("신고하기 에러");
			return null;
		}
	}
}
