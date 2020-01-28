package recoder.single.bangle.house.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.house.DTO.HouseCommentDTO;



@Service
public class HouseCommentDAO {
	@Autowired
	private SqlSessionTemplate jdbc;

	public List<HouseCommentDTO> selectBySeq(int seq) {
		return jdbc.selectList("houseComment.selectBySeq", seq);
	}
	
	public int insertBySeq(HouseCommentDTO dto) {
		return jdbc.insert("houseComment.insertBySeq", dto);
	}

	public HouseCommentDTO selectBySeqOne(int seq) {
		return jdbc.selectOne("selectBySeqOne", seq);
	}
	
	public int deleteBySeq(int seq) {
		return jdbc.delete("houseComment.deleteBySeq", seq);
	}

	
	
}
