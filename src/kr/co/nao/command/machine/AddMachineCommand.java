package kr.co.nao.command.machine;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.nao.common.ActionForward;
import kr.co.nao.common.Command;
import kr.co.nao.dao.MachineDAO;

/**
 * 머신 등록
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

public class AddMachineCommand implements Command {

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
			
			String machine_num = request.getParameter("machine_num");
			String machine_type = request.getParameter("machine_type");
			String location_type = request.getParameter("location_type");
			String installed_place = request.getParameter("installed_place");
			String detail_place = request.getParameter("detail_place");
			String partner = request.getParameter("partner");
			String location_x = request.getParameter("x");
			String location_y = request.getParameter("y");
			int injectionTime_BT = Integer.parseInt(request.getParameter("injectionTime_BT"));   // 부팅시 분사시간
			int unusedTime = Integer.parseInt(request.getParameter("unusedTime"));				 // 미사용 설정시간
			int injectionTime_UUT = Integer.parseInt(request.getParameter("injectionTime_UUT")); // 미사용  분사시간
			int usedTimes = Integer.parseInt(request.getParameter("usedTimes"));				 // 사용시 세척 사용횟수
			int injectionTime_UT = Integer.parseInt(request.getParameter("injectionTime_UT"));	 // 사용시 분사시간
			
			System.out.println("머신번호" + machine_num);
			System.out.println("머신타입" + machine_type);
			System.out.println("매장종류" + location_type); 
			System.out.println("머신장소" + installed_place);
			System.out.println("상세주소" + detail_place);
			System.out.println("파트너" + partner);
			System.out.println("x죄표" + location_x);
			System.out.println("y좌표" + location_y);
			System.out.println("부팅시 분사시간:" + injectionTime_BT);
			System.out.println("미사용 설정시간:" + unusedTime);
			System.out.println("미사용 분사시간:" + injectionTime_UUT);
			System.out.println("사용시 세척 사용횟수:" + usedTimes);
			System.out.println("사용시 분사시간:" + injectionTime_UT);

			MachineDAO dao = new MachineDAO();
			
			int pkNum = dao.getMachinetPK(); // 머신 pk 채번
			
			boolean result = dao.addMachine(machine_num, machine_type, location_type, installed_place, detail_place, partner, location_x,location_y,injectionTime_BT,unusedTime,injectionTime_UUT,usedTimes,injectionTime_UT, pkNum);
			
			if(result) {
				action.setRedirect(true);
				action.setPath("machineList.nao");
			
			} else {
				action.setRedirect(false);
				action.setPath("WEB-INF/machine/machineResult.jsp?error=1");
			}
			
		}
		
		return action;
	}
}
