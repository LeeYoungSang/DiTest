package kr.co.nao.common;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.nao.mapping.CommandFactory;

/**
 * 광고 플랫폼 Controller
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
@WebServlet("*.nao")
public class ActionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURI();
		System.out.println("Request URI : " + url);

		CommandFactory factory = CommandFactory.getInstance();
		
		Command command = factory.getCommand(url);
		ActionForward action = command.execute(request, response);
		
		if(action.isRedirect()) {
			response.sendRedirect(action.getPath());
		
		} else {
			RequestDispatcher rd = request.getRequestDispatcher(action.getPath());
			rd.forward(request, response);
		}
	}

}
