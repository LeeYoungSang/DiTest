package kr.co.nao.command.contents;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.FileDAO;

/**
 * 파일 검색
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

public class SearchFileCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			FileDAO dao = new FileDAO();
			ArrayList<Map<String, Object>> fileList = dao.searchFile((String)member.get("id"), (String)member.get("division"));

			request.setAttribute("fileList", fileList);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/contents/searchFile.jsp");
		}
		
		return action;
	}
}
