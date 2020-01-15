package recoder.single.bangle.account.component;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import recoder.single.bangle.account.DTO.AccountDTO;

@Component
public class AccountComponent {
	
	private String card;
	private String cash;
	private int in;
	private int out;
	
	public Map<String, Integer> summary(List<AccountDTO> list){
		Map<String, Integer> sum = new HashMap<String, Integer>();
		for(AccountDTO tmp : list) {
			in += tmp.getIncome();
			out += tmp.getExpense();
		}
		Date mon = list.get(0).getReportingDate();
		SimpleDateFormat months = new SimpleDateFormat("MM");
		String month = months.format(mon);
		
		
		
		return sum;
	}
	
}
