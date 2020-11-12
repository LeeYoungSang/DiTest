package kr.co.nao.command.machine;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.MachineDAO;

/**
 * 머신 분사옵션 일괄 수정
 * 
 * @author	이영상
 * @since		2020.10.06
 * @version	1.0
 * 
 * <pre>
 * << 개정이력 >>
 * ------------------------------------------------------
 * 수정일				수정자				수정내용
 * ------------------------------------------------------
 */

public class UpdatePopMachineCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			
			try {
				request.setCharacterEncoding("UTF-8");

			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			String[] num_val = request.getParameterValues("chkVal");
			
			String[] num_Values = num_val[0].split(",");
			
			System.out.println("num_Values:"+num_Values);
			
			if(num_Values == null) 
			{
				num_Values = request.getParameterValues("chkVal");
			}
			
			int injectionTime_BT = Integer.parseInt(request.getParameter("val1"));   // 부팅시 분사시간
			int unusedTime = Integer.parseInt(request.getParameter("val2"));		 // 미사용 설정시간
			int injectionTime_UUT = Integer.parseInt(request.getParameter("val3"));  // 미사용  분사시간
			int usedTimes = Integer.parseInt(request.getParameter("val4"));			 // 사용시 세척 사용횟수
			int injectionTime_UT = Integer.parseInt(request.getParameter("val5"));	 // 사용시 분사시간
			
			System.out.println("UpdatePopMachineCommand 부팅시 분사시간:" + injectionTime_BT);
			System.out.println("UpdatePopMachineCommand 미사용 설정시간:" + unusedTime);
			System.out.println("UpdatePopMachineCommand 미사용 분사시간:" + injectionTime_UUT);
			System.out.println("UpdatePopMachineCommand 사용시 세척 사용횟수:" + usedTimes);
			System.out.println("UpdatePopMachineCommand 사용시 분사시간:" + injectionTime_UT);
			
			MachineDAO dao = new MachineDAO();
			
			int result = 0;
			
			for(int i = 0; i < num_Values.length; i ++) 
			{
				System.out.println("UpdatePopMachineCommand num_Values:"+num_Values[i]);
				
				result += dao.AllupdateMachine(num_Values[i], injectionTime_BT, unusedTime, injectionTime_UUT, usedTimes, injectionTime_UT);
			}
			
			System.out.println("UpdatePopMachineCommand result:"+result);
			
			if(result > 0) {
				action.setRedirect(true);
				action.setPath("machinePopList.nao");
			
			} else {
				action.setRedirect(false);
				action.setPath("WEB-INF/machine/machineResult.jsp?error=2");
			}
		}
		
		return action;
	}
}
