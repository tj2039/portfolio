package com.spring.moon.askBoard.model;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AskboardServiceImp implements AskboardService{
	@Autowired
	AskBoardDAO dao;
	

	/**
	 * 문의글 등록
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	@Override
	public int insert(AskBoardVO vo){
		return dao.insert(vo);
	}
	
	/**
	 * 관리자 - 전체 문의글 조회
	 * @param condition
	 * @param keyword
	 * @return
	 * @throws SQLException
	 */
	@Override
	public List<AskBoardVO> selectAll(String condition, String keyword){
		return dao.selectAll(condition, keyword);
	}
	
	/**
	 * 문의글 상세보기
	 * @param askNo
	 * @return
	 * @throws SQLException
	 */
	@Override
	public AskBoardVO selectByAskNo(int askNo) {
		return dao.selectByAskNo(askNo);
	}
	
	/**
	 * 문의글 수정
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	@Override
	public int updateAskboard(AskBoardVO vo){
		return dao.updateAskboard(vo);
	}
	
	/**
	 * 문의글 삭제
	 * @param askno
	 * @return
	 * @throws SQLException
	 */
	@Override
	public int deleteAskboard(int askNo){
		return dao.deleteAskboard(askNo);
	}
	
	/**
	 * 회원별 문의글 조회
	 * @param guestno
	 * @return
	 * @throws SQLException
	 */
	@Override
	public List<AskBoardVO> selectByGuestno(int guestno){
		return dao.selectByGuestno(guestno);
	}
}
