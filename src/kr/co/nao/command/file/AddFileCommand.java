package kr.co.nao.command.file;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.FileDAO;

/**
 * 파일 입력
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

public class AddFileCommand implements Command {

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
			
			String uploadPath = "/home/hosting_users/kh0917/tomcat/webapps/DiClean/upload";
			
			try {
				MultipartRequest multi = new MultipartRequest(request, uploadPath, 100 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());
				
				String file_content = multi.getParameter("file_content");
				String real_file_name = multi.getFilesystemName("file_name");
				String fileType = real_file_name.substring(real_file_name.lastIndexOf("."));
//				String maskName = System.currentTimeMillis() + "." + fileType;
				String maskName = System.currentTimeMillis() + fileType;
				
				File file = new File(uploadPath + "/" + real_file_name);
				file.renameTo(new File(uploadPath + "/" + maskName));
			
				FileDAO dao = new FileDAO();
				boolean result = dao.addFile(maskName, real_file_name, file_content, (String)member.get("id"));
			
				if(result) {
					action.setRedirect(true);
					action.setPath("fileList.nao");
					
				} else {
					action.setRedirect(false);
					action.setPath("WEB-INF/file/fileResult.jsp");
				}

			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return action;
	}
}
