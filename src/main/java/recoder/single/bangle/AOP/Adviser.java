package recoder.single.bangle.AOP;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import recoder.single.bangle.member.DTO.MemberDTO;
import recoder.single.bangle.remarket.service.MsgService;

@Component
@Aspect
public class Adviser {
	private static final Logger logger = LoggerFactory.getLogger(Adviser.class);

	@Autowired
	private HttpServletRequest req;
	
	@Autowired
	private MsgService msgService;
	
	@Autowired
	private HttpSession session;
	
	@Around("execution(* recoder.single.bangle.*.*(..)) ||" +
			"execution(* recoder.single.bangle.*.*.*.*(..)) ||" + 
			"execution(* recoder.single.bangle.*.*.*(..)) &&" +
			"!execution(void recoder.single.bangle.AOP.AdminScheduler.blockedId())") 
	public Object getInfoFromIndex(ProceedingJoinPoint pjp) {
		String url = req.getRequestURL().toString();
		String path = req.getServletPath();
		String ip = req.getRemoteAddr();
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyy/MM/dd hh:mm:ss");
		

		logger.debug(url + " ~ " + path);
		logger.debug(ip + " - " + sdf.format(d.getTime()));

		try {
			return pjp.proceed();
		} catch(Throwable e) {
			e.printStackTrace();
		}
		return null;
	}

	@Before("execution(* recoder.single.bangle.index.*.*(..))" +
			"execution(* recoder.single.bangle.*.*.*.*(..)) ||" + 
			"execution(* recoder.single.bangle.*.*.*(..)) &&" +
			"!execution(void recoder.single.bangle.AOP.AdminScheduler.blockedId())")
	public void beford(JoinPoint jp) {
		MemberDTO loginInfo = (MemberDTO) session.getAttribute("loginInfo");
		if(loginInfo != null) {
			String receiver = loginInfo.getId();
			int notRead = msgService.notRead(receiver);
			session.setAttribute("notRead", notRead);
		}
	}
}
