package kr.co.nao.dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class CommonDAO {
	public DataSource ds;
	
	public CommonDAO() {
		try {
			Context ct = new InitialContext();
			
//			ds = (DataSource)ct.lookup("java:comp/env/oracle");
			ds = (DataSource)ct.lookup("java:comp/env/jdbc/mysql"); 
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void close(Connection con) {
		if(con != null) {
			try {
				con.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void close(Statement stmt) {
		if(stmt != null) {
			try {
				stmt.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void close(ResultSet rs) {
		if(rs != null) {
			try {
				rs.close();
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public int getStartNum(int pageNum) {
		return ((pageNum - 1) * 10);
	}
	
	
	public Connection getConnection () 
	{
		Connection con = null;
		
		String url;
		String id;
		String pw;
		
		System.out.println("@@@타는지 확인");
		
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			
			url = "jdbc:mysql://kh0917.cafe24.com:3306/kh0917";
			id  = "kh0917";
			pw  = "parThree!";
			
			con = DriverManager.getConnection("jdbc:mysql://kh0917.cafe24.com:3306/kh0917", "kh0917", "parThree!");
//			con = DriverManager.getConnection(url,id,pw);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return con;
	}
	
	
	
	
}
