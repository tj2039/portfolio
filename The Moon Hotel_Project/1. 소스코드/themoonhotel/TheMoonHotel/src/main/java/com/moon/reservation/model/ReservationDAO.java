package com.moon.reservation.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.moon.db.ConnectionPoolMgr;

public class ReservationDAO {
	private ConnectionPoolMgr pool;
	
	public ReservationDAO() {
		pool = new ConnectionPoolMgr();
	}
	
	//예약할 방의 정보를 매개변수로 받아서 reservation 테이블에 저장하는 메서드
	public int insertReservation (ReservationVO reservVo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = pool.getConnection();
			String sql = "insert into reservation(reservNo, guestNo, roomNo, adult, "
					+ " kids, ci_date, co_date, totalPrice)\r\n"
					+ "values(reservation_seq.nextval, ?, ?, ?, ?, "
					+ "?, ?, ?)";
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, reservVo.getGuestNo());
			ps.setInt(2, reservVo.getRoomNo());
			ps.setInt(3, reservVo.getAdult());
			ps.setInt(4, reservVo.getKids());
			ps.setString(5, reservVo.getCi_date());
			ps.setString(6, reservVo.getCo_date());
			ps.setInt(7, reservVo.getTotalPrice());
			
			int cnt = ps.executeUpdate();
			System.out.println("예약 성공 cnt = "+cnt+", 매개변수 reservVo = "+ reservVo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	//회원 번호를 매개 변수로 받아서 조회한 회원의 가장 최근 예약 번호를 찾는 메서드
	public int searchReservNo(int guestNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = pool.getConnection();
			String sql = "select reservNo from \r\n"
					+ "(select * from reservation order by reservNo desc)\r\n"
					+ "where rownum <=1 and guestNo=?";
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, guestNo);
			
			rs = ps.executeQuery();
			
			int reservNo = 0;
			
			if(rs.next()) {
				reservNo = rs.getInt("reservNo");
			}
			
			return reservNo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	//회원 번호를 매개 변수로 받아서 조회한 회원의 가장 최근 예약 정보 조회하는 메서드
	public ReservationVO searchReserv(int guestNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		ReservationVO reservVo = new ReservationVO();
		try {
			con = pool.getConnection();
			String sql = "select * from \r\n"
					+ "(select * from reservation order by reservNo desc)\r\n"
					+ "where rownum <=1 and guestNo=?";
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, guestNo);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				int reservNo = rs.getInt("reservNo");
				int roomNo = rs.getInt("roomNo");
				int adult = rs.getInt("adult");
				int kids = rs.getInt("kids");
				String ci_date = rs.getString("ci_date");
				String co_date = rs.getString("co_date");
				int totalPrice = rs.getInt("totalPrice");
				
				reservVo.setReservNo(reservNo);
				reservVo.setRoomNo(roomNo);
				reservVo.setAdult(adult);
				reservVo.setKids(kids);
				reservVo.setCi_date(ci_date);
				reservVo.setCo_date(co_date);
				reservVo.setTotalPrice(totalPrice);
			}
			return reservVo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//회원번호를 매개변수로 모든 예약 조회 검색하기
	public List<ReservationVO> selectAllReserv(int guestNo) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		List<ReservationVO> rlist = new ArrayList<>();
		try {
			con = pool.getConnection();
			
			String sql = "select * from Reservation where guestNo=? order by reservNo desc";
			ps = con.prepareStatement(sql);
			ps.setInt(1, guestNo);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int reservNo = rs.getInt("reservNo");
				int roomNo = rs.getInt("roomNo");
				int adult = rs.getInt("adult");
				int kids = rs.getInt("kids");
				String ci_date = rs.getString("ci_date");
				String co_date = rs.getString("co_date");
				int totalPrice = rs.getInt("totalPrice");
				
				ReservationVO reservVo = new ReservationVO(reservNo, guestNo, roomNo, adult, 
						kids, ci_date, co_date, totalPrice);
				rlist.add(reservVo);
			}
			return rlist;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//예약번호를 매개 변수로 받아서 예약 정보 조회하는 메서드
	public ReservationVO searchReservByNo(int reservNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		ReservationVO reservVo = new ReservationVO();
		try {
			con = pool.getConnection();
			String sql = "select * from Reservation \r\n"
					+ "where reservNo=?";
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, reservNo);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				int guestNo = rs.getInt("guestNo");
				int roomNo = rs.getInt("roomNo");
				int adult = rs.getInt("adult");
				int kids = rs.getInt("kids");
				String ci_date = rs.getString("ci_date");
				String co_date = rs.getString("co_date");
				int totalPrice = rs.getInt("totalPrice");
				
				reservVo.setGuestNo(guestNo);
				reservVo.setRoomNo(roomNo);
				reservVo.setAdult(adult);
				reservVo.setKids(kids);
				reservVo.setCi_date(ci_date);
				reservVo.setCo_date(co_date);
				reservVo.setTotalPrice(totalPrice);
			}
			return reservVo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	//=====관리자 기능
	//회원번호를 매개변수로 모든 예약 조회 검색하기
	public List<ReservationVO> selectAllReserv() throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		List<ReservationVO> rlist = new ArrayList<>();
		try {
			con = pool.getConnection();
			
			String sql = "select * from reservation "
						+ "order by reservNo desc";
			
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int reservNo = rs.getInt("reservNo");
				int guestNo = rs.getInt("guestNo");
				int roomNo = rs.getInt("roomNo");
				int adult = rs.getInt("adult");
				int kids = rs.getInt("kids");
				String ci_date = rs.getString("ci_date");
				String co_date = rs.getString("co_date");
				int totalPrice = rs.getInt("totalPrice");
				
				ReservationVO reservVo = new ReservationVO(reservNo, guestNo, roomNo, adult, 
						kids, ci_date, co_date, totalPrice);
				rlist.add(reservVo);
			}
			return rlist;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public List<ReservationVO> selectAllReserv(String startDate, String endDate) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		List<ReservationVO> rlist = new ArrayList<>();
		try {
			con = pool.getConnection();
			
			String sql = "select * from reservation\r\n"
					+ "where to_date(ci_date, 'yyyy-mm-dd') >= to_date(?, 'yyyy-mm-dd')"
					+ " and to_date(co_date, 'yyyy-mm-dd') <= to_date(?, 'yyyy-mm-dd')"
					+ " order by reservNo desc";
			
			ps = con.prepareStatement(sql);
			
			ps.setString(1, startDate);
			ps.setString(2, endDate);
						
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int reservNo = rs.getInt("reservNo");
				int guestNo = rs.getInt("guestNo");
				int roomNo = rs.getInt("roomNo");
				int adult = rs.getInt("adult");
				int kids = rs.getInt("kids");
				String ci_date = rs.getString("ci_date");
				String co_date = rs.getString("co_date");
				int totalPrice = rs.getInt("totalPrice");
				
				ReservationVO reservVo = new ReservationVO(reservNo, guestNo, roomNo, adult, 
						kids, ci_date, co_date, totalPrice);
				rlist.add(reservVo);
			}
			return rlist;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public List<ReservationVO> selectCondition(String condition) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		List<ReservationVO> rlist = new ArrayList<>();
		try {
			con = pool.getConnection();
			
			String sql = "select * from reservation "; //2022-05-08
			
			if(condition.equals("complete")) {
				sql += " where to_date(ci_date, 'YY-MM-DD') < sysdate-1"; 
			}else if(condition.equals("incomplete")) { //예정
				sql += " where to_date(ci_date, 'YY-MM-DD') > sysdate";
			}else if(condition.equals("ing")) {
				sql += " where to_date(ci_date, 'YY-MM-DD') <=sysdate and to_date(co_date, 'YY-MM-DD')>sysdate";			
			}
			
			sql += " order by reservNo desc";
			
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int reservNo = rs.getInt("reservNo");
				int guestNo = rs.getInt("guestNo");
				int roomNo = rs.getInt("roomNo");
				int adult = rs.getInt("adult");
				int kids = rs.getInt("kids");
				String ci_date = rs.getString("ci_date");
				String co_date = rs.getString("co_date");
				int totalPrice = rs.getInt("totalPrice");
				
				ReservationVO reservVo = new ReservationVO(reservNo, guestNo, roomNo, adult, 
						kids, ci_date, co_date, totalPrice);
				rlist.add(reservVo);
			}
			return rlist;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	//예약번호를 매개번수로 받아서 방을 취소하는 메서드
	public int deleteReserv(int reservNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = pool.getConnection();
			
			String sql = "delete from reservation\r\n"
						+ "where reservNo = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, reservNo);
			
			int cnt = ps.executeUpdate();
			
			System.out.println("취소된 예약 수: "+cnt+", 예약번호: "+reservNo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
}
