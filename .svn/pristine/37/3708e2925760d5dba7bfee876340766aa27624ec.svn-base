package kr.co.nao.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class FileDAO extends CommonDAO {

	public ArrayList<Map<String, Object>> getAllFile(int pageNum, String id, String division) {
		ArrayList<Map<String, Object>> contentsList = new ArrayList<Map<String, Object>>();

		String sql = 
			"		select * from tb_file "
			+ "	where		isDel = 'N' ";
		
		if("01".equals(division)) {
			sql += " and		member_id = ? ";
		}

		sql	+= "	order by file_num desc "
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
				Map<String, Object> content = new HashMap<String, Object>();
				content.put("file_num", 				rs.getInt("file_num"));
				content.put("file_name", 			rs.getString("file_name"));
				content.put("real_file_name", 	rs.getString("real_file_name"));
				content.put("add_date", 			rs.getDate("add_date"));
				content.put("member_id", 		rs.getString("member_id"));
				
				contentsList.add(content);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return contentsList;
	}

	public boolean addFile(String maskName, String real_file_name, String file_content, String id) {
		boolean result = false;

		String sql = 
			"		insert into tb_file (file_name, real_file_name, file_content, add_date, member_id, isDel) "
			+ "	values(?, ?, ?, curdate(), ?, 'N') ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, maskName);
			stmt.setString(2, real_file_name);
			stmt.setString(3, file_content);
			stmt.setString(4, id);
			
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

	public Map<String, Object> getFile(String fileNum) {
		Map<String, Object> file = null;
		
		String sql = 
			"		select * from tb_file "
			+ "	where		file_num = ? ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(fileNum));
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				file = new HashMap<String, Object>();
				file.put("file_num", fileNum);
				file.put("file_name", rs.getString("file_name"));
				file.put("real_file_name", rs.getString("real_file_name"));
				file.put("add_date", rs.getDate("add_date"));
				file.put("file_content", rs.getString("file_content"));
				file.put("member_id", rs.getString("member_id"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return file;
	}

	public boolean updateFile(String file_num, String file_content) {
		boolean result = false;

		String sql = 
			"		update tb_file "
			+ "	set			file_content = ? "
			+ "	where		file_num = ?";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, file_content);
			stmt.setInt(2, Integer.parseInt(file_num));
			
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

	public boolean deleteFile(String fileNum) {
		boolean result = false;

		String sql = 
			"		update tb_file "
			+ "	set			isDel = 'Y' "
			+ "	where		file_num = ?";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(fileNum));
			
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

	public ArrayList<Map<String, Object>> searchFile(String member_id, String division) {
		ArrayList<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
		
		String sql = 
				"		select * from tb_file "
				+ "	where		isDel = 'N' ";
		
		if("01".equals(division)) {
			sql	+= "	and				member_id = ? ";
		}
			
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
			
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			
			if("01".equals(division)) {
				stmt.setString(1, member_id);
			}
				
			rs = stmt.executeQuery();
				
			while(rs.next()) {
				Map<String, Object> content = new HashMap<String, Object>();
				content.put("file_num", 			rs.getInt("file_num"));
				content.put("file_name", 			rs.getString("file_name"));
				content.put("real_file_name", 	rs.getString("real_file_name"));
				content.put("add_date", 			rs.getDate("add_date"));
				content.put("member_id", 		rs.getString("member_id"));
				
				fileList.add(content);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return fileList;
	}
	
	public int getTotalRow() {
		int totalRow = 0;
		
		String sql = 
			"		select count(*) from tb_file "
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
