package recoder.single.bangle.AOP;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class Adviser {

	@Autowired
	private HttpServletRequest req;
	
	@Autowired
	private HttpSession session;
	
	@Around("execution(* recoder.single.bangle.index.*.*(..))")
	public Object getInfoFromIndex(ProceedingJoinPoint pjp) {
		String ip = req.getRemoteAddr();
		System.out.println(ip + " 에서 입장");
		try {
			return pjp.proceed();
		} catch(Throwable e) {
			e.printStackTrace();
		}
		return null;
	}

}
