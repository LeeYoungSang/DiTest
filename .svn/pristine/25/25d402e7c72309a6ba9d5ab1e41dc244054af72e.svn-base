package kr.co.nao.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ScheduleDAO extends CommonDAO {

	public ArrayList<Map<String, Object>> getAllSchedule(int pageNum, String id, String division) {
		ArrayList<Map<String, Object>> scheduleList = new ArrayList<Map<String, Object>>();

		String sql = 
			"		select * from tb_schedule "
			+ "	where		isDel = 'N' ";
					
		if("01".equals(division)) {
			sql += " and		member_id = ? ";
		}		
		
		sql	+=  "	order by schedule_date desc, schedule_start_time desc "
			+ "	limit			?, 10 ";
		
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
				Map<String, Object> schedule = new HashMap<String, Object>();
				schedule.put("num", 							rs.getInt("num"));
				schedule.put("schedule_date", 			rs.getDate("schedule_date"));
				schedule.put("schedule_start_time",	rs.getInt("schedule_start_time"));
				schedule.put("machine_num", 			rs.getString("machine_num"));
				schedule.put("contents_num", 			rs.getInt("contents_num"));
				
				scheduleList.add(schedule);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return scheduleList;
	}

	public boolean addSchedule(String schedule_date, String scheduleTime, String machineNum, String contentNum, String id) {
		boolean result = false;
		
		String sql = 
			"		insert into tb_schedule (schedule_date, schedule_start_time, machine_num, contents_num, member_id, isDel) "
			+ "	values(?, ?, ?, ?, ?, 'N')";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, schedule_date);
			stmt.setInt(2,  Integer.parseInt(scheduleTime));
			stmt.setString(3, machineNum);
			stmt.setInt(4,  Integer.parseInt(contentNum));
			stmt.setString(5, id);
			
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

	public Map<String, Object> getSchedule(String scheduleNum) {
		Map<String, Object> schedule = null;
		
		String sql = 
			"		select 	schedule_date, "
			+ "					schedule_start_time,"
			+ "					s.machine_num,"
			+ "					s.contents_num,"
			+ "					contents_title,  "
			+ "					machine_type "
			+ "	from		tb_schedule s, tb_contents c, tb_machine m"
			+ "	where		s.contents_num = c.contents_num "
			+ "	and			s.machine_num = m.machine_num "
			+ "	and			num = ? ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(scheduleNum));
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				schedule = new HashMap<String, Object>();
				schedule.put("schedule_num", 				scheduleNum);
				schedule.put("schedule_date", 				rs.getString("schedule_date"));
				schedule.put("schedule_start_time", 		rs.getInt("schedule_start_time"));
				schedule.put("machine_num", 				rs.getString("machine_num"));
				schedule.put("contents_num", 				rs.getInt("contents_num"));
				schedule.put("contents_title", 					rs.getString("contents_title"));
				schedule.put("machine_type", 				rs.getString("machine_type"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return schedule;
	}
	
	public boolean updateSchedule(String schedule_num, String schedule_date, String schedule_start_time, String machine_num, String contents_num) {
		boolean result = false;

		String sql = 
			"		update tb_schedule "
			+ "	set			schedule_date = ?, "
			+ "					schedule_start_time = ?, "
			+ "					machine_num = ?, "
			+ "					contents_num = ? "
			+ "	where		num = ?";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, schedule_date);
			stmt.setInt(2, Integer.parseInt(schedule_start_time));
			stmt.setString(3, machine_num);
			stmt.setInt(4, Integer.parseInt(contents_num));
			stmt.setInt(5, Integer.parseInt(schedule_num));
			
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

	public boolean deleteSchedule(String scheduleNum) {
		boolean result = false;

		String sql = 
			"		delete from tb_schedule "
			+ "	where		num = ?";

//		String sql = 
//				"		update tb_schedule "
//				+ "	set			isDel = 'Y' "
//				+ "	where		num = ?";

		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(scheduleNum));
			
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

	public ArrayList<Map<String, Object>> selectSchedule(String machine_num, String schedule_date, String schedule_start_time) {
		ArrayList<Map<String, Object>> reservationList = new ArrayList<Map<String, Object>>();
		
		String sql =  
			"		select * from tb_schedule "
			+ "	where		machine_num = ? "
			+ "	and			schedule_date = ? "
			+ "	and			schedule_start_time >= ? "
			+ "	and			schedule_start_time < ? "
			+ "	order by	schedule_start_time asc ";

		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			
			stmt.setString(1, machine_num);
			stmt.setString(2, schedule_date);

			int start_time = 0;
			
			if(schedule_start_time != null) {
				start_time = Integer.parseInt(schedule_start_time);
			}
				
			stmt.setInt(3, start_time);
			stmt.setInt(4, start_time + 3600);
			
			rs = stmt.executeQuery();

			while(rs.next()) {
				Map<String, Object> reservationTime = new HashMap<String, Object>();
				reservationTime.put("schedule_start_time", rs.getInt("schedule_start_time"));
				
				reservationList.add(reservationTime);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(stmt);
			close(con);
		}

		return reservationList;
	}

	public Map<String, Object> searchSchedule(String machine_num, String schedule_date, int time) {
		Map<String, Object> schedule = new HashMap<String, Object>();
		
		String sql = 
				"		select * "
				+ "	from 		tb_schedule "
				+ "	where		machine_num = ? "
				+ "	and			schedule_date = ? "
				+ "	and			schedule_start_time = (select 		min(schedule_start_time) "
				+ "															from 		tb_schedule "
				+ "															where		machine_num = ? "
				+ "															and			schedule_date = ? "
				+ "															and			schedule_start_time >= ? "
				+ "															and			schedule_start_time < ? )";

		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
			
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, machine_num);
			stmt.setString(2, schedule_date);
			stmt.setString(3, machine_num);
			stmt.setString(4, schedule_date);
			stmt.setInt(5, time);
			stmt.setInt(6, time + 15);
				
			rs = stmt.executeQuery();

			if(rs.next()) {
				schedule.put("schedule_start_time", rs.getInt("schedule_start_time"));
				schedule.put("contents_num", rs.getInt("contents_num"));
			}
				
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(stmt);
			close(con);
		}
		
		return schedule;
	}

	public int getTotalRow() {
		int totalRow = 0;
		
		String sql = 
			"		select count(*) from tb_schedule "
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

	public int dupsSchedule(String fromDate, String toDate, String startTime, String endTime, String termTime, String machineNum) {
		int dupsCount = 0;
	
		int start = Integer.parseInt(startTime) * 3600;
		int end = Integer.parseInt(endTime) * 3600;
		int term = Integer.parseInt(termTime);
		
		String data = "";
		boolean isFirst = true;
		
		for(int i = start; i < end; i = i + term ) {
			
			if(isFirst) {
				data += i;
				isFirst = false;
				
			} else {
				data += ", " + i;
			}
		}

		String sql = 
				"		select count(*) from tb_schedule "
				+ "	where		schedule_date >= ? "
				+ "	and				schedule_date <= ? "
				+ "	and				machine_num = ? "
				+ "	and				schedule_start_time in (" + data + ") "
				+ "	and				isDel = 'N' ";
		
		System.out.println(sql);

		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, fromDate);
			stmt.setString(2, toDate);
			stmt.setString(3, machineNum);
			
			rs = stmt.executeQuery();
			rs.next();
			
			dupsCount = rs.getInt(1);
				
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}

		return dupsCount;
	}
	
	// 오늘의 schedule 정보
	public ArrayList<Map<String, Object>> getTodaySchedule(String machine_num) {
		ArrayList<Map<String, Object>> scheduleList = new ArrayList<Map<String, Object>>();
		
		String sql = 
			"		SELECT s.schedule_start_time, c.contents_num, layer_id, file_name "
			+ "	FROM tb_schedule s, tb_contents c, tb_layer l, tb_file f "
			+ "	WHERE c.contents_num = l.contents_num  "
			+ "	AND l.layer_file_num = f.file_num "
			+ "	AND s.contents_num = c.contents_num "
			+ "	AND schedule_date = CURDATE() "
			+ "	AND machine_num = ?"
			+ "	ORDER BY schedule_start_time ASC";
			
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, machine_num);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> schedule = new HashMap<String, Object>();
				schedule.put("schedule_start_time", rs.getInt("schedule_start_time"));
				schedule.put("contents_num", rs.getInt("contents_num"));
				schedule.put("layer_id", rs.getString("layer_id"));
				schedule.put("file_name", rs.getString("file_name"));
				
				scheduleList.add(schedule);
			}			
				
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
			
		return scheduleList;
	}
}
