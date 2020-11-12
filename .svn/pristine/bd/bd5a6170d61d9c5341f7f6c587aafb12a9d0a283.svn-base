package kr.co.nao.command.file;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.FileDAO;

/**
 * 파일 수정 폼
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

public class UpdateFileFormCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			String file_num = request.getParameter("file_num");
			
			FileDAO dao = new FileDAO();
			Map<String, Object> file = dao.getFile(file_num);
			
			request.setAttribute("file", file);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/file/updateFileForm.jsp");
		}
		
		return action;
	}
}
