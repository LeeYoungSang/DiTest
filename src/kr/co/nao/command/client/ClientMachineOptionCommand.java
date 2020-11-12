package kr.co.nao.command.client;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.MachineDAO;

public class ClientMachineOptionCommand implements Command{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		ActionForward action = new ActionForward();
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		System.out.println("member:"+member);
		
		String memberChk = "NN";
		
		StringBuffer sb = new StringBuffer();		
		MachineDAO dao = new MachineDAO();
		
		if(member == null) 
		{
			action.setRedirect(true);
			action.setPath("loginForm.nao");
		}else {
			
			// 머신 목록
			ArrayList<Map<String, Object>> machineList = dao.getAllMachine((String)member.get("id"), (String)member.get("division"));
			
			if( machineList.size()>0) 
			{
				
				String machineVal = "{\"OPTION_LIST\":[§" ;
				
				for( int i = 0; i < machineList.size(); i++) 
				{
					Map<String, Object> machine = machineList.get(i);
					
					/*
					machine.put("injectionTime_BT", 	rs.getInt("injectionTime_BT"));
					machine.put("unusedTime", 			rs.getInt("unusedTime"));
					machine.put("injectionTime_UUT", 	rs.getInt("injectionTime_UUT"));
					machine.put("usedTimes", 			rs.getInt("usedTimes"));
					machine.put("injectionTime_UT", 	rs.getInt("injectionTime_UT"));
					machine.put("machine_num", 			rs.getString("machine_num"));
					
					ALTER TABLE tb_machine ADD injectionTime_BT INT(3) DEFAULT 0;  -- 부팅시 분사시간
					ALTER TABLE tb_machine ADD unusedTime INT(3) DEFAULT 0;		   -- 미사용 설정시간  
					ALTER TABLE tb_machine ADD injectionTime_UUT INT(3) DEFAULT 0; -- 미사용 분사시간
					ALTER TABLE tb_machine ADD usedTimes INT(3) DEFAULT 0; 		   -- 사용시 세척 사용횟수 
					ALTER TABLE tb_machine ADD injectionTime_UT INT(3) DEFAULT 0;  -- 사용시 분사시간 
					 
					
					String machineVal = "{\"machine_num\":\""+machine.get("machine_num")+"\","
							+ "\"injectionTime_BT(부팅시 분사시간)\":\""+machine.get("injectionTime_BT")+ "\", "
							+ "\"unusedTime(미사용 설정시간 )\":\""+machine.get("unusedTime")+ "\", "
							+ "\"injectionTime_UUT(미사용 분사시간)\":\""+machine.get("injectionTime_UUT")+ "\", "
							+ "\"usedTimes(사용시 세척 사용횟수 )\":\""+machine.get("usedTimes")+ "\", "
							+ "\"injectionTime_UT(사용시 분사시간  )\":\""+machine.get("injectionTime_UT")+ "\"}";
					*/
					
					machineVal += "{\"machine_num\":\""+machine.get("machine_num")+"\","
					+ "\"injectionTime_BT\":\""+machine.get("injectionTime_BT")+ "\", "
					+ "\"unusedTime\":\""+machine.get("unusedTime")+ "\", "
					+ "\"injectionTime_UUT\":\""+machine.get("injectionTime_UUT")+ "\", "
					+ "\"usedTimes\":\""+machine.get("usedTimes")+ "\", ";

					if( (machineList.size()-1) == i) 
					{
						machineVal += "\"injectionTime_UT\":\""+machine.get("injectionTime_UT")+ "\"}";
						machineVal += "]}";
					}else {
						machineVal += "\"injectionTime_UT\":\""+machine.get("injectionTime_UT")+ "\"},§";
					}
				}
				
				sb.append(machineVal);
			}
			else 
			{
				sb.append("등록된 내용이 없습니다.");
			}
			
			request.setAttribute("machineOption", sb.toString());
			
			action.setRedirect(false);
			action.setPath("WEB-INF/client/optionList.jsp");
		}
		
		return action;
	}
	
}
