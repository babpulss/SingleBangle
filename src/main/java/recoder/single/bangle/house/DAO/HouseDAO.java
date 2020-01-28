package recoder.single.bangle.house.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.house.DTO.HouseDTO;


@Service
public class HouseDAO {

	@Autowired
	private SqlSessionTemplate jdbc;

	public int selectCount() {
		return jdbc.selectOne("house.selectCount");
	}
	/*
	public List<HouseDTO> selectFirst() {
		return jdbc.selectList("house.selectFirst");
	}*/
	public List<Map<String, Object>> selectFirst() throws Exception {
		List<Map<String, Object>> list = jdbc.selectList("house.selectFirst");
		return list;
	}

	public List<Map<String, Object>> selectAfter(int startPage, int endPage){
		Map<String, Integer> map = new HashMap<>();
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		return jdbc.selectList("house.selectAfter", map);
	}

	public int insertAll(HouseDTO dto) {
		
		return jdbc.insert("house.insertAll", dto);
	}

	public HouseDTO selectBySeq(int seq) {
		return jdbc.selectOne("house.selectBySeq", seq);
	}
	public int updateViewCount(int seq) {
		return jdbc.update("house.updateViewCount", seq);
	}
	
	public int isWriter(String writer, int seq) {
		Map<String, Object> map = new HashMap<>();
		map.put("seq",seq);
		map.put("writer", writer);
		System.out.println(map.get("seq"));
		return jdbc.selectOne("house.isWriter", map);
	}
	
	public int deleteBySeq(int houseseq) {
		return jdbc.delete("house.deleteBySeq", houseseq);
	}

}
