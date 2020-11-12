package kr.co.nao.command.schedule;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.ScheduleDAO;

/**
 * 1개의 machine에 등록된 스케줄 검색
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

public class SelectScheduleCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			String machine_num	= request.getParameter("machine_num");
			String schedule_date = request.getParameter("schedule_date");
			
			ScheduleDAO dao = new ScheduleDAO();
			ArrayList<Map<String, Object>> reservationList = dao.selectSchedule(machine_num, schedule_date, null);

			request.setAttribute("reservationList", reservationList);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/schedule/selectSchedule.jsp");
		}
		
		return action;
	}
}
