package recoder.single.bangle.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import recoder.single.bangle.movie.service.MovieService;
import recoder.single.bangle.movie.tool.KakaoAPI;

@Controller
@RequestMapping("/movie")
public class MovieController {
	@Autowired
	private MovieService movieService;
	
	@Autowired 
	private KakaoAPI kakao;
	@RequestMapping("/list")
	public String viewMovie(Model model) {
		try {
			//kakao.deleteMovie();
			//kakao.insertMovie();
			model.addAttribute("list", movieService.viewMovie());
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "movie/movieList";
	}
}
