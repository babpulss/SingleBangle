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

@Service
public class RestaurantService {

	@Autowired
	private RestaurantDAO rstDao;

	@Autowired
	private RestaurantFileDAO rstFileDao;



	public List<RestaurantDTO> rstListN() {
		List<RestaurantDTO> list = null;
		try {
			list = rstDao.selectN();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	} 
	
	public List<RestaurantDTO> rstListY() {
		List<RestaurantDTO> list = null;
		try {
			list = rstDao.selectY();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Transactional("tx")
	public int rstWrite(RestaurantDTO dto, String uploadPath) {
		File filePath = new File(uploadPath);
		if(!filePath.exists()) {
			filePath.mkdir();
		}

		int insertResult = 0;
		try {
			insertResult = rstDao.insert(dto);
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
		} catch (Exception e) {
			e.printStackTrace();
			insertResult = 0;
		}

		return insertResult;
	}

	@Transactional("tx")
	public RestaurantDTO rstDetail(int seq) {
		RestaurantDTO dto = null;
		try {
			dto = rstDao.selectBySeq(seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	public List<RestaurantFileDTO> fileList(int rootSeq) {
		int fileCheck = 0;
		List<RestaurantFileDTO> list = null;

		try {
			fileCheck = rstFileDao.isFileExist(rootSeq);
			if(fileCheck > 0) {
				list = rstFileDao.getFilesByPost(rootSeq);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public RestaurantDTO getModifyForm(int seq) {
		RestaurantDTO dto = null;
		try {
			dto = rstDao.selectBySeq(seq);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	public int rstModify(RestaurantDTO dto, String uploadPath) {
		File filePath = new File(uploadPath);
		if(!filePath.exists()) {
			filePath.mkdir();
		}
		
		int rstUpdateResult = 0;
		int fileDeleteResult = 0;
		int updateResult = 0;
		try {
			rstUpdateResult = rstDao.update(dto);
			int seq = dto.getSeq();
			fileDeleteResult = rstFileDao.delete(seq);
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
			updateResult = 1;
		} catch (Exception e) {
			e.printStackTrace();
			updateResult = 0;
		}
		return updateResult;
	}

	public int rstDelete(int seq) {
		int rstDeleteResult = 0;
		int fileDeleteResult = 0;
		int deleteResult = 0;
		try {
			rstDeleteResult = rstDao.delete(seq);
			fileDeleteResult = rstFileDao.delete(seq);
			deleteResult = 1;
		} catch (Exception e) {
			e.printStackTrace();
			deleteResult = 0;
		}
		return deleteResult = 0;
	}
}
