package com.moon.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionPoolMgr {
	private DataSource ds;
	
	public ConnectionPoolMgr() {
		try {
			Context ctx = new InitialContext();
			ds=(DataSource) ctx.lookup("java:comp/env/jdbc/oracledb");
			System.out.println("DataSource 얻어옴");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws SQLException {
		Connection con = ds.getConnection(); 
		
		System.out.println("db연결 여부 con="+con);
		return con;
	}
	
	public void dbClose(ResultSet rs, PreparedStatement ps,
			Connection con) throws SQLException {
		if(rs!=null) rs.close();
		if(ps!=null) ps.close();
		if(con!=null) con.close(); 
	}
	
	public void dbClose(PreparedStatement ps,
			Connection con) throws SQLException {
		if(ps!=null) ps.close();
		if(con!=null) con.close();
	}
}
