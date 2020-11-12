package kr.co.nao.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class MemberDAO extends CommonDAO {
	public Map<String, Object> login(String id, String pw) {
		Map<String, Object> member = null;
		
		String sql = 
				" 		select 		* "
				+ "	from 		tb_member "
				+ "	where		id = ? "
				+ "	and 			pw = ? "
				+ "	and			isDel = 'N' ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
//			con = getConnection();
			
			
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, pw);
			
			System.out.println("stmt:"+stmt);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				member = new HashMap<String, Object>();
				member.put("id", 				rs.getString("id"));
				member.put("pw", 			rs.getString("pw"));
				member.put("name", 		rs.getString("name"));
				member.put("division", 	rs.getString("division"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return member;
	}

	public boolean addMember(String id, String pw, String name, String division) {
		boolean result = false;
		
		String sql = 
			"		insert into tb_member (id, pw, name, division)"
			+ "	values (?, ?, ?, ?) ";

		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, pw);
			stmt.setString(3, name);
			stmt.setString(4, division);
			
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

	public boolean updateMember(String id, String pw, String name, String address) {
		boolean result = false;
		
		String sql = 
			"		update	tb_member "
			+ "	set			pw = ?, name = ?, address = ? "
			+ "	where		id = ?";

		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, pw);
			stmt.setString(2, name);
			stmt.setString(3, address);
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

	public boolean deleteMember(String id) {
		boolean result = false;
		
		String sql = 
			"		update	tb_member "
			+ "	set			isDel = 'Y' "
			+ "	where		id = ?";

		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			
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

	public boolean idDupsCheck(String id) {
		boolean result = false;
		
		String sql = 
			"		select * from tb_member "
			+ "	where		id = ? ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = true;
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

	public ArrayList<Map<String, Object>> getPartnerList() {
		ArrayList<Map<String, Object>> partnerList = new ArrayList<Map<String, Object>>();
		
		String sql = 
				" 		select 		* "
				+ "	from 			tb_member "
				+ "	where		division = '01' "
				+ "	and				isDel = 'N' ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> partner = new HashMap<String, Object>();
				partner.put("id", 				rs.getString("id"));
				partner.put("name", 		rs.getString("name"));
				
				partnerList.add(partner);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return partnerList;
	}
}
