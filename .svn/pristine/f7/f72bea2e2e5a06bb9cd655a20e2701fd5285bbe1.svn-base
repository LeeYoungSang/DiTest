package kr.co.nao.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class NoticeDAO extends CommonDAO {

	public ArrayList<Map<String, Object>> getAllNotice(int pageNum) {
		ArrayList<Map<String, Object>> noticeList = new ArrayList<Map<String, Object>>();

		String sql = 
			"		select * from tb_notice "
			+ "	where		isDel = 'N' "
			+ "	order by	notice_num desc "
			+ "	limit			?, 10" ;
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, getStartNum(pageNum));
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> notice = new HashMap<String, Object>();
				notice.put("notice_num", 	rs.getInt("notice_num"));
				notice.put("notice_title", 	rs.getString("notice_title"));
				notice.put("add_date", 		rs.getDate("add_date"));
				notice.put("member_id", 	rs.getString("member_id"));
				notice.put("hit", 					rs.getInt("hit"));
				
				noticeList.add(notice);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return noticeList;
	}

	public Map<String, Object> getNotice(String noticeNum) {
		Map<String, Object> notice = null;

		String sql = 
			"		select * from tb_notice "
			+ "	where		notice_num = ? ";

		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(noticeNum));
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				notice = new HashMap<String, Object>();
				notice.put("notice_num", 			rs.getInt("notice_num"));
				notice.put("notice_title", 			rs.getString("notice_title"));
				notice.put("notice_content", 	rs.getString("notice_content"));
				notice.put("add_date", 				rs.getDate("add_date"));
				notice.put("member_id", 			rs.getString("member_id"));
				notice.put("hit", 							rs.getInt("hit"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return notice;
	}

	public boolean addNotice(String notice_title, String notice_content, String id) {
		boolean result = false;
		
		String sql = 
			"		insert into tb_notice (notice_title, notice_content, add_date, member_id, hit, isDel) "
			+ "	values(?, ?, curdate(), ?, 0, 'N')";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, notice_title);
			stmt.setString(2, notice_content);
			stmt.setString(3, id);
			
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

	public boolean updateNotice(String noticeNum, String noticeTitle, String noticeContent) {
		boolean result = false;
		
		String sql = 
			"		update 	tb_notice "
			+ "	set			notice_title = ?,  notice_content = ? "
			+ "	where		notice_num = ?";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, noticeTitle);
			stmt.setString(2, noticeContent);
			stmt.setInt(3, Integer.parseInt(noticeNum));
			
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

	public boolean deleteNotice(String noticeNum) {
		boolean result = false;
		
		String sql = 
			"		update 	tb_notice "
			+ "	set			isDel = 'Y' "
			+ "	where		notice_num = ?";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(noticeNum));
			
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

	public boolean hitUpdate(String notice_num) {
		boolean result = false;
		
		String sql = 
			"		update 	tb_notice "
			+ "	set			hit = hit + 1 "
			+ "	where		notice_num = ?";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(notice_num));
			
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
	
	public int getTotalRow() {
		int totalRow = 0;
		
		String sql = 
			"		select count(*) from tb_notice "
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
	
}
