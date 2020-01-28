package recoder.single.bangle.house.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.house.DTO.HouseContentDTO;



@Service
public class HouseContentDAO {

	@Autowired
	private SqlSessionTemplate jdbc;

	public int insertAll(List<HouseContentDTO> contentList) {
		return jdbc.insert("houseContent.insertAll", contentList);
	}

	public List<HouseContentDTO> selctBySeq(int houseSeq) {		
		//상세 보기
		return jdbc.selectList("houseContent.selectBySeq", houseSeq);
	}
	
	public HouseContentDTO selectByFristImg(int houseSeq) {
		//올린 이미지의 첫번째 이미지만 가져옴 
		return jdbc.selectOne("houseContent.selectByFristImg", houseSeq);
	}

	public int deleteBySeq(int seq) {
		return jdbc.delete("houseContent.deleteBySeq", seq);
	}

	public int deleteByContentSeq(int seq) {
		System.out.println("deleteByContentSeq >"  + seq );
		return jdbc.delete("houseContent.deleteByContentSeq", seq);
	}
	
	
}
