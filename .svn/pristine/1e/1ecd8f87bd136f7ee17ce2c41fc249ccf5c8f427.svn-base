package kr.co.nao.command.statistics;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.tools.Tool;

import org.json.simple.JSONObject;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.AdvertiserDAO;
import kr.co.nao.dao.StatisticsDAO;

/**
 * select 광고주  list
 * 
 * @author	이영상
 * @since		2020.08.24
 * @version	1.0
 * 
 * <pre>
 * << 개정이력 >>
 * ------------------------------------------------------
 * 수정일				수정자				수정내용
 * ------------------------------------------------------
 * 08.24			이영상				최초생성
 */




public class StatisticsSelectADTCommand implements Command 
{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
	{
		response.setContentType("text/html;charset=utf-8");
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();
		
		StatisticsDAO dao = new StatisticsDAO();
		
		
//		JSONObject jsonObject = new JSONObject();
//		
//		try 
//		{
//			PrintWriter pw = response.getWriter();
//			
//			jsonObject.put("adtList", adtList);
//			
//			pw.print(jsonObject);
//			pw.flush();
//			pw.close();
//		
//		}
//		catch(Exception e) 
//		{
//			e.printStackTrace();
//		}
		action.setRedirect(false);
		action.setPath("WEB-INF/statistics/statisticsTestList.jsp");
		
		return action;
	}
}
