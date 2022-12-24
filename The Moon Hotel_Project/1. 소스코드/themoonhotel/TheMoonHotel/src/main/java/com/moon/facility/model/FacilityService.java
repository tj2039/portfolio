package com.moon.facility.model;

import java.sql.SQLException;

public class FacilityService {
	private FacilityDAO facDao;
	
	public FacilityService(){
		facDao = new FacilityDAO();
	}
	//부대시설을 예약하기 위한 정보와 객실 예약 번호를 매개변수로 받아와서 부대시설 예약하는 메서드
	public int insertFacility(FacilityVO facVo, int reservNo) throws SQLException {
		return facDao.insertFacility(facVo, reservNo);
	}
	
	//객실 예약 정보를 받아 조식 예약 정보를 조회하는 메서드
	public FacilityVO selectBreakFastInfo (int reservNo) throws SQLException {
		return facDao.selectBreakFastInfo(reservNo);
	}
	
	// 객실 예약 정보를 받아 수영장 예약 정보를 조회하는 메서드
	public FacilityVO selectPoolInfo(int reservNo) throws SQLException {
		return facDao.selectPoolInfo(reservNo);
	}
	
	// 객실 예약 정보를 받아 사우나 예약 정보를 조회하는 메서드
	public FacilityVO selectSaunaInfo(int reservNo) throws SQLException {
		return facDao.selectPoolInfo(reservNo);
	}
	
	// 객실 예약 정보를 받아 헬스장 예약 정보를 조회하는 메서드
	public FacilityVO selectGymInfo(int reservNo) throws SQLException {
		return facDao.selectGymInfo(reservNo);
	}
	
	//예약번호를 매개 변수로 부대시설 예약 삭제하는 메서드
	public int deleteFacility(int reservNo) throws SQLException {
		return facDao.deleteFacility(reservNo);	
	}
}
