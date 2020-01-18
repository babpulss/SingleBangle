package recoder.single.bangle.movie.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.movie.DTO.MovieDTO;

@Service
public class MovieDAO {
	@Autowired
	private SqlSessionTemplate jdbc;
	
	public int insertAll(MovieDTO dto) throws Exception{
		return jdbc.insert("movie.insertAll", dto); 
	}
	
	public int movieInsertAll(List<MovieDTO> list) throws Exception{
//		for (Object object : list) {
//			System.out.println(">> " +object.toString());
//		}
		return jdbc.insert("movie.MovieinsertAll", list); 
	}
	
	public List<MovieDTO> selectAll() throws Exception {
		return jdbc.selectList("movie.selectAll");
	}
	
	public int deleteAll() throws Exception{
		return jdbc.delete("movie.deleteAll");
	}
}
