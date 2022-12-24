package com.moon.noticeBoard.model;

import java.sql.SQLException;
import java.util.List;

public class NoticeBoardService {
	private NoticeBoardDAO noticeBoardDAO;
	
	public NoticeBoardService() {
		noticeBoardDAO=new NoticeBoardDAO();
	}

	public int insertNotice(NoticeBoardVO vo) throws SQLException {
			return noticeBoardDAO.insertNotice(vo);
	}

	public List<NoticeBoardVO> selectAll(String condition, String keyword) throws SQLException {
		return noticeBoardDAO.selectAll(condition, keyword);
	}

	public NoticeBoardVO selectByNo(int noticeNo) throws SQLException {
		return noticeBoardDAO.selectByNo(noticeNo);
	}

	public int updateNoticeBoard(NoticeBoardVO vo,int noticeNo) throws SQLException {
		return noticeBoardDAO.updateNoticeBoard(vo, noticeNo);
	}

	public int deleteNoticeBoard(int noticeNo) throws SQLException {
		return noticeBoardDAO.deleteNoticeBoard(noticeNo);
	}

	public int updateN_count(int noticeNo) throws SQLException {
		return noticeBoardDAO.updateN_count(noticeNo);
	}

}
