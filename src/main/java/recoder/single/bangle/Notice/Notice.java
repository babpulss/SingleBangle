package recoder.single.bangle.Notice;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/notice")
@Controller
public class Notice {

	@Autowired
	private SqlSessionTemplate sst;
	
	@RequestMapping("")
	public String toNotice(Model m) {
		List<NoticeDTO> list = sst.selectList("Notice.getNotices");
		m.addAttribute("list", list);
		return "notice";
	}

	@RequestMapping("/readNotice")
	public String update(int seq, Model m) {
		NoticeDTO dto = sst.selectOne("Notice.readNotice");
		m.addAttribute("dto", dto);
		return "notice";
	}

	@RequestMapping("/postNotice")
	public String postNotice(NoticeDTO dto) {
		sst.insert("Notice.postNotice", dto);
		return "notice";
	}

	@RequestMapping("/updateNotice")
	public String updateNotice(NoticeDTO dto) {
		sst.update("Notice.updateNotice", dto);
		return "notice";
	}
	
	@RequestMapping("/deleteNotice")
	public String deleteNotice(NoticeDTO dto) {
		sst.delete("Notice.deleteNotice", dto);
		return "notice";
	}
}
