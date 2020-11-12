package kr.co.nao.command.client;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.ScheduleDAO;

/**
 * 클라이언트
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

public class ClientCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		ActionForward action = new ActionForward();
		
//		Calendar cal = Calendar.getInstance();
//
		// 추후 파일에서 
		String machine_num = request.getParameter("uid");

		if(machine_num == null) {
			machine_num = "2020-01-13-002";
		}		
		
		System.out.println("machine_num ::::: " + machine_num);
		
		ScheduleDAO sDao = new ScheduleDAO();
		ArrayList<Map<String, Object>> scheduleList = sDao.getTodaySchedule(machine_num);
		
		request.setAttribute("scheduleList", scheduleList);
		
		System.out.println(request.getRemoteAddr());
		
		action.setRedirect(false);
		action.setPath("WEB-INF/client/client.jsp");
		
		return action;
	}
}
