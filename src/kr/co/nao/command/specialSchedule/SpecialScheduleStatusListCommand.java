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
 * 프리미엄 스케줄 목록
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

public class SpecialScheduleStatusListCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			int pageNum = 1;
			
			if(request.getParameter("pn") != null) {
				pageNum = Integer.parseInt(request.getParameter("pn"));
			}
			
			String schedule_date = request.getParameter("schedule_date");
			
			if(schedule_date == null || schedule_date.length() == 4) {
				Calendar c = Calendar.getInstance();
				schedule_date = c.get(Calendar.YEAR) + "-" + Util.changeNum(c.get(Calendar.MONTH) + 1) + "-" + Util.changeNum(c.get(Calendar.DATE));
			}
			
			SpecialScheduleDAO dao = new SpecialScheduleDAO();
			
			// 스케줄 목록
			ArrayList<Map<String, Object>> scheduleList = dao.getAllSchedule(schedule_date, pageNum, (String)member.get("id"), (String)member.get("division"));
			
			// 게시물의 총 갯수
			int totalRow = dao.getTotalRow();
			
			request.setAttribute("schedule_date", schedule_date);
			request.setAttribute("specialScheduleList", scheduleList);
			request.setAttribute("pn", pageNum);
			request.setAttribute("totalRow", totalRow);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/specialSchedule/specialScheduleStatusList.jsp");
		}
		
		return action;
	}
}
