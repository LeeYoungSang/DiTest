package kr.co.nao.command.specialSchedule;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.SpecialScheduleDAO;

/**
 * 스케줄 삭제
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

public class DeleteSpecialScheduleCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			String scheduleNum = request.getParameter("num");
			
			SpecialScheduleDAO dao = new SpecialScheduleDAO();
			boolean result = dao.deleteSchedule(scheduleNum);
			
			if(result) {
				action.setRedirect(true);
				action.setPath("specialScheduleStatusList.nao");
				
			} else {
				action.setRedirect(false);
				action.setPath("WEB-INF/schedule/deleteScheduleResult.jsp");
			}
		}
		
		return action;
	}
}
