package kr.co.nao.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ContentsDAO extends CommonDAO {

	public ArrayList<Map<String, Object>> getAllContents(int pageNum, String id, String division) {
		ArrayList<Map<String, Object>> contentsList = new ArrayList<Map<String, Object>>();

		String sql = 
			"		select * from tb_contents "
			+ "	where		isDel = 'N' ";
		
		if("01".equals(division)) {
			sql += " and		member_id = ? ";
		}		
		
		sql += "	order by contents_num desc "
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
				content.put("contents_num", 			rs.getInt("contents_num"));
				content.put("contents_title", 			rs.getString("contents_title"));
				content.put("contents_content", 	rs.getString("contents_content"));
				content.put("add_date", 					rs.getDate("add_date"));
				content.put("member_id", 				rs.getString("member_id"));
				
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

	public boolean addContents(String title, String content, String id, String advertiser_num) {
		boolean result = false;

		String sql = 
			"		insert into tb_contents (contents_title, contents_content, add_date, member_id, advertiser_num, isDel) "
			+ "	values(?, ?, curdate(), ?, ?, 'N')";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, title);
			stmt.setString(2, content);
			stmt.setString(3,  id);
			stmt.setInt(4, Integer.parseInt(advertiser_num));
			
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
	
	public boolean addLayer(String layerId, String width, String height, String x, String y, String background, String priority, int contentNum, String fileNum, String text, String persent) {
		boolean result = false;

		String sql = 
			"		insert into tb_layer (layer_id, layer_width, layer_height, layer_x, layer_y, layer_background, layer_priority, contents_num";
		
		if(fileNum != null && fileNum.length() > 0) {
			sql += ", layer_file_num";
		}
		
		if(text != null && text.length() > 0) {
			sql += ", layer_text";
		}
		
		sql += ") values(?, ?, ?, ?, ?, ?, ?, ?";

		if(fileNum != null && fileNum.length() > 0) {
			sql += ", ?";
		}
		
		if(text != null && text.length() > 0) {
			sql += ", ?";
		}

		sql += ")";
		
		System.out.println(sql);
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, layerId);
			stmt.setDouble(2, (Double.parseDouble(width) / Double.parseDouble(persent)));
			stmt.setDouble(3, (Double.parseDouble(height) / Double.parseDouble(persent)));
			stmt.setDouble(4, (Double.parseDouble(x) / Double.parseDouble(persent)));
			stmt.setDouble(5, (Double.parseDouble(y) / Double.parseDouble(persent)));
			stmt.setString(6,  background);
			stmt.setInt(7,  Integer.parseInt(priority));
			stmt.setInt(8,  contentNum);
			
			if(fileNum != null && fileNum.length() > 0) {
				stmt.setInt(9,  Integer.parseInt(fileNum));
				
				if(text != null && text.length() > 0) {
					stmt.setString(10,  text);
				}
			
			} else if(text != null && text.length() > 0) {
				stmt.setString(9,  text);
			}
			
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
	

	public Map<String, Object> getContents(String contentsNum) {
		Map<String, Object> contents = null;
		
		String sql = 
			"		select * from tb_contents c, tb_advertiser a "
			+ "	where		c.advertiser_num = a.advertiser_num "
			+ "	and				contents_num = ? ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(contentsNum));
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				contents = new HashMap<String, Object>();
				contents.put("contents_num", 		contentsNum);
				contents.put("contents_title", 			rs.getString("contents_title"));
				contents.put("contents_content", 	rs.getString("contents_content"));
				contents.put("add_date", 					rs.getDate("add_date"));
				contents.put("advertiser_num", 		rs.getInt("a.advertiser_num"));
				contents.put("advertiser_name", 	rs.getString("advertiser_name"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return contents;
	}

	public boolean updateContents(String num, String title, String content, String advertiser_num) {
		boolean result = false;

		String sql = 
			"		update tb_contents "
			+ "	set			contents_title = ?, contents_content = ?, advertiser_num = ? "
			+ "	where		contents_num = ?";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, title);
			stmt.setString(2, content);
			stmt.setInt(3, Integer.parseInt(advertiser_num));
			stmt.setInt(4, Integer.parseInt(num));
			
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

	public boolean deleteContents(String contentsNum) {
		boolean result = false;

		String sql = 
			"		update tb_contents "
			+ "	set			idDel = 'Y' "
			+ "	where		contents_num = ?";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(contentsNum));
			
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

	public int maxContentsNum() {
		int contentsNum = 0;

		String sql = 
			"		select max(contents_num) from tb_contents ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			rs.next();
			
			contentsNum = rs.getInt(1);
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return contentsNum;
	}

	public ArrayList<Map<String, Object>> getLayer(String contentsNum) {
		ArrayList<Map<String, Object>> layerList = new ArrayList<Map<String, Object>>();

		String sql = 
			"		select 		* "
			+ "	from 		tb_layer tbl, tb_file tbf "
			+ "	where		tbl.layer_file_num = tbf.file_num "
			+ "	and			contents_num = ? ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(contentsNum));
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> layer = new HashMap<String, Object>();
				
				layer.put("layer_num", 				rs.getInt("layer_num"));
				layer.put("layer_num", 				rs.getInt("layer_num"));
				layer.put("layer_id", 					rs.getString("layer_id"));
				layer.put("layer_width", 			rs.getInt("layer_width"));
				layer.put("layer_height", 			rs.getInt("layer_height"));
				layer.put("layer_x", 					rs.getInt("layer_x"));
				layer.put("layer_y", 					rs.getInt("layer_y"));
				layer.put("layer_background", rs.getString("layer_background"));
				layer.put("layer_priority", 		rs.getInt("layer_priority"));
				layer.put("contents_num", 		rs.getInt("contents_num"));
				layer.put("layer_file_num", 		rs.getInt("layer_file_num"));
				layer.put("file_name", 				rs.getString("file_name"));
				layer.put("layer_text", 				rs.getString("layer_text"));
				
				layerList.add(layer);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return layerList;
	}

	public ArrayList<Map<String, Object>> searchContents(String id, String division) {
		ArrayList<Map<String, Object>> contentsList = new ArrayList<Map<String, Object>>();
		
		String sql = 
				"		select * from tb_contents "
				+ "	where		isDel = 'N' ";
		
		if("01".equals(division)) {
			sql	+= "	and			member_id = ? ";
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
				Map<String, Object> content = new HashMap<String, Object>();
				content.put("contents_num", 			rs.getInt("contents_num"));
				content.put("contents_title", 			rs.getString("contents_title"));
				content.put("contents_content", 	rs.getString("contents_content"));
				content.put("add_date", 					rs.getDate("add_date"));
				content.put("member_id", 				rs.getString("member_id"));
				
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

	public void deleteLayer(String contentNum) {
		String sql = 
			"		delete from tb_layer "
			+ "	where		contents_num = ? ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, Integer.parseInt(contentNum));
			
			int count = stmt.executeUpdate();
			
			System.out.println(count + "개 삭제");
			
		} catch(Exception e) {
			e.printStackTrace();
			
		} finally {
			close(stmt);
			close(con);
		}
	}
	
	public int getTotalRow() {
		int totalRow = 0;
		
		String sql = 
			"		select count(*) from tb_contents "
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
