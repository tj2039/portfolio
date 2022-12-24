package com.moon.askBoard.model;

import java.sql.SQLException;
import java.util.List;

public class AskboardService {
	private AskBoardDAO dao;
	
	public AskboardService() {
		dao = new AskBoardDAO();
	}
	
	/**
	 * 문의글 등록
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public int insert(AskBoardVO vo) throws SQLException {
		return dao.insert(vo);
	}
	
	/**
	 * 관리자 - 전체 문의글 조회
	 * @param condition
	 * @param keyword
	 * @return
	 * @throws SQLException
	 */
	public List<AskBoardVO> selectAll(String condition, String keyword) throws SQLException{
		return dao.selectAll(condition, keyword);
	}
	
	/**
	 * 문의글 상세보기
	 * @param askno
	 * @return
	 * @throws SQLException
	 */
	public AskBoardVO selectByAskNo(int askno) throws SQLException {
		return dao.selectByAskNo(askno);
	}
	
	/**
	 * 문의글 수정
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public int updateAskboard(AskBoardVO vo) throws SQLException {
		return dao.updateAskboard(vo);
	}
	
	/**
	 * 문의글 삭제
	 * @param askno
	 * @return
	 * @throws SQLException
	 */
	public int deleteAskboard(int askno) throws SQLException {
		return dao.deleteAskboard(askno);
	}
	
	/**
	 * 회원별 문의글 조회
	 * @param guestno
	 * @return
	 * @throws SQLException
	 */
	public List<AskBoardVO> selectByGuestno(int guestno) throws SQLException{
		return dao.selectByGuestno(guestno);
	}
}
