package com.moon.sales.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.moon.askBoard.model.AskBoardVO;
import com.moon.db.ConnectionPoolMgr;

import oracle.jdbc.pooling.Pool;

public class SalesDAO {
private ConnectionPoolMgr pool;
	
	public SalesDAO() {
		pool = new ConnectionPoolMgr();
	}
	
	
	
	public List<SalesVO2> salesByLocNo(String d1, String d2, String locName) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		List<SalesVO2> list = new ArrayList<>();
		
		try {
			con = pool.getConnection();
		
			String sql = "select locname, roomtype, roomprice, ci_date,"
					+ " count(*) as quantity, sum(roomprice) as salsePrice"
					+ " from v_room_sales"
					+ " where ci_date between ? and  ?";
			
					if(!locName.equals("all") ) {
						sql+= " and locname" +" =  ? ";
					}
					
					sql+= " group by locname, roomtype,  roomprice, ci_date"
							+ " order by locname, ci_date ";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, d1);
			ps.setString(2, d2);
			if(!locName.equals("all") ) {
				ps.setString(3, locName);
			}
				
			rs = ps.executeQuery();
				
			while(rs.next()) {
				String locname = rs.getString("locname");
				String roomtype = rs.getString("roomtype");
				int roomprice = rs.getInt("roomprice");
				String ci_date = rs.getString("ci_date");
				int quantity = rs.getInt("quantity");
				int salsePrice = rs.getInt("salsePrice");
				
				SalesVO2 vo 
					= new SalesVO2(locname, roomtype, ci_date, quantity, roomprice, salsePrice);
				list.add(vo);
			}
			
			System.out.println("객실 판매 매출 조회 결과 list.size: " + list.size());
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	
	
	public List<SalesVO2> salesByFac(String d1, String d2, String locName) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		List<SalesVO2> list = new ArrayList<>();
		
		try {
			con = pool.getConnection();
		
			String sql = "select locname, facname, "
					+ " sum(adultno) as fac_adultNo, sum(kidsno) as fac_kidsNo,"
					+ " sum(adultprice) as fac_Adult_Price, sum(kidsprice) as fac_kids_Price, ci_date"
					+ " from v_fac_sales"
					+ " where ci_date between ? and  ?";
			
					if(!locName.equals("all") ) {
						sql+= " and locname =  ? ";
					}
					
					sql+= " group by locname, facname, ci_date"
							+ " order by locname, ci_date ";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, d1);
			ps.setString(2, d2);
			if(!locName.equals("all") ) {
				ps.setString(3, locName);
			}
				
			rs = ps.executeQuery();
				
			while(rs.next()) {
				String locname = rs.getString("locname");
				String ci_date = rs.getString("ci_date");
				String facname = rs.getString("facname");
				int fac_adultNo = rs.getInt("fac_adultNo");
				int fac_kidsNo = rs.getInt("fac_kidsNo");
				int fac_Adult_Price = rs.getInt("fac_Adult_Price");
				int fac_kids_Price = rs.getInt("fac_kids_Price");

				

				
				SalesVO2 vo 
					= new SalesVO2(locname, ci_date, facname, fac_adultNo, fac_kidsNo, 
							fac_Adult_Price, fac_kids_Price);
				list.add(vo);
			}
			
			System.out.println("부대시설 판매 매출 조회 결과 list.size: " + list.size());
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
}
