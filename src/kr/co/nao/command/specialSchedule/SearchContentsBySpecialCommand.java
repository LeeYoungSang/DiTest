package kr.co.nao.command.specialSchedule;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.ContentsDAO;

/**
 * Contents 검색
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

public class SearchContentsBySpecialCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			ContentsDAO dao = new ContentsDAO();
			ArrayList<Map<String, Object>> contentsList = dao.searchContents((String)member.get("id"), (String)member.get("division"));

			request.setAttribute("contentsList", contentsList);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/specialSchedule/searchContentsBySpecial.jsp");
		}
		
		return action;
	}
}
