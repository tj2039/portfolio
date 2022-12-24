package com.moon.room.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.moon.db.ConnectionPoolMgr;

public class RoomDAO {
private ConnectionPoolMgr pool;
	
	public RoomDAO() {
		pool = new ConnectionPoolMgr();
	}
	
	//지점명을 매개변수로 받아서 객실 정보 반환하는 메서드
	public List<RoomVO> selectRoom(String locName) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		List<RoomVO> rlist = new ArrayList<>();
		try {
			con = pool.getConnection();
			
			String sql = "select * from room where locName=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, locName);
			
			rs = ps.executeQuery();
			
			RoomVO roomVo = null;
			while(rs.next()) {
				int roomNo = rs.getInt("roomNo");
				String roomType = rs.getString("roomType");
				int roomPrice = rs.getInt("roomPrice");
				String roomImage = rs.getString("roomImage");
				int roomCount = rs.getInt("roomCount");
				
				roomVo = new RoomVO(roomNo, locName, roomType, roomPrice, roomImage, roomCount);
				rlist.add(roomVo);
			}
			System.out.println("룸 전체 조회 결과 rlist.size="+rlist.size());
			
			return rlist;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	// 지점 정보, 객실 타입을 매개변수로 하여 객실 정보를 받환하는 매서드
	public RoomVO selectRoomByType(String locName, String roomType) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		RoomVO roomVo = new RoomVO();
		try {
			con = pool.getConnection();
			
			String sql = "select * from room\r\n"
					+ "where locName=? and roomType=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, locName);
			ps.setString(2, roomType);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				int roomNo = rs.getInt("roomNo");
				int roomPrice = rs.getInt("roomPrice");
				String roomImage = rs.getString("roomImage");
				int roomCount = rs.getInt("roomCount");
				
				roomVo.setRoomNo(roomNo);
				roomVo.setLocName(locName);
				roomVo.setRoomType(roomType);
				roomVo.setRoomPrice(roomPrice);
				roomVo.setRoomImage(roomImage);
				roomVo.setRoomCount(roomCount);
			}
			return roomVo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	// 객실번호를 매개변수로 하여 객실 정보를 받환하는 매서드
	public RoomVO selectRoomByRoomNo(int roomNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		RoomVO roomVo = new RoomVO();
		try {
			con = pool.getConnection();
			
			String sql = "select * from room where roomNo = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, roomNo);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				String locName = rs.getString("locName");
				String roomType = rs.getString("roomType");
				int roomPrice = rs.getInt("roomPrice");
				String roomImage = rs.getString("roomImage");
				int roomCount = rs.getInt("roomCount");
				
				roomVo.setRoomNo(roomNo);
				roomVo.setLocName(locName);
				roomVo.setRoomType(roomType);
				roomVo.setRoomPrice(roomPrice);
				roomVo.setRoomImage(roomImage);
				roomVo.setRoomCount(roomCount);
			}
			return roomVo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
}
