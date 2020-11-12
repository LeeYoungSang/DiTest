package kr.co.nao.command.schedule;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.ScheduleDAO;

/**
 * 스케줄 입력
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

public class AddScheduleCommand implements Command {

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
			
			String schedule_date = request.getParameter("schedule_date");						// 스케줄 일자
			String [] scheduleTime = request.getParameterValues("addTime");			// 스케줄 시작 시간 집합
			String machineNum = request.getParameter("machine_num");							// 머신 번호
			String contentNum = request.getParameter("contents_num");							// 컨텐츠 번호
			
			ScheduleDAO dao = new ScheduleDAO();

			boolean isSuccess = true;
			
			if(scheduleTime != null) {
				for(int i = 0; i < scheduleTime.length; i++) {
					boolean result = dao.addSchedule(schedule_date, scheduleTime[i], machineNum, contentNum, (String)member.get("id"));
					
					if(!result) {
						isSuccess = false;
						break;
					}
				}
			}
			
			if(isSuccess) {
				action.setRedirect(true);
				action.setPath("scheduleList.nao");
				
			} else {
				action.setRedirect(false);
				action.setPath("WEB-INF/schedule/addScheduleResult.jsp");
			}
		}
		
		return action;
	}
}
