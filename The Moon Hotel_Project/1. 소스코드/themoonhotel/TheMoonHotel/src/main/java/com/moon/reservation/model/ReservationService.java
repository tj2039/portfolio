package com.moon.reservation.model;

import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

public class ReservationService {
	private ReservationDAO reservDao;
	
	public ReservationService() {
		reservDao = new ReservationDAO();
	}
	
	//예약할 방의 정보를 매개변수로 받아서 reservation 테이블에 저장하는 메서드
	public int insertReservation (ReservationVO reservVo) throws SQLException {
		return reservDao.insertReservation(reservVo);
	}
	
	//회원 번호를 매개 변수로 받아서 조회한 회원의 가장 최근 예약 번호를 찾는 메서드
	public int searchReservNo(int guestNo) throws SQLException {
		return reservDao.searchReservNo(guestNo);
	}
	
	//회원 번호를 매개 변수로 받아서 조회한 회원의 가장 최근 예약 정보 조회하는 메서드
	public ReservationVO searchReserv(int guestNo) throws SQLException {
		return reservDao.searchReserv(guestNo);
	}
	
	//회원번호를 매개변수로 모든 예약 조회 검색하기
	public List<ReservationVO> selectAllReserv(int guestNo) throws SQLException{
		return reservDao.selectAllReserv(guestNo);
	}
	
	//예약번호를 매개 변수로 받아서 예약 정보 조회하는 메서드
	public ReservationVO searchReservByNo(int reservNo) throws SQLException {
		return reservDao.searchReservByNo(reservNo);
	}
	
	//=====관리자 기능
	//회원번호를 매개변수로 모든 예약 조회 검색하기
	public List<ReservationVO> selectAllReserv() throws SQLException{
		return reservDao.selectAllReserv();
	}
	
	public List<ReservationVO> selectAllReserv(String startDate, String endDate) throws SQLException{
		return reservDao.selectAllReserv(startDate, endDate);
	}
	
	public List<ReservationVO> selectCondition(String condition) throws SQLException{
		return reservDao.selectCondition(condition);
	}
	
	//예약번호를 매개번수로 받아서 방을 취소하는 메서드
	public int deleteReserv(int reservNo) throws SQLException {
		return reservDao.deleteReserv(reservNo);
	}
}
