package recoder.single.bangle.notice;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private SqlSessionTemplate sst;
	
	@RequestMapping("")
	public String toNotice(Model m) {
		List<NoticeDTO> list = sst.selectList("Notice.getNotices");
		m.addAttribute("list", list);
		return "notice/notice";
	}
	
	@RequestMapping("/writeNotice")
	public String writeNotice() {
		return "notice/postNotice";
	}

	@RequestMapping("/readNotice")
	public String readNotice(int seq, Model m) {
		NoticeDTO dto = sst.selectOne("Notice.readNotice", seq);
		m.addAttribute("dto", dto);
		return "notice/detailNoticeView";
	}

	@RequestMapping("/postNotice")
	public String postNotice(NoticeDTO dto, Model m) {
		int result = sst.insert("Notice.postNotice", dto);
		m.addAttribute("result", result);
		return "notice/resultAlert";
	}

	@RequestMapping("/updateNotice")
	public String updateNotice(NoticeDTO dto, Model m) {
		int result = sst.update("Notice.updateNotice", dto);
		m.addAttribute("result", result);
		return "notice/resultAlert";
	}
	
	@RequestMapping("/deleteNotice")
	public String deleteNotice(NoticeDTO dto, Model m) {
		int result = sst.delete("Notice.deleteNotice", dto);
		m.addAttribute("result", result);
		return "notice/resultAlert";
	}
}
