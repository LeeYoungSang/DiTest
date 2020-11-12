package kr.co.nao.command.machine;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.MachineDAO;

/**
 * 머신  팝업 목록
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

public class MachinePopListCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			
			MachineDAO dao = new MachineDAO();
			
			// 머신 목록
			ArrayList<Map<String, Object>> machineList = dao.getAllPopMachine((String)member.get("id"), (String)member.get("division"));
			
			request.setAttribute("machineList", machineList);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/machine/machinePopList.jsp");
		}
		
		return action;
	}
}
