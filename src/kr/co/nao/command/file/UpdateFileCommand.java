package kr.co.nao.command.file;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.FileDAO;

/**
 * 파일 수정
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

public class UpdateFileCommand implements Command {

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
			
			String file_num = request.getParameter("file_num");
			String file_content = request.getParameter("file_content");
			
			FileDAO dao = new FileDAO();
			boolean result = dao.updateFile(file_num, file_content);
			
			if(result) {
				action.setRedirect(true);
				action.setPath("fileList.nao");
				
			} else {
				action.setRedirect(false);
				action.setPath("WEB-INF/contents/updateFileResult.jsp");
			}
		}
		
		return action;
	}
}
