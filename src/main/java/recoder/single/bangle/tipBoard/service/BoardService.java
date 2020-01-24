package recoder.single.bangle.tipBoard.service;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.Base64Utils;

import configuration.Configuration;
import recoder.single.bangle.tipBoard.DAO.BoardDAO;
import recoder.single.bangle.tipBoard.DAO.FileDAO;
import recoder.single.bangle.tipBoard.DTO.BoardDTO;
import recoder.single.bangle.tipBoard.DTO.CommentDTO;
import recoder.single.bangle.tipBoard.DTO.FileDTO;
import recoder.single.bangle.tipBoard.DTO.ReportDTO;
import recoder.single.bangle.tipBoard.DTO.ScrapDTO;

@Service
public class BoardService {

	@Autowired
	private BoardDAO boardDao;

	@Autowired
	private FileDAO fileDao;

	@Autowired
	private HttpSession session;

	//summernote로 작성한 글과 사진을 db에 저장하기 위한 작업!
	//글과 사진을 board table에 넣고, 사진은 file table에 한번 더 저장!
	
	@Transactional("tx")
	public int tipBoardWrite(String realPath, BoardDTO dtoB, FileDTO dtoF) {
		//추후 리턴할 결과
		int writeResult=0;

		//controller로부터 받은 realPath와 dto를 이용! realPath로 File형 file_path를 만듦! realPath에 해당하는 폴더 인스턴스 생성!
		File file_path = new File(realPath);
		// 근데 이 폴더가 없으면 만들어라!
		if(!file_path.exists()) {
			file_path.mkdir();
		}
		//정규식 만들기
		Pattern p = Pattern.compile("<img.+?src=\"(.+?)\".+?data-filename=\"(.+?)\".*?>");

		//dto에서 contents 내용 뽑아서 string에 넣기! 엄청 길다!
		String contents = dtoB.getContents();
		//		System.out.println("contents: "+contents);

		//정규식과 contents의 내용을 매칭!
		Matcher m = p.matcher(contents);

		String oriName = null;
		String sysName = null;
		List<String> oriNameList = new ArrayList<>();
		List<String> sysNameList = new ArrayList<>();
		
		try {	
			//매칭된 내용을 뽑아내는 과정! (파일 업로드)
			while(m.find()) {
				oriName = m.group(2);
				sysName = System.currentTimeMillis()+"_"+oriName;
				oriNameList.add(oriName);
				sysNameList.add(sysName);			
				
				String imgString = m.group(1).split(",")[1];
				System.out.println("파일 이름: "+oriName);
				System.out.println("이미지 데이터 값: "+imgString);
				System.out.println("-----------------------");

				//파일은 byte[] 
				byte[] imgBytes = Base64Utils.decodeFromString(imgString);
				FileOutputStream fos = new FileOutputStream(realPath+"/"+sysName);
				DataOutputStream dos = new DataOutputStream(fos);
				dos.write(imgBytes);
				dos.flush();
				dos.close();

				contents = contents.replaceFirst(Pattern.quote(m.group(1)), "/files/"+sysName);
				dtoB.setContents(contents);
				System.out.println("새로운 contents 이름: " + contents);
			}

			//게시글 입력!
			int resultB = boardDao.write(dtoB);			 
			if(resultB>0) {
				System.out.println("게시글 입력 성공!");
			}

			//파일 입력! - fileDao의 method를 실행하는데, dto의 값을 넣어주기! => 까먹지 말기!
			//근데 rootSeq를 가져오려면, getMaxSeq() 만들어야 함!!!! => 까먹지 말기!
			//일단 게시글을 입력하고 바로 파일을 입력하니까, seq가 가장 큰 게시글의 seq값을 가져와서 그걸 rootSeq로 사용!
			String writer = dtoB.getWriter();
			int rootSeq = boardDao.getMaxSeq(writer);
			
			System.out.println("등록된 파일 개수 : " + oriNameList.size());
			for(int i = 0; i < oriNameList.size(); i++) {				
				int resultF = fileDao.insertFile(new FileDTO(0,rootSeq,sysNameList.get(i),oriNameList.get(i)));
				
				if(resultF>0) {
					System.out.println("파일 입력 성공!");
				}		
			}

			writeResult = resultB;

		}catch(Exception e) {
			e.printStackTrace();
		}
		return writeResult;
	}

//	public List<BoardDTO> boardList(){
//		List<BoardDTO> list = null;
//		try {
//			list = boardDao.boardList();
//			System.out.println("보드list: "+list);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return list;
//	}

