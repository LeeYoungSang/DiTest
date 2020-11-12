package kr.co.nao.command.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.MemberDAO;


/**
 * 로그인 
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

public class LoginCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberDAO dao = new MemberDAO();
		Map<String, Object> member = dao.login(id, pw);

		ActionForward action = new ActionForward();

		if(member != null) {
			HttpSession session = request.getSession();
			session.setAttribute("member", member);
			
			// 광고주일 경우
			if("02".equals((String)member.get("division"))) {
				action.setPath("statisticsListByAdvertiser.nao");
				
			} else {
//				action.setPath("dashboard.nao");			
				action.setPath("machineMap.nao");			
			}
			
			action.setRedirect(true);
		
		} else {
			action.setRedirect(true);
			action.setPath("loginForm.nao");			
		}
		
		return action;
	}
}
