package recoder.single.bangle.tipBoard.DAO;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.tipBoard.DTO.FileDTO;

@Repository
public class FileDAO {

	@Autowired
	private SqlSessionTemplate sst;
	
	public int insertFile(FileDTO dto) {
		return sst.insert("File.insert",dto);
	}
	
//	public String selectPic(int rootSeq) {
//		return sst.selectOne("File.selectPic",rootSeq);
//	}
	
}
