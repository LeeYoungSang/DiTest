package kr.co.nao.command.client;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.ContentsDAO;
import kr.co.nao.dao.ScheduleDAO;

/**
 * Schedule 검색
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

public class SearchScheduleCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		String machine_num = request.getParameter("machine_num");
		
		Calendar c = Calendar.getInstance();
		String schedule_date = c.get(Calendar.YEAR) + "-" + (c.get(Calendar.MONTH) + 1) + "-" + c.get(Calendar.DATE);
		int time = (c.get(Calendar.HOUR_OF_DAY) * 60 * 60) + (c.get(Calendar.MINUTE) * 60) + c.get(Calendar.SECOND);

//		String schedule_date = "2020-02-12";
//		int time = 28;
		
		ScheduleDAO dao = new ScheduleDAO();
		Map<String, Object> schedule = dao.searchSchedule(machine_num, schedule_date, time);
		
		ContentsDAO contentsDao = new ContentsDAO();
		ArrayList<Map<String, Object>> layerList = null;

		if(schedule.size() > 0) {
			layerList = contentsDao.getLayer(schedule.get("contents_num") + "");
		}

		request.setAttribute("layerList", layerList);
		
		ActionForward action = new ActionForward();
		action.setRedirect(false);
		action.setPath("WEB-INF/client/searchSchedule.jsp");
		
		return action;
	}
}
