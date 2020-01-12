package recoder.single.bangle.AOP;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class Adviser {
	private static final Logger logger = LoggerFactory.getLogger(Adviser.class);

	@Autowired
	private HttpServletRequest req;
	
	@Autowired
	private HttpSession session;
	
	@Around("execution(* recoder.single.bangle.index.*.*(..))")
	public Object getInfoFromIndex(ProceedingJoinPoint pjp) {
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyy/MM/dd hh:mm:ss");
		String ip = req.getRemoteAddr();
		logger.debug(ip + " : " + sdf.format(d.getTime()));
		try {
			return pjp.proceed();
		} catch(Throwable e) {
			e.printStackTrace();
		}
		return null;
	}

}
