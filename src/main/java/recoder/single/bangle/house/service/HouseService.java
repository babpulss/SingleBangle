package recoder.single.bangle.house.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import recoder.single.bangle.house.DAO.HouseCommentDAO;
import recoder.single.bangle.house.DAO.HouseContentDAO;
import recoder.single.bangle.house.DAO.HouseDAO;
import recoder.single.bangle.house.DTO.HouseCommentDTO;
import recoder.single.bangle.house.DTO.HouseContentDTO;
import recoder.single.bangle.house.DTO.HouseDTO;



@Service
public class HouseService {
	@Autowired
	private HttpSession session;

	@Autowired
	private HouseDAO houseDAO;

	@Autowired
	private HouseContentDAO contentDAO;
	
	@Autowired
	private HouseCommentDAO commentDAO;

	public Map<String, Object> selectFirst() throws Exception {
		//houseMain에 처음 들어오면 최신 10개만 보여줌 
		Map<String, Object> map = new HashMap<>();
		int total = Math.round(houseDAO.selectCount() / 15);
        

		map.put("total", total);
		map.put("content", houseDAO.selectFirst());
		
		//map.put("list", houseDAO.selectFirst());
		//map.put("contentDTO", houseDAO.selectBySeq(seq))
		return map;
	}
	
	public List<Map<String, Object>> getHouseContent(int curPage) {
		int prevPage = curPage -1;
		int startPage = (prevPage * 15) + 1;
		int endPage = curPage * 15;
		System.out.println("현재 " + curPage);
		System.out.println("이전 " + prevPage);
		System.out.println(startPage+ " ~ " + endPage);
		
		return houseDAO.selectAfter(startPage, endPage);
	}
	
	public int writeHouse(HouseDTO houseDTO, List<HouseContentDTO> contentList, MultipartFile[] img) throws Exception {
		System.out.println("HouseService writeHouse 도착");

		String path = session.getServletContext().getRealPath("files");

		File filePath = new File(path);
		if(!filePath.exists()) {
			filePath.mkdir();
		}
		int count = contentList.size();
		System.out.println(contentList.toString());

	
		
		for(int i =0; i<count; i++) {
			String oriName = img[i].getOriginalFilename();
		    String sysName = System.currentTimeMillis() + "_" + oriName;
			System.out.println(oriName + ": " + sysName);
			img[i].transferTo(new File(path + "/" + sysName));
			
			contentList.get(i).setOriName(oriName);
			contentList.get(i).setSysName(sysName);
		}



		//house 테이블 삽입
		int houseResult = houseDAO.insertAll(houseDTO);
		System.out.println("house 결과 : " + houseResult);

		//houseContent 테이블 삽입
		int contentResult = contentDAO.insertAll(contentList);
		System.out.println("houseContent 결과 : " + contentResult);
		if(houseResult >0 && contentResult > 0) {
			return 1;
		}else {
			return 0;
		}

	}

	public Map<String, Object> detail(int seq) throws Exception{
		//상세보기
		System.out.println("detail");
		System.out.println(seq);
		houseDAO.updateViewCount(seq); //조회수 증가
		HouseDTO houseDTO = houseDAO.selectBySeq(seq); //제목, 작성자, 조회수
		List<HouseContentDTO> contentList = contentDAO.selctBySeq(seq); //이미지관련 
		List<HouseCommentDTO> commentList = commentDAO.selectBySeq(seq); //댓글
		Map<String, Object> map = new HashMap<>();
		map.put("houseDTO", houseDTO);
		map.put("contentList", contentList);
		map.put("commentList", commentList);
		
		return map;
	}
	
	
	public Map<String, Object> commentWrite(HouseCommentDTO dto) throws Exception {
		//댓글작성
		Map<String,Object> map = new HashMap<>();
		map.put("insertResult", commentDAO.insertBySeq(dto));
		map.put("commentList", commentDAO.selectBySeq(dto.getHouseSeq()));
		return map;
	}
	
	public int commentDel(int seq, String id) throws Exception {
		//댓글 삭제
		String wirter = commentDAO.selectBySeqOne(seq).getWriter();
		if(id.equals(wirter)) {
			return commentDAO.deleteBySeq(seq);
		}else {
			return -1;
		}

	}


	public Map<String, Object> updateView(int seq) throws Exception{
		//상세보기
		System.out.println("detail");
		System.out.println(seq);
		houseDAO.updateViewCount(seq); //조회수 증가
		HouseDTO houseDTO = houseDAO.selectBySeq(seq); //제목, 작성자, 조회수
		List<HouseContentDTO> contentList = contentDAO.selctBySeq(seq); //이미지관련 
		Map<String, Object> map = new HashMap<>();
		map.put("houseDTO", houseDTO);
		map.put("contentList", contentList);
		return map;
	}
	
	
	public int updateBySeq(HouseDTO houseDTO, List<HouseContentDTO> contentList,MultipartFile[] img, String stat) throws Exception {
		if(stat != null && stat.length() != 0) {
			//원본 삭제
			String[] statArr = stat.split(",");
			for(int i =0; i<statArr.length; i++) {
				contentDAO.deleteByContentSeq(Integer.parseInt(statArr[i]));
			}
		}
		

		String path = session.getServletContext().getRealPath("files");

		File filePath = new File(path);
		if(!filePath.exists()) {
			filePath.mkdir();
		}
		int count = contentList.size();
		System.out.println(contentList.toString());

	
		
		for(int i =0; i<count; i++) {
			String oriName = img[i].getOriginalFilename();
		    String sysName = System.currentTimeMillis() + "_" + oriName;
			System.out.println(oriName + ": " + sysName);
			img[i].transferTo(new File(path + "/" + sysName));
			
			contentList.get(i).setOriName(oriName);
			contentList.get(i).setSysName(sysName);
		}



		//house 테이블 삽입
		/*
		 * int houseResult = houseDAO.insertAll(houseDTO);
		 * System.out.println("house 결과 : " + houseResult);
		 */

		//houseContent 테이블 삽입
		 int contentResult = contentDAO.insertAll(contentList);
		System.out.println("houseContent 결과 : " + contentResult);
		return contentResult;
		
	}
	
	public boolean deleteBySeq(String writer, int seq) {
		int isWriter = houseDAO.isWriter(writer, seq);
		if(isWriter >0) {
			houseDAO.deleteBySeq(seq);
			contentDAO.deleteBySeq(seq);
			return true;
		}else {
			return false;
		}
	}
}
