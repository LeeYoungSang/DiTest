package kr.co.nao.command.notice;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.NoticeDAO;

/**
 * 공지사항 수정
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

public class UpdateNoticeCommand implements Command {

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
			
			String notice_num = request.getParameter("notice_num");
			String notice_title = request.getParameter("notice_title");
			String notice_content = request.getParameter("notice_content");
			
			NoticeDAO dao = new NoticeDAO();
			boolean result = dao.updateNotice(notice_num, notice_title, notice_content);
			
			if(result) {
				action.setRedirect(true);
				action.setPath("noticeList.nao");
				
			} else {
				action.setRedirect(false);
				action.setPath("WEB-INF/notice/noticeResult.jsp");
			}
		}
		
		return action;
	}
}
