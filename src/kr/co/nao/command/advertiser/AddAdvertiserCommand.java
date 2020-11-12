package kr.co.nao.command.advertiser;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.AdvertiserDAO;

/**
 * 광고주 입력
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

public class AddAdvertiserCommand implements Command {

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
			
			try {
				String advertiser_name = request.getParameter("advertiser_name");
				String advertiser_info = request.getParameter("advertiser_info");
			
				AdvertiserDAO dao = new AdvertiserDAO();
				boolean result = dao.addAdvertiser(advertiser_name, advertiser_info, (String)member.get("id"));
			
				if(result) {
					action.setRedirect(true);
					action.setPath("advertiserList.nao");
					
				} else {
					action.setRedirect(false);
					action.setPath("WEB-INF/advertiser/advertiserResult.jsp");
				}

			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return action;
	}
}
