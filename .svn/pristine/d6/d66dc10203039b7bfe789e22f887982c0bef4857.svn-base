package kr.co.nao.command.member;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.MemberDAO;


/**
 * 회원 가입 처리
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

public class AddMemberCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			request.setCharacterEncoding("UTF-8");

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		String id 				= request.getParameter("id");
		String pw 			= request.getParameter("pw");
		String name 		= request.getParameter("name");
		String division 	= request.getParameter("division");
		
		MemberDAO dao = new MemberDAO();
		boolean result = dao.addMember(id, pw, name, division);

		ActionForward action = new ActionForward();
		
		if(result) {
			action.setRedirect(false);
			action.setPath("WEB-INF/member/addMemberResult.jsp");
		}
		
		return action;
	}
}
