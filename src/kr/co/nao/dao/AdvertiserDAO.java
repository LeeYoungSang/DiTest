package kr.co.nao.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class AdvertiserDAO extends CommonDAO {

	public ArrayList<Map<String, Object>> getAllAdvertiser(int pageNum, String id, String division) {
		ArrayList<Map<String, Object>> advertiserList = new ArrayList<Map<String, Object>>();

		String sql = 
			"		select * from tb_advertiser "
			+ "	where		isDel = 'N' ";

			if("01".equals(division)) {
				sql += " and		member_id = ? ";
			}
		
			sql += "	order by advertiser_num desc "
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
				Map<String, Object> advertiser = new HashMap<String, Object>();
				advertiser.put("advertiser_num", 				rs.getInt("advertiser_num"));
				advertiser.put("advertiser_name", 			rs.getString("advertiser_name"));
				
				advertiserList.add(advertiser);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return advertiserList;
	}

	public boolean addAdvertiser(String advertiser_name, String advertiser_info, String member_id) {
		boolean result = false;

		String sql = 
				"		insert into tb_advertiser (advertiser_name, advertiser_info, member_id, isDel) "
				+ "	values (?, ?, ?, 'N') ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, advertiser_name);
			stmt.setString(2, advertiser_info);
			stmt.setString(3, member_id);
			
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

	public Map<String, Object> getAdvertiser(String advertiser_num, String id) {
		Map<String, Object> advertiser = null;

		String sql = 
			"		select * from tb_advertiser "
			+ "	where		advertiser_num = ? "
			+ "	and				member_id = ? ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(advertiser_num));
			stmt.setString(2, id);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				advertiser = new HashMap<String, Object>();
				advertiser.put("advertiser_num", 			rs.getInt("advertiser_num"));
				advertiser.put("advertiser_name", 		rs.getString("advertiser_name"));
				advertiser.put("advertiser_info", 			rs.getString("advertiser_info"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return advertiser;
	}

	public boolean updateAdvertiser(String advertiser_num, String advertiser_name, String advertiser_info) {
		boolean result = false;

		String sql = 
				"		update tb_advertiser "
				+ "	set		advertiser_name = ?, advertiser_info = ? "
				+ "	where	advertiser_num = ? ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, advertiser_name);
			stmt.setString(2, advertiser_info);
			stmt.setInt(3, Integer.parseInt(advertiser_num));
			
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

	public boolean deleteAdvertiser(String advertiser_num) {
		boolean result = false;

		String sql = 
				"		update tb_advertiser "
				+ "	set		isDel = 'Y' "
				+ "	where	advertiser_num = ? ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(advertiser_num));
			
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

	public ArrayList<Map<String, Object>> searchAdvertiser(String id, String division) {
		ArrayList<Map<String, Object>> advertiserList = new ArrayList<Map<String, Object>>();

		String sql = 
			"		select * from tb_advertiser "
			+ "	where		isDel = 'N' ";

			if("01".equals(division)) {
				sql += " and		member_id = ? ";
			}
		
		sql += "	order by advertiser_num desc ";
			
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
				Map<String, Object> advertiser = new HashMap<String, Object>();
				advertiser.put("advertiser_num", 				rs.getInt("advertiser_num"));
				advertiser.put("advertiser_name", 			rs.getString("advertiser_name"));
				
				advertiserList.add(advertiser);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return advertiserList;

	}
}
