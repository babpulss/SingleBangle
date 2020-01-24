package recoder.single.bangle.notice;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {

	@Autowired
	private SqlSessionTemplate sst;
	
	public List<NoticeDTO> toNotice() {
		return sst.selectList("Notice.getNotices");
	}

	public NoticeDTO update(int seq) {
		return sst.selectOne("Notice.readNotice", seq);
	}

	public int postNotice(NoticeDTO dto) {
		return sst.insert("Notice.postNotice", dto);
	}

	public int updateNotice(NoticeDTO dto) {
		return sst.update("Notice.updateNotice", dto);
	}
	
	public int deleteNotice(NoticeDTO dto) {
		return sst.delete("Notice.deleteNotice", dto);
	}
}