	public BoardDTO getDto(int seq) {
		BoardDTO dto = null;
		try {
			dto = boardDao.getDto(seq);
			System.out.println("getDto 수행한 결과 값: "+dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Transactional("tx")
	public int updateTip(String realPath, BoardDTO dtoB, FileDTO dtoF) {
		int updateResult = 0;
		try {

			//controller로부터 받은 realPath와 dto를 이용! realPath로 File형 file_path를 만듦! realPath에 해당하는 폴더 인스턴스 생성!
			File file_path = new File(realPath);
			// 근데 이 폴더가 없으면 만들어라!
			if(!file_path.exists()) {
				file_path.mkdir();
			}
			//정규식 만들기
			Pattern p = Pattern.compile("<img.+?src=\"(data:.+?base64,)(.+?)\".+?data-filename=\\\"(.+?)\\\".*?>");

			//dto에서 contents 내용 뽑아서 string에 넣기! 엄청 길다!
			String contents = dtoB.getContents();
			//		System.out.println("contents: "+contents);

			//정규식과 contents의 내용을 매칭!
			Matcher m = p.matcher(contents);

			String oriName = null;
			String sysName = null;
			List<String> oriNameList = new ArrayList<>();
			List<String> sysNameList = new ArrayList<>();
			
			try {	
				//매칭된 내용을 뽑아내는 과정! (파일 업로드)
				while(m.find()) {
					oriName = m.group(3);
					System.out.println("oriName: "+oriName);
					
					sysName = System.currentTimeMillis()+"_"+oriName;
					System.out.println("sysName: "+sysName);
					oriNameList.add(oriName);
					sysNameList.add(sysName);			
					
					String imgString = m.group(2);
					System.out.println("파일 이름: "+oriName);
					System.out.println("이미지 데이터 값: "+imgString);
					System.out.println("-----------------------");

					//파일은 byte[] 
					byte[] imgBytes = Base64Utils.decodeFromString(imgString);
					FileOutputStream fos = new FileOutputStream(realPath+"/"+sysName);
					DataOutputStream dos = new DataOutputStream(fos);
					dos.write(imgBytes);
					dos.flush();
					dos.close();
					
					contents = contents.replaceFirst(Pattern.quote(m.group(1)), "");
					contents = contents.replaceFirst(Pattern.quote(m.group(2)), "/files/"+sysName);
					dtoB.setContents(contents);
					System.out.println("새로운 contents 이름: " + contents);
				}

				//게시글 입력!
				int resultB = boardDao.updateTip(dtoB);			 
				if(resultB>0) {
					System.out.println("게시글 수정 성공!");
				}

				//파일 입력! - fileDao의 method를 실행하는데, dto의 값을 넣어주기! => 까먹지 말기!
				//근데 rootSeq를 가져오려면, getMaxSeq() 만들어야 함!!!! => 까먹지 말기!
				//일단 게시글을 입력하고 바로 파일을 입력하니까, seq가 가장 큰 게시글의 seq값을 가져와서 그걸 rootSeq로 사용!
				String writer = dtoB.getWriter();
				int rootSeq = boardDao.getMaxSeq(writer);
				
				System.out.println("등록된 파일 개수 : " + oriNameList.size());
				for(int i = 0; i < oriNameList.size(); i++) {				
					int resultF = fileDao.insertFile(new FileDTO(0,rootSeq,sysNameList.get(i),oriNameList.get(i)));
			
					if(resultF>0) {
						System.out.println("파일 수정 성공!");
					}		
				}

				updateResult = resultB;

			}catch(Exception e) {
				e.printStackTrace();
			}
			return updateResult;
//			
//			updateResult = boardDao.updateTip(dtoB);
//			System.out.println("서비스에서의 updateResult: "+updateResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return updateResult;
	}

	public int likeCheck(int seq, String id) {
		int likeCheckResult = 0;
		try {
			likeCheckResult = boardDao.likeCheck(seq, id);
			System.out.println("좋아요 눌렀었나? : " + likeCheckResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return likeCheckResult;
	}

	@Transactional("tx")
	public int likeInsert(int seq, String id) {
		int likeInsertResult = 0;
		try {
			likeInsertResult = boardDao.likeInsert(seq, id);
			boardDao.likePlus(seq);
			System.out.println("like가 insert 되었니? : " + likeInsertResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return likeInsertResult;
	}

	@Transactional("tx")
	public int likeDelete(int seq, String id) {
		int likeDeleteResult = 0;
		try {
			likeDeleteResult = boardDao.likeDelete(seq, id);
			boardDao.likeMinus(seq);
			System.out.println("like가 delete 되었니? : " + likeDeleteResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return likeDeleteResult;
	}

	public int likeCount(int seq) {
		int likeCountResult = 0;
		try {
			likeCountResult = boardDao.likeCount(seq);
			System.out.println("like 수는? : "+likeCountResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return likeCountResult;
	}

	public int viewCount(int seq) {
		int viewCount = 0;
		try {
			viewCount = boardDao.viewCount(seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return viewCount;
	}
	
	public int scrap(ScrapDTO dtoS) {
		int scrap = 0;
		try {
			scrap = boardDao.scrap(dtoS);
			boardDao.scrapPlus(dtoS.getRootSeq());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return scrap;
	}
	
	public int deleteScrap(int seq) {
		int delScrapResult = boardDao.deleteScrap(seq);
		return delScrapResult;
	}
	
	public int scrapCheck(int seq, String id) {
		int scrapCheck = 0;
		try {
			scrapCheck = boardDao.scrapCheck(seq, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return scrapCheck;
	}
	
	public int scrapCount(int seq) {
		int scrapCount = 0;
		try {
			 scrapCount = boardDao.scrapCount(seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return scrapCount;
	}
	
	public List<ScrapDTO> myScrap(String id){
		List<ScrapDTO> myScrapList = new ArrayList<>();
		try {
			myScrapList = boardDao.myScrap(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return myScrapList;
	}
		
	public String getNavi(int currentPage) {
										// currentPage = 현재 페이지 번호
		int recordTotalCount = 0;	 // recordTotalCount : 전체 게시물 개수
		try {
			recordTotalCount = boardDao.tipCount();	
		} catch (Exception e) {
			e.printStackTrace();
		}

		// Configuration.recordCountPerPage: 한 페이지에서 몇개의 네비게이터를 보여줄 것인 지 설정 / 현재 내가 4에 있으면 네비게이터에서는 1부터 10까지 볼 수 있음
		int pageTotalCount = 0;//총 몇개의 페이지인지

		if(recordTotalCount % Configuration.recordCountPerPage > 0) { // recordTotalCount를 recordCountPerPage로 나누었을때 나머지가 0보다 크다면(즉, 나머지가 생긴다면)
			pageTotalCount = recordTotalCount/Configuration.recordCountPerPage +1;
		}else {
			pageTotalCount = recordTotalCount/Configuration.recordCountPerPage;
		}

		if(currentPage <= 1) { //페이지값을 1 이하 숫자로 하는 경우
			currentPage = 1;
		}else if(currentPage > pageTotalCount){ // 마지막 페이지값보다 높은 페이지값을 요청하는 경우
			currentPage = pageTotalCount;
		}

		int startNavi = ((currentPage-1) / Configuration.recordCountPerPage) * Configuration.recordCountPerPage + 1; //현재 페이지 위치에서 볼 수 있는 네비게이터의 시작 값
		int endNavi = startNavi + Configuration.recordCountPerPage - 1; //현재 페이지 위치에서 볼 수 있는 네비게이터의 마지막 값.

		if(endNavi > pageTotalCount) { //페이지 끝 값이 비정상적일때/ 총 15페이지가 있을때 15페이지를 선택하면 보여지는 네비는 11-20이 아니라 11-15여야함
			endNavi = pageTotalCount;
		}
		boolean needPrev = true; // < 표시가 필요한지
		boolean needNext = true; // > 표시가 필요한지

		if(startNavi == 1) {
			needPrev = false;
		}
		if(endNavi == pageTotalCount) {
			needNext = false;
		}
		
		StringBuilder sb = new StringBuilder(); // += 연산자 대신 사용(가독성을 위해)

		if(needPrev) {
			sb.append("<a class='pageNavi' href='boardList.bo?currentPage="+(startNavi - 1)+"'> < </a>");
		}
		for(int i = startNavi; i <= endNavi; i++) {
			sb.append("<a class='pageNavi' href='boardList.bo?currentPage="+i+"'>"); //cpage = currentpage
			sb.append(i + " ");
			sb.append("</a>");
		}
		if(needNext) {
			sb.append("<a class='pageNavi' href='boardList.bo?currentPage="+(endNavi + 1) +"' > > </a>");
		}
		return sb.toString();
	}

	public String getSearchNaviTitle(int currentPage, String searchInput, String tipCategory) { 
		// currentPage = 현재 페이지 번호
		int recordTotalCount = 0; // recordTotalCount : 전체 게시물 개수
		try {
			recordTotalCount = boardDao.searchTitleCount(searchInput);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// Configuration.recordCountPerPage: 한 페이지에서 몇개의 네비게이터를 보여줄 것인 지 설정 / 현재 내가 4에 있으면 네비게이터에서는 1부터 10까지 볼 수 있음
		int pageTotalCount = 0;// 총 몇개의 페이지인지

		if (recordTotalCount % Configuration.recordCountPerPage > 0) { // recordTotalCount를 recordCountPerPage로 나누었을때
																		// 나머지가 0보다 크다면(즉, 나머지가 생긴다면)
			pageTotalCount = recordTotalCount / Configuration.recordCountPerPage + 1;
		} else {
			pageTotalCount = recordTotalCount / Configuration.recordCountPerPage;
		}

		if (currentPage <= 1) { // 페이지값을 1 이하 숫자로 하는 경우
			currentPage = 1;
		} else if (currentPage > pageTotalCount) { // 마지막 페이지값보다 높은 페이지값을 요청하는 경우
			currentPage = pageTotalCount;
		}

		int startNavi = ((currentPage - 1) / Configuration.recordCountPerPage) * Configuration.recordCountPerPage + 1; // 현재 페이지 위치에서 볼 수 있는 네비게이터의 시작 값
		int endNavi = startNavi + Configuration.recordCountPerPage - 1; // 현재 페이지 위치에서 볼 수 있는 네비게이터의 마지막 값.

		if (endNavi > pageTotalCount) { // 페이지 끝 값이 비정상적일때/ 총 15페이지가 있을때 15페이지를 선택하면 보여지는 네비는 11-20이 아니라 11-15여야함
			endNavi = pageTotalCount;
		}
		boolean needPrev = true; // < 표시가 필요한지
		boolean needNext = true; // > 표시가 필요한지

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}

		StringBuilder sb = new StringBuilder(); // += 연산자 대신 사용(가독성을 위해)

		if (needPrev) {
			sb.append("<a class='pageNavi' href='tipSearch.bo?tipCategory="+tipCategory+"&searchInput="+searchInput+"&currentPage=" + (startNavi - 1) + "'> < </a>");
		}
		for (int i = startNavi; i <= endNavi; i++) {
			sb.append("<a class='pageNavi' href='tipSearch.bo?tipCategory="+tipCategory+"&searchInput="+searchInput+"&currentPage=" + i + "'>"); // cpage = currentpage
			sb.append(i + " ");
			sb.append("</a>");
		}
		if (needNext) {
			sb.append("<a class='pageNavi' href='tipSearch.bo?tipCategory="+tipCategory+"&searchInput="+searchInput+"&currentPage=" + (endNavi + 1) + "' > > </a>");
		}
		return sb.toString();
	}
	
	public String getSearchNaviContents(int currentPage, String searchInput, String tipCategory) { 
		// currentPage = 현재 페이지 번호
		int recordTotalCount = 0; // recordTotalCount : 전체 게시물 개수
		try {
			List<BoardDTO> tmp = boardDao.searchContents(searchInput);
			recordTotalCount = tmp.size();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//Configuration.naviCountPerPage:  한 페이지에서 몇개의 네비게이터를 보여줄 것인 지 설정 / 현재 내가 4에 있으면 네비게이터에서는 1부터 10까지 볼 수 있음
		int pageTotalCount = 0;// 총 몇개의 페이지인지

		if (recordTotalCount % Configuration.recordCountPerPage > 0) { // recordTotalCount를 recordCountPerPage로 나누었을때
																		// 나머지가 0보다 크다면(즉, 나머지가 생긴다면)
			pageTotalCount = recordTotalCount / Configuration.recordCountPerPage + 1;
		} else {
			pageTotalCount = recordTotalCount / Configuration.recordCountPerPage;
		}

		if (currentPage <= 1) { // 페이지값을 1 이하 숫자로 하는 경우
			currentPage = 1;
		} else if (currentPage > pageTotalCount) { // 마지막 페이지값보다 높은 페이지값을 요청하는 경우
			currentPage = pageTotalCount;
		}

		int startNavi = ((currentPage - 1) / Configuration.naviCountPerPage) * Configuration.naviCountPerPage + 1; // 현재 페이지 위치에서 볼 수 있는 네비게이터의 시작 값
		int endNavi = startNavi + Configuration.naviCountPerPage - 1; // 현재 페이지 위치에서 볼 수 있는 네비게이터의 마지막 값.

		if (endNavi > pageTotalCount) { // 페이지 끝 값이 비정상적일때/ 총 15페이지가 있을때 15페이지를 선택하면 보여지는 네비는 11-20이 아니라 11-15여야함
			endNavi = pageTotalCount;
		}
		boolean needPrev = true; // < 표시가 필요한지
		boolean needNext = true; // > 표시가 필요한지

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}

		StringBuilder sb = new StringBuilder(); // += 연산자 대신 사용(가독성을 위해)

		if (needPrev) {
			sb.append("<a class='pageNavi' href='tipSearch.bo?tipCategory="+tipCategory+"&searchInput="+searchInput+"&currentPage=" + (startNavi - 1) + "'> < </a>");
		}
		for (int i = startNavi; i <= endNavi; i++) {
			sb.append("<a class='pageNavi' href='tipSearch.bo?tipCategory="+tipCategory+"&searchInput="+searchInput+"&currentPage=" + i + "'>"); // cpage = currentpage
			sb.append(i + " ");
			sb.append("</a>");
		}
		if (needNext) {
			sb.append("<a class='pageNavi' href='tipSearch.bo?tipCategory="+tipCategory+"&searchInput="+searchInput+"&currentPage=" + (endNavi + 1) + "' > > </a>");
		}
		return sb.toString();
	}
	
	public String getSearchNaviBoth(int currentPage, String searchInput, String tipCategory) { 
		// currentPage = 현재 페이지 번호
		int recordTotalCount = 0; // recordTotalCount : 전체 게시물 개수
		try {
			List<BoardDTO> tmp = boardDao.searchBoth(searchInput);
			recordTotalCount = tmp.size();
		} catch (Exception e) {
			e.printStackTrace();
		}

		int pageTotalCount = 0;// 총 몇개의 페이지인지

		if (recordTotalCount % Configuration.recordCountPerPage > 0) { // recordTotalCount를 recordCountPerPage로 나누었을때
																		// 나머지가 0보다 크다면(즉, 나머지가 생긴다면)
			pageTotalCount = recordTotalCount / Configuration.recordCountPerPage + 1;
		} else {
			pageTotalCount = recordTotalCount / Configuration.recordCountPerPage;
		}

		if (currentPage <= 1) { // 페이지값을 1 이하 숫자로 하는 경우
			currentPage = 1;
		} else if (currentPage > pageTotalCount) { // 마지막 페이지값보다 높은 페이지값을 요청하는 경우
			currentPage = pageTotalCount;
		}

		int startNavi = ((currentPage - 1) / Configuration.naviCountPerPage) * Configuration.naviCountPerPage + 1; // 현재 페이지 위치에서 볼 수 있는 네비게이터의 시작 값
		int endNavi = startNavi + Configuration.naviCountPerPage - 1; // 현재 페이지 위치에서 볼 수 있는 네비게이터의 마지막 값.

		if (endNavi > pageTotalCount) { // 페이지 끝 값이 비정상적일때/ 총 15페이지가 있을때 15페이지를 선택하면 보여지는 네비는 11-20이 아니라 11-15여야함
			endNavi = pageTotalCount;
		}
		boolean needPrev = true; // < 표시가 필요한지
		boolean needNext = true; // > 표시가 필요한지

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}

		StringBuilder sb = new StringBuilder(); // += 연산자 대신 사용(가독성을 위해)

		if (needPrev) {
			sb.append("<a class='pageNavi' href='tipSearch.bo?tipCategory="+tipCategory+"&searchInput="+searchInput+"&currentPage=" + (startNavi - 1) + "'> < </a>");
		}
		for (int i = startNavi; i <= endNavi; i++) {
			sb.append("<a class='pageNavi' href='tipSearch.bo?tipCategory="+tipCategory+"&searchInput="+searchInput+"&currentPage=" + i + "'>"); // cpage = currentpage
			sb.append(i + " ");
			sb.append("</a>");
		}
		if (needNext) {
			sb.append("<a class='pageNavi' href='tipSearch.bo?tipCategory="+tipCategory+"&searchInput="+searchInput+"&currentPage=" + (endNavi + 1) + "' > > </a>");
		}
		return sb.toString();
	}
	
	public String getCmtNavi(int currentPage, int seq) { 
		// 위의 seq는 rootSeq(게시글 번호)
		// currentPage = 현재 페이지 번호

		int recordTotalCount = boardDao.cmtCount(seq);   	// recordTotalCount : 해당 게시글의 전체 댓글 개수
		
		int pageTotalCount = 0;// 총 몇개의 페이지인지

		if (recordTotalCount % Configuration.recordCountPerPage > 0) { // recordTotalCount를 recordCountPerPage로 나누었을때
																		// 나머지가 0보다 크다면(즉, 나머지가 생긴다면)
			pageTotalCount = recordTotalCount / Configuration.recordCountPerPage + 1;
		} else {
			pageTotalCount = recordTotalCount / Configuration.recordCountPerPage;
		}

		if (currentPage <= 1) { // 페이지값을 1 이하 숫자로 하는 경우
			currentPage = 1;
		} else if (currentPage > pageTotalCount) { // 마지막 페이지값보다 높은 페이지값을 요청하는 경우
			currentPage = pageTotalCount;
		}

		int startNavi = ((currentPage - 1) / Configuration.naviCountPerPage) * Configuration.naviCountPerPage + 1; // 현재 페이지 위치에서 볼 수 있는 네비게이터의 시작 값
		int endNavi = startNavi + Configuration.naviCountPerPage - 1; // 현재 페이지 위치에서 볼 수 있는 네비게이터의 마지막 값.

		if (endNavi > pageTotalCount) { // 페이지 끝 값이 비정상적일때/ 총 15페이지가 있을때 15페이지를 선택하면 보여지는 네비는 11-20이 아니라 11-15여야함
			endNavi = pageTotalCount;
		}
		boolean needPrev = true; // < 표시가 필요한지
		boolean needNext = true; // > 표시가 필요한지

		if (startNavi == 1) {
			needPrev = false;
		}
		if (endNavi == pageTotalCount) {
			needNext = false;
		}

		StringBuilder sb = new StringBuilder(); // += 연산자 대신 사용(가독성을 위해)

		if (needPrev) {
			sb.append("<a class='pageNavi' href='detailView.bo?seq=" + seq + "&currentPage=" + (startNavi - 1) + "'> < </a>");
		}
		for (int i = startNavi; i <= endNavi; i++) {
			sb.append("<a class='pageNavi' href='detailView.bo?seq=" + seq + "&currentPage=" + i + "'>"); // cpage = currentpage
			sb.append(i + " ");
			sb.append("</a>");
		}
		if (needNext) {
			sb.append("<a class='pageNavi' href='detailView.bo?seq=" + seq + "&currentPage=" + (endNavi + 1) + "' > > </a>");
		}
		return sb.toString();
	}
	
	public List<CommentDTO> selectByPageCmt(int currentPage, int seq){

		int startNum = currentPage * Configuration.recordCountPerPage - (Configuration.recordCountPerPage - 1); 
		int endNum = Configuration.recordCountPerPage * currentPage;
		
		System.out.println("service에서 start랑 end: " + startNum + ":" + endNum);
		return boardDao.selectByPageCmt(startNum, endNum, seq);	
	}
	
	public List<BoardDTO> selectByPage(int currentPage) {

		int startNum = currentPage * Configuration.recordCountPerPage - (Configuration.recordCountPerPage - 1); 
		int endNum = Configuration.recordCountPerPage * currentPage;
		
		System.out.println("service에서 start랑 end: " + startNum + ":" + endNum);
		List<BoardDTO> selectByPage = boardDao.selectByPage(startNum, endNum);
		return selectByPage;
		}

	public List<BoardDTO> selectByPageTitle(int currentPage, String input){
		
		int startNum = currentPage * Configuration.recordCountPerPage - (Configuration.recordCountPerPage - 1); 
		int endNum = Configuration.recordCountPerPage * currentPage;
		
		System.out.println("service에서 start랑 end: " + startNum + ":" + endNum);
		return boardDao.selectByPageTitle(startNum, endNum, input);
	}	
	
	public List<BoardDTO> selectByPageContents(int currentPage, String input){

		int startNum = currentPage * Configuration.recordCountPerPage - (Configuration.recordCountPerPage - 1); 
		int endNum = Configuration.recordCountPerPage * currentPage;
		
		System.out.println("service에서 start랑 end: " + startNum + ":" + endNum);
		return boardDao.selectByPageContents(startNum, endNum, input);
	}

	public List<BoardDTO> selectByPageBoth(int currentPage, String input){

		int startNum = currentPage * Configuration.recordCountPerPage - (Configuration.recordCountPerPage - 1); 
		int endNum = Configuration.recordCountPerPage * currentPage;
		System.out.println("service에서 start랑 end: " + startNum + ":" + endNum);
		return boardDao.selectByPageContents(startNum, endNum, input);
	}
	
	public int searchTitleCount(String title) {
		int searchTitle = boardDao.searchTitleCount(title);
		return searchTitle;
	}

	public List<BoardDTO> searchContents(String contents) {
		List<BoardDTO> searchContents = boardDao.searchContents(contents);
		return searchContents;
	}

	public List<BoardDTO> searchBoth(String both) {
		List<BoardDTO> searchBoth = boardDao.searchBoth(both);
		return searchBoth;
	}
	
	public int deleteTip(int seq) {
		int deleteResult = 0;
		try {
			deleteResult = boardDao.deleteTip(seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return deleteResult;
	}
	
	public int report(ReportDTO dtoR) {
		int reportResult = boardDao.report(dtoR);
		System.out.println("service에서 신고하기 결과: "+reportResult);
		return reportResult;
	}
	
	public int addComment(CommentDTO dtoC) {
		int cmtResult = boardDao.addComment(dtoC);
		System.out.println("service에서 댓글쓰기 결과: "+cmtResult);
		return cmtResult;
	}
	
	public List<CommentDTO> cmtList(int rootSeq) {
		List<CommentDTO> cmtList = boardDao.cmtList(rootSeq);
		return cmtList;
	}
	
	public int cmtDelete(int seq) {
		int deleteResult = boardDao.cmtDelete(seq);
		return deleteResult;
	}
	
	public int commentDelete(int seq) {
		return boardDao.commentDelete(seq);
	}
	
	public int getRootSeq(int seq) {
		return boardDao.getRootSeq(seq);
	}
	
	public int cmtUpdate(int seq, String contents) {
		return boardDao.cmtUpdate(seq, contents);
	}

}


