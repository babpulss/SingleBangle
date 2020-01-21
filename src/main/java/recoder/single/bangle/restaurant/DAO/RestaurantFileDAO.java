package recoder.single.bangle.restaurant.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import recoder.single.bangle.restaurant.DTO.RestaurantFileDTO;

@Repository
public class RestaurantFileDAO {

	@Autowired
	private SqlSessionTemplate sst;
	
	
	
	public int insert(RestaurantFileDTO dto) throws Exception {
		return sst.insert("RestaurantFile.insert", dto);
	}
	
	public int isFileExist(int rootSeq) throws Exception {
		return sst.selectOne("RestaurantFile.isFileExist", rootSeq);
	}
	
	public List<RestaurantFileDTO> getFilesByPost(int rootSeq) throws Exception {
		return sst.selectList("RestaurantFile.getFilesByPost", rootSeq);
	}
	
	public int delete(int rootSeq) throws Exception {
		return sst.delete("RestaurantFile.delete", rootSeq);
	}
}
