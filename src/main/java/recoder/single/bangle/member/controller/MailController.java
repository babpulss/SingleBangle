package recoder.single.bangle.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/mail")
@Controller
public class MailController {
	
	@RequestMapping("emailConfirm.email")
	public String emailConfirm() {
		
		return "member/emailCheck";
	}
	
}
