package recoder.single.bangle.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import recoder.single.bangle.admin.DAO.AdminDAO;

@Service
public class AdminService {

	@Autowired
	private AdminDAO dao;
}
