package kr.co.nao.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class MachineDAO extends CommonDAO {

	public ArrayList<Map<String, Object>> getAllMachine(int pageNum, String id, String division) {
		ArrayList<Map<String, Object>> machineList = new ArrayList<Map<String, Object>>();
		
		String sql = 
			"		select * from tb_machine "
			+ "	where		isDel = 'N' ";
		
		if("01".equals(division)) {
			sql += " and		partner = ? ";
		}
		
		sql += "	limit			?, 10 ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			
			if("01".equals(division)) {
				stmt.setString(1, id);
				stmt.setInt(2, getStartNum(pageNum));
			
			} else {
				stmt.setInt(1, getStartNum(pageNum));
			}
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> machine = new HashMap<String, Object>();
				machine.put("machine_num", 		rs.getString("machine_num"));
				machine.put("install_date",     rs.getDate("install_date"));
				machine.put("detail_place",     rs.getString("detail_place"));
				machine.put("machine_type",		rs.getString("machine_type"));
				machine.put("installed_place", 	rs.getString("installed_place"));
				
				machineList.add(machine);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return machineList;
	}

	public boolean addMachine(String machine_num, String machine_type,String location_type, String installed_place, String detail_place,String partner,String location_x, String location_y,
							  int injectionTime_BT, int unusedTime, int injectionTime_UUT, int usedTimes, int injectionTime_UT, int pkNum	) {
		boolean result = false;
		
//		String sql = 
//			"		insert into tb_machine "
//			+ "	values(?, curdate(), ?, ?, ?,'N',?,?,?,?,?,?,?,?)";
		
		StringBuffer sql = new StringBuffer();
		
		pkNum = pkNum+1;
		
		
		sql.append("INSERT INTO tb_machine                                             		\n");
		sql.append("(			                                           					\n");
		sql.append("                       machine_num                      				\n");
		sql.append("                      ,install_date                      				\n");
		sql.append("                      ,machine_type                      				\n");
		sql.append("                      ,installed_place                      			\n");
		sql.append("                      ,partner                      					\n");
		sql.append("                      ,isDel                      						\n");
		sql.append("                      ,location_x                      					\n");
		sql.append("                      ,location_y                      					\n");
		sql.append("                      ,location_type                     				\n");
		sql.append("                      ,detail_place                      				\n");
		sql.append("                      ,injectionTime_BT                      			\n");
		sql.append("                      ,unusedTime                      					\n");
		sql.append("                      ,injectionTime_UUT                      			\n");
		sql.append("                      ,usedTimes                      					\n");
		sql.append("                      ,injectionTime_UT                      			\n");
		sql.append(")			                                           					\n");
		sql.append("VALUES			                                           				\n");
		sql.append("(			                                           					\n");
		sql.append("				(SELECT  												\n");
		sql.append("			 	  CONCAT(CURDATE(),CONCAT('-',LPAD("+pkNum+",'3','0'))) \n");
		sql.append("				 FROM DUAL)												\n");
		sql.append("				   	   ,curdate()										\n");
		sql.append("				   	   ,?												\n");
		sql.append("				   	   ,?												\n");
		sql.append("				   	   ,?												\n");
		sql.append("				   	   ,'N'												\n");
		sql.append("				   	   ,?												\n");
		sql.append("				   	   ,?												\n");
		sql.append("				   	   ,?												\n");
		sql.append("				   	   ,?												\n");
		sql.append("				   	   ,?												\n");
		sql.append("				   	   ,?												\n");
		sql.append("				   	   ,?												\n");
		sql.append("				   	   ,?												\n");
		sql.append("				   	   ,?												\n");
		sql.append(")			                                           					\n");
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql.toString());
			stmt.setString(1, machine_type);
			stmt.setString(2, installed_place);
			stmt.setString(3, partner);
			stmt.setString(4, location_x);
			stmt.setString(5, location_y);
			stmt.setString(6, location_type);
			stmt.setString(7, detail_place);
			stmt.setInt(8, injectionTime_BT);
			stmt.setInt(9, unusedTime);
			stmt.setInt(10, injectionTime_UUT);
			stmt.setInt(11, usedTimes);
			stmt.setInt(12, injectionTime_UT);
			
			int count = stmt.executeUpdate();
			
			if(count == 1) {
				result = true;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(stmt);
			
		}
		return result;
	}

	public Map<String, Object> getMachine(String machine_num) {
		Map<String, Object> machine = null;
		
		String sql = 
			"		select * from tb_machine "
			+ "	where		machine_num = ? ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, machine_num);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				machine = new HashMap<String, Object>();
				machine.put("machine_num",			machine_num);
				machine.put("machine_type", 		rs.getString("machine_type"));
				machine.put("install_date", 	    rs.getDate("install_date"));
				machine.put("installed_place", 		rs.getString("installed_place"));
				machine.put("detail_place",         rs.getString("detail_place"));
				machine.put("isDel", 			    rs.getString("isDel"));
				machine.put("location_type",        rs.getString("location_type"));
				
				machine.put("injectionTime_BT",     rs.getString("injectionTime_BT")); //부팅시 분사시간
				machine.put("unusedTime",        	rs.getString("unusedTime"));	   //미사용 설정시간
				machine.put("injectionTime_UUT",    rs.getString("injectionTime_UUT"));//미사용 분사시간
				machine.put("usedTimes",        	rs.getString("usedTimes"));  	   //사용시 세척사용횟수
				machine.put("injectionTime_UT",     rs.getString("injectionTime_UT")); //사용시 분사시간
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return machine;
	}

	public boolean updateMachine(String machine_num, String machine_type, String installed_place, String detail_place, String location_x, String location_y, String location_type,
								 int injectionTime_BT, int unusedTime, int injectionTime_UUT, int usedTimes, int injectionTime_UT) {
		boolean result = false;

		String sql = 
			"		update 	tb_machine "
			+ "	set 			machine_type = ?,    	"
			+ "					installed_place = ?, 	"
			+ "					detail_place = ?,    	"	
			+ "                 location_x = ?, 	 	"
			+ "                 location_y = ?, 	    "
			+ "                 location_type = ?,	    "
			+ "                 injectionTime_BT = ?,   "
			+ "                 unusedTime = ?,   		"
			+ "                 injectionTime_UUT = ?,  "
			+ "                 usedTimes = ?,   		"
			+ "                 injectionTime_UT = ?    "
			+ "	where		machine_num = ? 			";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, machine_type);
			stmt.setString(2, installed_place);
			stmt.setString(3, detail_place);
			stmt.setString(4, location_x);
			stmt.setString(5, location_y);
			stmt.setString(6, location_type);
			stmt.setInt(7, injectionTime_BT);
			stmt.setInt(8, unusedTime);
			stmt.setInt(9, injectionTime_UUT);
			stmt.setInt(10, usedTimes);
			stmt.setInt(11, injectionTime_UT);
			stmt.setString(12, machine_num);
			
			int count = stmt.executeUpdate();
			
			if(count == 1) {
				result = true;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(stmt);
			close(con);
		}
		
		return result;
	}

	public boolean deleteMachine(String machine_num) {
		boolean result = false;

		String sql = 
			"		update 	tb_machine "
			+ "	set 			isDel = 'Y' "
			+ "	where		machine_num = ? ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, machine_num);
			
			int count = stmt.executeUpdate();
			
			if(count == 1) {
				result = true;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(stmt);
			close(con);
		}
		
		return result;
	}
	
	public ArrayList<Map<String, Object>> searchMachine(String id, String division) {
		ArrayList<Map<String, Object>> machineList = new ArrayList<Map<String, Object>>();
		
		String sql = 
			"		select * from tb_machine "
			+ "	where		isDel = 'N' ";
		
		if("01".equals(division)) {
			sql += "	and				partner = ? ";
		}
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			
			if("01".equals(division)) {
				stmt.setString(1, id);
			}
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> machine = new HashMap<String, Object>();
				machine.put("machine_num", rs.getString("machine_num"));
				machine.put("install_date", rs.getDate("install_date"));
				machine.put("machine_type",rs.getString("machine_type"));
				machine.put("installed_place", rs.getString("installed_place"));
				
				machineList.add(machine);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return machineList;
	}

	public int getTotalRow() {
		int totalRow = 0;
		
		String sql = 
			"		select count(*) from tb_machine "
			+ "	where		isDel = 'N' ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			rs.next();
			
			totalRow = rs.getInt(1);
				
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return totalRow;
	}
	
	
	public ArrayList<Map<String, Object>> getMachineMarker(String partner, String division) {
		ArrayList<Map<String, Object>> markerList = new ArrayList<Map<String, Object>>();
		
		String sql = 
			"		select * from tb_machine "
			+ "	where		isDel = 'N' ";
		
		if("01".equals(division)) {
			sql += " and		partner = ? ";
		}
		
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			
			if("01".equals(division)) {
				stmt.setString(1, partner);
				
			} 
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> marker = new HashMap<String, Object>();
				marker.put("location_x", 			rs.getString("location_x"));
				marker.put("location_y", 			rs.getString("location_y"));
				marker.put("location_type",         rs.getString("location_type"));
				marker.put("detail_place", 			rs.getString("detail_place")); 
				markerList.add(marker);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return markerList;
	}
	
	public int getMachinetPK() {
		
		StringBuffer sb = new StringBuffer();

		int result = 0;
		
		sb.append("SELECT																			\n");
		sb.append("			   COUNT(*)																\n");
		sb.append("  FROM																			\n");
		sb.append("  	  tb_machine 	 															\n");
		sb.append( "WHERE 																			\n");
		sb.append("  	  SUBSTR(machine_num,1,10) = SUBSTR(DATE_FORMAT(now(), '%Y-%m-%d'),1,10)	\n");
		sb.append("  AND  isDel ='N'																\n");
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sb.toString());
			
			
			rs = stmt.executeQuery();
			
			while(rs.next()) 
			{
				result = rs.getInt(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return result;
	}
	
	public ArrayList<Map<String, Object>> getAllPopMachine(String id, String division) 
	{
		ArrayList<Map<String, Object>> machineList = new ArrayList<Map<String, Object>>();
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("SELECT																			\n");
		sb.append("			   *																	\n");
		sb.append("  FROM																			\n");
		sb.append("  	  tb_machine 	 															\n");
		sb.append( "WHERE 																			\n");
		sb.append("  	  isDel ='N'																\n");
		
		
		if("01".equals(division)) 
		{
			sb.append("  AND 	partner = ?															\n");
		}
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try 
		{
			con = ds.getConnection();
			stmt = con.prepareStatement(sb.toString());
			
			if("01".equals(division)) 
			{
				stmt.setString(1, id);
			} 
			
			rs = stmt.executeQuery();
			
			while(rs.next()) 
			{
				Map<String, Object> machine = new HashMap<String, Object>();
				machine.put("machine_num", 		rs.getString("machine_num"));
				machine.put("install_date",     rs.getDate("install_date"));
				machine.put("detail_place",     rs.getString("detail_place"));
				machine.put("machine_type",		rs.getString("machine_type"));
				machine.put("installed_place", 	rs.getString("installed_place"));
				
				machineList.add(machine);
			}
			
		} 
		catch(Exception e) 
		{
			e.printStackTrace();
		
		} 
		finally 
		{
			close(rs);
			close(stmt);
			close(con);
		}
		
		return machineList;
	}
	
	public int AllupdateMachine(String machine_num,int injectionTime_BT, int unusedTime, int injectionTime_UUT, int usedTimes, int injectionTime_UT) 
	{
		
		int result = 0;
		
		String sql = 
		"		update 	tb_machine "
		+ "	set 								 	"
		+ "                 injectionTime_BT = ?,   "
		+ "                 unusedTime = ?,   		"
		+ "                 injectionTime_UUT = ?,  "
		+ "                 usedTimes = ?,   		"
		+ "                 injectionTime_UT = ?    "
		+ "	where		machine_num = ? 			";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try 
		{
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, injectionTime_BT);
			stmt.setInt(2, unusedTime);
			stmt.setInt(3, injectionTime_UUT);
			stmt.setInt(4, usedTimes);
			stmt.setInt(5, injectionTime_UT);
			stmt.setString(6, machine_num);
			
			result += stmt.executeUpdate();
		
		} 
		catch(Exception e) 
		{
			e.printStackTrace();
		
		} 
		finally 
		{
			close(stmt);
			close(con);
		}
		
		return result;
	}
	
	public ArrayList<Map<String, Object>> getAllMachine(String id, String division) {
		ArrayList<Map<String, Object>> machineList = new ArrayList<Map<String, Object>>();
		
		String sql = 
			"		select * from tb_machine "
			+ "	where		isDel = 'N' ";
		
		if("01".equals(division)) {
			sql += " and		partner = ? ";
		}
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			
			if("01".equals(division)) {
				stmt.setString(1, id);
			} 
			
			System.out.println("getAllMachine sql:"+sql);
			
			rs = stmt.executeQuery();
			
			
//			stmt.setInt(1, injectionTime_BT);
//			stmt.setInt(2, unusedTime);
//			stmt.setInt(3, injectionTime_UUT);
//			stmt.setInt(4, usedTimes);
//			stmt.setInt(5, injectionTime_UT);
//			stmt.setString(6, machine_num);
			
			while(rs.next()) {
				Map<String, Object> machine = new HashMap<String, Object>();
				
				machine.put("injectionTime_BT", 	rs.getInt("injectionTime_BT"));
				machine.put("unusedTime", 			rs.getInt("unusedTime"));
				machine.put("injectionTime_BT", 	rs.getInt("injectionTime_BT"));
				machine.put("injectionTime_UUT", 	rs.getInt("injectionTime_UUT"));
				machine.put("usedTimes", 			rs.getInt("usedTimes"));
				machine.put("injectionTime_UT", 	rs.getInt("injectionTime_UT"));
				machine.put("machine_num", 			rs.getString("machine_num"));
				
				machineList.add(machine);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return machineList;
	}
	
	
}
