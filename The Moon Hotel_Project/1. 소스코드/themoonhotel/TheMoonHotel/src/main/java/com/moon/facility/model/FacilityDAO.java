package com.moon.facility.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.moon.db.ConnectionPoolMgr;

public class FacilityDAO {
	private ConnectionPoolMgr pool;

	public FacilityDAO() {
		pool = new ConnectionPoolMgr();
	}

	// 부대시설을 예약하기 위한 정보와 객실 예약 번호를 매개변수로 받아와서 부대시설 예약하는 메서드
	public int insertFacility(FacilityVO facVo, int reservNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = pool.getConnection();

			String sql = "insert into facility(facNo, reservNo, facInfoNo, adultNo, kidsNo)\r\n"
					+ "values(facility_seq.nextval, ?, ?, ?, ?)";
			ps = con.prepareStatement(sql);

			ps.setInt(1, reservNo);
			ps.setInt(2, facVo.getFacInfoNo());
			ps.setInt(3, facVo.getAdultNo());
			ps.setInt(4, facVo.getKidsNo());

			int cnt = ps.executeUpdate();

			return cnt;
		} finally {
			pool.dbClose(ps, con);
		}
	}

	// 객실 예약 정보를 받아 조식 예약 정보를 조회하는 메서드
	public FacilityVO selectBreakFastInfo(int reservNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		FacilityVO facVo = new FacilityVO();
		try {
			con = pool.getConnection();

			String sql = "select * from facility \r\n" 
					+ "where reservNo=? and facinfoNo=1";
			ps = con.prepareStatement(sql);
			ps.setInt(1, reservNo);

			rs = ps.executeQuery();

			if (rs.next()) {
				int facNo = rs.getInt("facNo");
				int adultNo = rs.getInt("adultNo");
				int kidsNo = rs.getInt("kidsNo");

				facVo.setFacNo(facNo);
				facVo.setAdultNo(adultNo);
				facVo.setKidsNo(kidsNo);
			}
			return facVo;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}

	// 객실 예약 정보를 받아 수영장 예약 정보를 조회하는 메서드
	public FacilityVO selectPoolInfo(int reservNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		FacilityVO facVo = new FacilityVO();
		try {
			con = pool.getConnection();

			String sql = "select * from facility \r\n" 
						+ "where reservNo=? and facinfoNo=2";
			ps = con.prepareStatement(sql);
			ps.setInt(1, reservNo);

			rs = ps.executeQuery();

			if (rs.next()) {
				int facNo = rs.getInt("facNo");
				int adultNo = rs.getInt("adultNo");
				int kidsNo = rs.getInt("kidsNo");

				facVo.setFacNo(facNo);
				facVo.setAdultNo(adultNo);
				facVo.setKidsNo(kidsNo);
			}
			return facVo;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	// 객실 예약 정보를 받아 사우나 예약 정보를 조회하는 메서드
	public FacilityVO selectSaunaInfo(int reservNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		FacilityVO facVo = new FacilityVO();
		try {
			con = pool.getConnection();

			String sql = "select * from facility \r\n" 
						+ "where reservNo=? and facinfoNo=3";
			ps = con.prepareStatement(sql);
			ps.setInt(1, reservNo);

			rs = ps.executeQuery();
				
			if (rs.next()) {
				int facNo = rs.getInt("facNo");
				int adultNo = rs.getInt("adultNo");
				int kidsNo = rs.getInt("kidsNo");

				facVo.setFacNo(facNo);
				facVo.setAdultNo(adultNo);
				facVo.setKidsNo(kidsNo);
			}
			return facVo;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	// 객실 예약 정보를 받아 헬스장 예약 정보를 조회하는 메서드
	public FacilityVO selectGymInfo(int reservNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		FacilityVO facVo = new FacilityVO();
		try {
			con = pool.getConnection();

			String sql = "select * from facility \r\n" 
						+ "where reservNo=? and facinfoNo=3";
			ps = con.prepareStatement(sql);
			ps.setInt(1, reservNo);

			rs = ps.executeQuery();
				
			if(rs.next()){
				int facNo = rs.getInt("facNo");
				int adultNo = rs.getInt("adultNo");
				int kidsNo = rs.getInt("kidsNo");

				facVo.setFacNo(facNo);
				facVo.setAdultNo(adultNo);
				facVo.setKidsNo(kidsNo);
			}
			return facVo;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//예약번호를 매개 변수로 부대시설 예약 삭제하는 메서드
	public int deleteFacility(int reservNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = pool.getConnection();
			
			String sql = "delete from facility\r\n"
						+ "where reservNo = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, reservNo);
			
			int cnt = ps.executeUpdate();
			
			System.out.println("부대시설 예약 취소 수: "+cnt+", 예약번호"+reservNo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
}
