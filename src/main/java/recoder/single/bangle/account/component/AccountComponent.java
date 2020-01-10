package recoder.single.bangle.account.component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import recoder.single.bangle.account.DTO.AccountDTO;

public class AccountComponent {
	
	private String card;
	private String cash;
	private int in;
	private int out;
	
	public Map<String, Integer> summary(List<AccountDTO> list){
		Map<String, Integer> sum = new HashMap<String, Integer>();
		
		return sum;
	}
	
}
