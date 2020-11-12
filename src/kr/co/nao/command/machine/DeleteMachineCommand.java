package kr.co.nao.command.machine;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.MachineDAO;

/**
 * 머신 삭제
 * 
 * @author	김관형
 * @since		2019.11.18
 * @version	1.0
 * 
 * <pre>
 * << 개정이력 >>
 * ------------------------------------------------------
 * 수정일				수정자				수정내용
 * ------------------------------------------------------
 */

public class DeleteMachineCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			
			String machine_num = request.getParameter("machine_num");

			MachineDAO dao = new MachineDAO();
			boolean result = dao.deleteMachine(machine_num);
			
			if(result) {
				action.setRedirect(true);
				action.setPath("machineList.nao");
			
			} else {
				action.setRedirect(false);
				action.setPath("WEB-INF/machine/machineResult.jsp?error=3");
			}
			
		}
		
		return action;
	}
}
