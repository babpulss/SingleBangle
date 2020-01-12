package recoder.single.bangle.member.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/email")
@Controller
public class MailController {

	@Autowired
	private JavaMailSender mailSender;

	// 회원가입 이메일 인증
	@RequestMapping("emailConfirm.email")
	public String emailConfirm(String email, Model model) {
		System.out.println("이메일 전송 시작!");

		// 임시 비밀번호 생성
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();

		for (int i = 0; i < 10; i++) {
			int rIndex = rnd.nextInt(3);
			switch (rIndex) {
			case 0:
				// a-z
				temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				break;
			case 1:
				// A-Z
				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 2:
				// 0-9
				temp.append((rnd.nextInt(10)));
				break;
			}
		}
		String AuthenticationKey = temp.toString();
		System.out.println("이메일 인증번호 : " + AuthenticationKey);

		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom("msg_account_jy");
			messageHelper.setTo(email);
			messageHelper.setSubject("안녕하세요. Single방글 입니다. 회원가입 인증번호를 보내드립니다.");
			messageHelper.setText("이메일 인증번호는 [" + AuthenticationKey + "] 입니다.\n인증 후 회원가입을 진행하실 수 있습니다.");
			
			mailSender.send(message);
			model.addAttribute("emailKey", AuthenticationKey);

			System.out.println("이메일 전송 완료!");
			System.out.println();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "member/emailCheck";
	}

}
