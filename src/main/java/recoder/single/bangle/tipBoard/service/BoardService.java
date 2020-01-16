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
import org.springframework.util.Base64Utils;

import recoder.single.bangle.tipBoard.DAO.BoardDAO;
import recoder.single.bangle.tipBoard.DAO.FileDAO;
import recoder.single.bangle.tipBoard.DTO.BoardDTO;
import recoder.single.bangle.tipBoard.DTO.FileDTO;
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

	public List<BoardDTO> boardList(){
		List<BoardDTO> list = null;
		try {
			list = boardDao.boardList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

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

	public int updateTip(BoardDTO dtoB) {
		int updateResult = 0;
		try {
			updateResult = boardDao.updateTip(dtoB);
			System.out.println("서비스에서의 updateResult: "+updateResult);
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
}
