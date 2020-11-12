package kr.co.nao.command.schedule;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.ScheduleDAO;

/**
 * 스케줄 수정 폼
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

public class UpdateScheduleFormCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			String scheduleNum = request.getParameter("schedule_num");
			
			ScheduleDAO dao = new ScheduleDAO();
			Map<String, Object> schedule = dao.getSchedule(scheduleNum);
			
			request.setAttribute("schedule", schedule);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/schedule/updateScheduleForm.jsp");
		}
		
		return action;
	}
}
