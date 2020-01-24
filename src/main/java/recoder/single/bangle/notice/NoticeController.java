package recoder.single.bangle.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private NoticeDAO dao;
	
	@RequestMapping("")
	public String toNotice(Model m) {
		List<NoticeDTO> list = dao.toNotice();
		m.addAttribute("list", list);
		return "notice";
	}

	@RequestMapping("/readNotice")
	public String update(int seq, Model m) {
		NoticeDTO dto = dao.update(seq);
		m.addAttribute("dto", dto);
		return "notice";
	}

	@RequestMapping("/postNotice")
	public String postNotice(NoticeDTO dto) {
		dao.postNotice(dto);
		return "notice";
	}

	@RequestMapping("/updateNotice")
	public String updateNotice(NoticeDTO dto) {
		dao.updateNotice(dto);
		return "notice";
	}
	
	@RequestMapping("/deleteNotice")
	public String deleteNotice(NoticeDTO dto) {
		dao.deleteNotice(dto);
		return "notice";
	}
}
