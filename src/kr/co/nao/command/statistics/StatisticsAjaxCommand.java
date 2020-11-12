package kr.co.nao.command.statistics;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.AdvertiserDAO;
import kr.co.nao.dao.StatisticsDAO;

/**
 * 통계 목록
 * 
 * @author	이영상
 * @since		2020.08.19
 * @version	1.0
 * 
 * <pre>
 * << 개정이력 >>
 * ------------------------------------------------------
 * 수정일				수정자				수정내용
 * ------------------------------------------------------
 * 08.19			이영상				최초생성
 */




public class StatisticsAjaxCommand implements Command 
{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
	{
		
		System.out.println("StatisticsAjaxCommand");
		
		response.setContentType("text/html;charset=utf-8");
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		//검색 조건 구분 값
		String type = "";
		
		//광고종류
		String selADT = "";
		
		//광고종류
		String selAdKind = "";
		
		//머신
		String selMc = "";
		
		//통계리스트 
		ArrayList<Map<String, Object>> stList = null;
		
		//parameterList
		ArrayList<Map<String, Object>> paramList = new ArrayList<Map<String, Object>>();
		
		JSONObject json = new JSONObject();
		String ajaxList = "";
		
		if(member == null) 
		{
			action.setRedirect(true);
			action.setPath("loginForm.nao");
		}
		else 
		{
			StatisticsDAO dao = new StatisticsDAO();
			
			type = request.getParameter("searchType");
			System.out.println("request.getParameter(searchType):"+request.getParameter("searchType"));
			
			if(request.getParameter("selADT") == null) 
			{
				selADT = "";
			}
			else 
			{
				selADT = request.getParameter("selADT");
			}
			String preDate  = request.getParameter("preDate");		//시작일자
			String postDate = request.getParameter("postDate"); 	//종료일자
			String preDateM  = request.getParameter("preDateM");	//월별시작일자
			
			String test = request.getParameter("ADTVal");			//광고주value
			selADT    = request.getParameter("selADT");				//광고주
			selAdKind = request.getParameter("selAdKind");		    //광고종류
			selMc     = request.getParameter("selMc");				//머신
			
			System.out.println("StatisticsAjaxCommand preDate:"+preDate);
			System.out.println("StatisticsAjaxCommand postDate:"+postDate);
			System.out.println("StatisticsAjaxCommand preDateM:"+preDateM);
			
			System.out.println("StatisticsAjaxCommand selADT:"+selADT);
			System.out.println("StatisticsAjaxCommand selAdKind:"+selAdKind);
			System.out.println("StatisticsAjaxCommand selMc:"+selMc);
			
			System.out.println("test:"+test);
			
			//일일통계리스트
			if("day".equals(type)) 
			{
//				stList = dao.getStatisticsTestList((String)member.get("id"));
//				json  = dao.getStatisticsDayListJson((String)member.get("id"));
				
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("id", (String)member.get("id"));  		    //Login ID
				param.put("division", (String)member.get("division"));  //division
				param.put("preDate", preDate);					 	    //검색 시작일자
				param.put("selADT", selADT );					    	//광고주
				param.put("selAdKind", selAdKind );					    //광고종류
				param.put("selMc", selMc );							    //머신
				
				paramList.add(param);
				
//				ajaxList = dao.getStatisticsDayListJson2(paramList);
				
				json = dao.getStatisticsDayListJson(paramList);
				
				System.out.println("StatisticsAjaxCommand:일일통계리스트 호출");
				
//				System.out.println("ajaxList:"+ajaxList);
			}
			
			//월별통계리스트
			if("month".equals(type))
			{
				Map<String, Object> param = new HashMap<String, Object>();
				
				param.put("id", (String)member.get("id"));  		    //Login ID
				param.put("division", (String)member.get("division"));  //division
				param.put("preDateM", preDateM);					 	//검색  월별
				param.put("type", type );						 	    //통계종류
				param.put("selADT", selADT );					    	//광고주
				param.put("selAdKind", selAdKind );					    //광고종류
				param.put("selMc", selMc );							    //머신
				
				paramList.add(param);
				
				stList = dao.getStatisticsMonthListJson(paramList);
				
				json.put("list", stList);
				
				System.out.println("StatisticsAjaxCommand:월별통계리스트 호출");
			}
			
			if("period".equals(type)) 
			{
				
				Map<String, Object> param = new HashMap<String, Object>();
				
				param.put("id", (String)member.get("id"));  		    //Login ID
				param.put("division", (String)member.get("division"));  //division
				param.put("preDate", preDate);					 	    //검색 시작일자
				param.put("postDate", postDate);					 	//검색 종료일자
				param.put("selADT", selADT );					    	//광고주
				param.put("selAdKind", selAdKind );					    //광고종류
				param.put("selMc", selMc );							    //머신

				paramList.add(param);
				
				stList = dao.getStatisticsPeriodMListJson(paramList);
				
				json.put("list", stList);
				
				System.out.println("StatisticsAjaxCommand:기간별별통계리스트 호출");
			}
			
			JSONObject jsonObject = new JSONObject();
			
			try 
			{
				PrintWriter pw = response.getWriter();
				//jsonObject.put("list", stList);
				
//				JSONParser jsonParser = new JSONParser();
//				jsonObject = (JSONObject)jsonParser.parse(ajaxList);
				
//				pw.print(jsonObject);
				
				pw.print(json);
				pw.flush();
				pw.close();
			
			}
			catch(Exception e) 
			{
				e.printStackTrace();
			}
			
			action.setRedirect(true);
			action.setPath("WEB-INF/statistics/statisticsTestList.jsp");
		}
		
		return action;
	}
}
