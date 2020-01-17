package recoder.single.bangle.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.movie.DAO.MovieDAO;
import recoder.single.bangle.movie.DTO.MovieDTO;

@Service
public class MovieService {
	@Autowired
	private MovieDAO dao;
	
	public int insertMovieOld(MovieDTO dto)throws Exception{
		return dao.insertAll(dto);
	}
	
	public int insertMovie(List list) throws Exception{
		return dao.movieInsertAll(list);
	}
	
	public int deleteMovie() throws Exception {
		return dao.deleteAll();
	}
	
	
	
	public List<MovieDTO> viewMovie() throws Exception{
		return dao.selectAll();
	}
	
}
