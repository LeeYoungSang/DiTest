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
 * 중복 등록된 스케줄 검색
 * 
 * @author	김관형
 * @since		2020.04.16
 * @version	1.0
 * 
 * <pre>
 * << 개정이력 >>
 * ------------------------------------------------------
 * 수정일				수정자				수정내용
 * ------------------------------------------------------
 */

public class DupsScheduleCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			
			String fromDate			= request.getParameter("fromDate");
			String toDate 				= request.getParameter("toDate");
			String startTime			= request.getParameter("startTime");
			String endTime 			= request.getParameter("endTime");
			String termTime			= request.getParameter("termTime");
			String machineNum 	= request.getParameter("machineNum");
			
			System.out.println("======>>>>> " + fromDate);
			System.out.println("======>>>>> start " + startTime);
			System.out.println("======>>>>> end " + endTime);
			
			ScheduleDAO dao = new ScheduleDAO();
			int dupsCount = dao.dupsSchedule(fromDate, toDate, startTime, endTime, termTime, machineNum);

			request.setAttribute("dupsCount", dupsCount);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/schedule/dupsSchedule.jsp");
		}
		
		return action;
	}
}
