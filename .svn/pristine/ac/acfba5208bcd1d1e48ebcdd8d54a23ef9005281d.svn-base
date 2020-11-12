package kr.co.nao.command.contents;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.ContentsDAO;

/**
 * 컨텐츠 수정
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

public class UpdateContentsCommand implements Command {

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
			
			String num = request.getParameter("contentNum");
			String title = request.getParameter("title");					// 컨텐츠 제목
			String content = request.getParameter("content");		// 컨텐츠 파일 명
			String persent = request.getParameter("persent");		// 축소 비율
			String advertiser_num = request.getParameter("advertiser_num");	// 광고주 고유번호
			
			ContentsDAO dao = new ContentsDAO();
			boolean result = dao.updateContents(num, title, content, advertiser_num);
		
			if(result) {
				// 기존 레이어 삭제
				dao.deleteLayer(num);
				
				String [] layerId = request.getParameterValues("layerId");
				String [] layerWidth = request.getParameterValues("layerWidth");
				String [] layerHeight = request.getParameterValues("layerHeight");
				String [] layerX = request.getParameterValues("layerX");
				String [] layerY = request.getParameterValues("layerY");
				String [] layerBGColor = request.getParameterValues("layerBGColor");
				String [] layerPriority = request.getParameterValues("layerPriority");
				String [] layerFileNum = request.getParameterValues("layerFileNum");
				String [] layerText = request.getParameterValues("layerText");
				
				for(int i = 0; i < layerId.length; i++) {
					String id = layerId[i];
					String width = null;
					String height = null;
					String x = null;
					String y = null;
					String bGColor = null;
					String priority = null;
					String fileNum = null;
					String text = null;
					
					for(int j = 0; j < layerWidth.length; j++) {
						if(layerWidth[i].startsWith(id)) {
							width = layerWidth[i].substring(id.length());
							break;
						}
					}
					
					for(int j = 0; j < layerHeight.length; j++) {
						if(layerHeight[i].startsWith(id)) {
							height = layerHeight[i].substring(id.length());
							break;
						}
					}
					
					for(int j = 0; j < layerX.length; j++) {
						if(layerX[i].startsWith(id)) {
							x = layerX[i].substring(id.length());
							break;
						}
					}
					
					for(int j = 0; j < layerY.length; j++) {
						if(layerY[i].startsWith(id)) {
							y = layerY[i].substring(id.length());
							break;
						}
					}					
					
					for(int j = 0; j < layerBGColor.length; j++) {
						if(layerBGColor[i].startsWith(id)) {
							bGColor = layerBGColor[i].substring(id.length());
							break;
						}
					}					

					for(int j = 0; j < layerPriority.length; j++) {
						if(layerPriority[i].startsWith(id)) {
							priority = layerPriority[i].substring(id.length());
							break;
						}
					}		
					
					for(int j = 0; j < layerFileNum.length; j++) {
						if(layerFileNum[i].startsWith(id)) {
							fileNum = layerFileNum[i].substring(id.length());
							break;
						}
					}	
					
					for(int j = 0; j < layerText.length; j++) {
						if(layerText[i].startsWith(id)) {
							text = layerText[i].substring(id.length());
							break;
						}
					}	
					
					dao.addLayer(id, width, height, x, y, bGColor, priority, Integer.parseInt(num), fileNum, text, persent);
				}
				
				action.setRedirect(true);
				action.setPath("contentsList.nao");
				
			} else {
				action.setRedirect(false);
				action.setPath("WEB-INF/contents/updateContentsResult.jsp");
			}
		}
		
		return action;
	}
}
