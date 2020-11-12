package kr.co.nao.command.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.MemberDAO;


/**
 * 아이디 중복 확인
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

public class IdDupsCheckCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		MemberDAO dao = new MemberDAO();
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("result", dao.idDupsCheck(id));
		result.put("id", id);
		
		request.setAttribute("result", result);
		
		ActionForward action = new ActionForward();
		action.setRedirect(false);
		action.setPath("WEB-INF/member/idDupsCheckForm.jsp");
		
		return action;
	}
}
