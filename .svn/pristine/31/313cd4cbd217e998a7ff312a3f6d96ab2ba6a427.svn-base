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
 * 조회수 업데이트
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

public class HitUpdateCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			String notice_num = request.getParameter("notice_num");
			
			NoticeDAO dao = new NoticeDAO();
			boolean result = dao.hitUpdate(notice_num);
			
			if(result) {
				action.setRedirect(true);
				action.setPath("noticeDetail.nao?notice_num=" + notice_num);
				
			} else {
				action.setRedirect(false);
				action.setPath("WEB-INF/notice/noticeResult.jsp");
			}
		}
		
		return action;
	}
}
