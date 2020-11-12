package kr.co.nao.command.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;


/**
 * 로그인 폼 
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

public class LoginFormCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		ActionForward action = new ActionForward();
		action.setRedirect(false);
		action.setPath("/WEB-INF/member/loginForm.jsp");
		
		return action;
	}
}
