package kr.co.nao.command.notice;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.NoticeDAO;

/**
 * 공지사항 목록
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

public class NoticeListCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			int pageNum = 1;
			
			if(request.getParameter("pn") != null) {
				pageNum = Integer.parseInt(request.getParameter("pn"));
			}
			
			NoticeDAO dao = new NoticeDAO();
			
			// 공지사항 목록
			ArrayList<Map<String, Object>> noticeList = dao.getAllNotice(pageNum);
			
			// 게시물의 총 갯수
			int totalRow = dao.getTotalRow();
			
			request.setAttribute("noticeList", noticeList);
			request.setAttribute("pn", pageNum);
			request.setAttribute("totalRow", totalRow);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/notice/noticeList.jsp");
		}
		
		return action;
	}
}
