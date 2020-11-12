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
 * Time 검색
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

public class SearchTimeCommand implements Command {

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
			String schedule_date = request.getParameter("schedule_date");
			String schedule_start_time = request.getParameter("schedule_start_time");
			
			System.out.println("schedule start time :::::: " + schedule_start_time);
			
			ScheduleDAO dao = new ScheduleDAO();
			ArrayList<Map<String, Object>> scheduleList = dao.selectSchedule(machine_num, schedule_date, schedule_start_time);

			request.setAttribute("scheduleList", scheduleList);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/schedule/searchTime.jsp");
		}
		
		return action;
	}
}
