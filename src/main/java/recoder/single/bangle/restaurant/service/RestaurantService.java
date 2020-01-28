package recoder.single.bangle.restaurant.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import recoder.single.bangle.restaurant.DAO.RestaurantDAO;
import recoder.single.bangle.restaurant.DAO.RestaurantFileDAO;
import recoder.single.bangle.restaurant.DTO.RestaurantDTO;
import recoder.single.bangle.restaurant.DTO.RestaurantFileDTO;
import utils.XSSprotect;

@Service
public class RestaurantService {

	@Autowired
	private RestaurantDAO rstDao;

	@Autowired
	private RestaurantFileDAO rstFileDao;



	public List<RestaurantDTO> rstListN() throws Exception {
		List<RestaurantDTO> list = rstDao.selectN();
		return list;
	} 

	public List<RestaurantDTO> rstListY() throws Exception {
		List<RestaurantDTO> list = rstDao.selectY();
		return list;
	}

	@Transactional("tx")
	public int rstWrite(RestaurantDTO dto, String uploadPath) throws Exception {
		File filePath = new File(uploadPath);
		if(!filePath.exists()) {
			filePath.mkdir();
		}

		String title = dto.getTitle();
		dto.setTitle(XSSprotect.replaceParameter(title));

		int insertResult = rstDao.insert(dto);
		int seq = rstDao.getMaxSeq(dto.getWriter());
		System.out.println("작성된 혼밥/혼술 글 번호 : " + seq);

		if(dto.getFiles()[0].getOriginalFilename() != "") {
			int fileNum = dto.getFiles().length;
			for(int i = 0; i < fileNum; i++) {
				String oriName = dto.getFiles()[i].getOriginalFilename();
				String sysName = System.currentTimeMillis() + "_" + oriName;

				dto.getFiles()[i].transferTo(new File(uploadPath + "/" + sysName));
				rstFileDao.insert(new RestaurantFileDTO(0, seq, oriName, sysName, dto.getContents()[i]));
			}
			System.out.println("혼밥/혼술 파일 업로드 성공!");
		}

		return insertResult;
	}
	
	public RestaurantDTO rstDetail(int seq) throws Exception {
		RestaurantDTO dto = rstDao.selectBySeq(seq);
		return dto;
	}

	public List<RestaurantFileDTO> fileList(int rootSeq) throws Exception {
		List<RestaurantFileDTO> list = null;

		int fileCheck = rstFileDao.isFileExist(rootSeq);
		if(fileCheck > 0) {
			list = rstFileDao.getFilesByPost(rootSeq);
		}
		return list;
	}

	public RestaurantDTO getModifyForm(int seq) throws Exception {
		RestaurantDTO dto = rstDao.selectBySeq(seq);
		return dto;
	}

	public int rstModify(RestaurantDTO dto, String uploadPath) throws Exception {
		File filePath = new File(uploadPath);
		if(!filePath.exists()) {
			filePath.mkdir();
		}
		
		String title = dto.getTitle();
		dto.setTitle(XSSprotect.replaceParameter(title));

		int	updateResult = rstDao.update(dto);
		int seq = dto.getSeq();
		rstFileDao.delete(seq);
		System.out.println("수정된 혼밥/혼술 글 번호 : " + seq);

		if(dto.getFiles()[0].getOriginalFilename() != "") {
			int fileNum = dto.getFiles().length;
			for(int i = 0; i < fileNum; i++) {
				String oriName = dto.getFiles()[i].getOriginalFilename();
				String sysName = System.currentTimeMillis() + "_" + oriName;

				dto.getFiles()[i].transferTo(new File(uploadPath + "/" + sysName));
				rstFileDao.insert(new RestaurantFileDTO(0, seq, oriName, sysName, dto.getContents()[i]));
			}
			System.out.println("혼밥/혼술 파일 수정 성공!");
		}

		return updateResult;
	}
	
	public int rstApproval(int seq) throws Exception {
		int approvalResult = rstDao.approval(seq);
		return approvalResult;
	}

	public int rstDelete(int seq) throws Exception {
		int	rstDeleteResult = rstDao.delete(seq);
		int	fileDeleteResult = rstFileDao.delete(seq);

		int deleteResult = 0;
		if(rstDeleteResult > 0 && fileDeleteResult > 0) {
			deleteResult = 1;
		}
		return deleteResult;
	}
}
