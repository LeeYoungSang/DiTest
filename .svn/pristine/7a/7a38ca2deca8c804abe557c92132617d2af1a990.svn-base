package kr.co.nao.command.statistics;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.StatisticsDAO;

/**
 * Json 데이터 등록
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




public class StatisticsJsonCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) 
		{
			action.setRedirect(true);
			action.setPath("loginForm.nao");
		}
		else 
		{
			StatisticsDAO dao = new StatisticsDAO();
			
			int updateChk = 0;
			
			updateChk = dao.jsonInsert();
			
			System.out.println("insert 확인:"+updateChk);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/statistics/statisticsList.jsp");
		}
		
		return action;
	}
}
