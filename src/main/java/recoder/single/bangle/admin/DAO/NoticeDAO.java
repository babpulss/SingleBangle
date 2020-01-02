package recoder.single.bangle.admin.DAO;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {

	@Autowired
	private JdbcTemplate jdbc;
	
	@Autowired
	private SqlSessionTemplate sst;
}
