package imsi;

import java.sql.DriverManager;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class DBSetting {

	public static void main(String[] args) {
		String sql = " INSERT INTO tb_schedule (schedule_date, schedule_start_time, machine_num, member_id, contents_num, isDel)";
		sql += " VALUES ('2020-08-07', ?, '2020-01-13-002', 'exam', ?, 'N')";
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://kh0917.cafe24.com:3306/kh0917?characterEncoding=UTF-8", "kh0917", "parThree!");
			stmt = con.prepareStatement(sql);
			boolean isFirst = true;
			
			for(int i = 0; i < 86400; i = i + 15) {
				stmt.setInt(1, i);
				stmt.setInt(2,  23);
				
//				if(isFirst) {
//					stmt.setInt(2, 4);
//					isFirst = !isFirst;
//				} else {
//					stmt.setInt(2,  9);
//					isFirst = !isFirst;
//				}

				stmt.executeUpdate();
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			try {
				stmt.close();
				con.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
 		}
		
		System.out.println("complete.......");

	}

}
