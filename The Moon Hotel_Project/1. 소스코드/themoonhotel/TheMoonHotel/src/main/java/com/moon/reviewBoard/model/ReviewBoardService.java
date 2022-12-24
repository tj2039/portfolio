package com.moon.reviewBoard.model;

import java.sql.SQLException;
import java.util.List;



public class ReviewBoardService {
	private ReviewBoardDAO reviewBoardDAO;
	
	public ReviewBoardService() {
		reviewBoardDAO=new ReviewBoardDAO();
	}

	public int insertReview(ReviewBoardVO vo) throws SQLException {
			return reviewBoardDAO.insertReview(vo);
	}

	public List<ReviewBoardVO> selectAll(String condition, String keyword) throws SQLException {
		return reviewBoardDAO.selectAll(condition, keyword);
	}

	public ReviewBoardVO selectByNo(int reviewNo) throws SQLException {
		return reviewBoardDAO.selectByNo(reviewNo);
	}

	public int updatereviewBoard(ReviewBoardVO vo,int reviewNo) throws SQLException {
		return reviewBoardDAO.updatereviewBoard(vo, reviewNo);
	}

	public int deletereviewBoard(int reviewNo) throws SQLException {
		return reviewBoardDAO.deletereviewBoard(reviewNo);
	}
}
