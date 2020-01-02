package recoder.single.bangle.admin.DTO;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class AdminDTO {

	@Autowired
	private JdbcTemplate jdbc;
	
	@Autowired
	private SqlSessionTemplate sst;
}
