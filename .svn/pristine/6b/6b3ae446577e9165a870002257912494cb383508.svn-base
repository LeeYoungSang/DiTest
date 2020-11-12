package kr.co.nao.command.member;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.MemberDAO;


/**
 * 회원 수정 처리
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

public class UpdateMemberCommand implements Command {

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
		
			String pw 			= request.getParameter("pw");
			String name 		= request.getParameter("name");
			String address 	= request.getParameter("address");
		
			MemberDAO dao = new MemberDAO();
			boolean result = dao.updateMember((String)member.get("id"), pw, name, address);

			if(result) {
				member.put("pw", pw);
				member.put("name", name);
				member.put("address", address);
				
				session.setAttribute("member", member);
				
				action.setRedirect(false);
				action.setPath("WEB-INF/member/updateMemberForm.jsp");
			}
		}
		
		return action;
	}
}
