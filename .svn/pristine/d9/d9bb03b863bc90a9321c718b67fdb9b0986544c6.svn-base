package kr.co.nao.command.specialSchedule;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.SpecialScheduleDAO;
import kr.co.nao.util.Util;

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

public class SpecialScheduleListByMachineCommand implements Command {

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
			
			if(schedule_date == null || schedule_date.length() == 4) {
				Calendar c = Calendar.getInstance();
				schedule_date = c.get(Calendar.YEAR) + "-" + Util.changeNum(c.get(Calendar.MONTH) + 1) + "-" + Util.changeNum(c.get(Calendar.DATE));
			}
			
			SpecialScheduleDAO dao = new SpecialScheduleDAO();
			ArrayList<Map<String, Object>> scheduleList = dao.getSchedule(machine_num, schedule_date);
			
			request.setAttribute("scheduleList", scheduleList);
			request.setAttribute("schedule_date", schedule_date);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/specialSchedule/specialScheduleListByMachine.jsp");
		}
		
		return action;
	}
}
