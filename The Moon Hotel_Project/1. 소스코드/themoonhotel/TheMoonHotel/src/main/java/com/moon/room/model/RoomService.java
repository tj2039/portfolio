package com.moon.room.model;

import java.sql.SQLException;
import java.util.List;

public class RoomService {
	private RoomDAO roomDao;
	
	public RoomService() {
		roomDao = new RoomDAO();
	}
	
	//지점명을 매개변수로 받아서 객실 정보 반환하는 메서드
	public List<RoomVO> selectRoom(String locName) throws SQLException{
		return roomDao.selectRoom(locName);
	}
	
	// 지점 정보, 객실 타입을 매개변수로 하여 객실 정보를 받환하는 매서드
	public RoomVO selectRoomByType(String locName, String roomType) throws SQLException {
		return roomDao.selectRoomByType(locName, roomType);
	}
	
	// 객실번호를 매개변수로 하여 객실 정보를 받환하는 매서드
	public RoomVO selectRoomByRoomNo(int roomNo) throws SQLException {
		return roomDao.selectRoomByRoomNo(roomNo);
	}
}
