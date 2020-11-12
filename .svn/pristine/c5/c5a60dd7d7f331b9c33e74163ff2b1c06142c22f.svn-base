package kr.co.nao.command.contents;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.AdvertiserDAO;
import kr.co.nao.dao.ContentsDAO;

/**
 * 컨텐츠 수정 폼
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

public class UpdateContentsFormCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		Map<String, Object> member = (Map<String, Object>)session.getAttribute("member");
		
		ActionForward action = new ActionForward();

		if(member == null) {
			action.setRedirect(true);
			action.setPath("loginForm.nao");

		} else {
			String contentsNum = request.getParameter("contents_num");
			
			ContentsDAO dao = new ContentsDAO();
			Map<String, Object> contents = dao.getContents(contentsNum);
			ArrayList<Map<String, Object>> layerList = dao.getLayer(contentsNum);
			
			AdvertiserDAO adDAO = new AdvertiserDAO();
			ArrayList<Map<String, Object>> advertiserList = adDAO.searchAdvertiser((String)member.get("id"), (String)member.get("division"));

			request.setAttribute("advertiserList", advertiserList);
			request.setAttribute("contents", contents);
			request.setAttribute("layerList", layerList);
			
			action.setRedirect(false);
			action.setPath("WEB-INF/contents/updateContentsForm.jsp");
		}
		
		return action;
	}
}
