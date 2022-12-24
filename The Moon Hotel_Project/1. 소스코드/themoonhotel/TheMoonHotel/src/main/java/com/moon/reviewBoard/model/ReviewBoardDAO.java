package com.moon.reviewBoard.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.spi.DirStateFactory.Result;

import com.moon.db.ConnectionPoolMgr;

public class ReviewBoardDAO {
	ConnectionPoolMgr pool = new ConnectionPoolMgr();

	public int insertReview(ReviewBoardVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = pool.getConnection();
			String sql = "insert into reviewBoard(reviewNo, guestNo, r_title, r_content)\r\n"
					+ "values(reviewboard_seq.nextval,?,?,?)";
			ps = con.prepareStatement(sql);

			ps.setInt(1, vo.getGuestNo());
			ps.setString(2, vo.getR_title());
			ps.setString(3, vo.getR_content());

			int cnt = ps.executeUpdate();

			return cnt;
		} finally {
			pool.dbClose(ps, con);
		}

	}

	public List<ReviewBoardVO> selectAll(String condition, String keyword) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		List<ReviewBoardVO> list = new ArrayList<>();
		try {
			con = pool.getConnection();
			String sql = "select r.reviewNo, r.guestNo, r.r_title, r.r_regdate, r.r_content, g.userid"
					+ " from ReviewBoard r, guest g";

			if (keyword != null && !keyword.isEmpty()) {
				sql += " where " + condition + " like '%' || ? || '%'" + " and r.guestno = g.guestno"
						+ " order by reviewNo desc";
			} else {
				sql += " where r.guestno = g.guestno " + " order by reviewNo desc";
			}
			ps = con.prepareStatement(sql);

			if (keyword != null && !keyword.isEmpty()) {
				ps.setString(1, keyword);
			}

			rs = ps.executeQuery();
			while (rs.next()) {
				int reviewNo = rs.getInt("reviewNo");
				int guestNo = rs.getInt("guestNo");
				String r_title = rs.getString("r_title");
				Timestamp r_regdate = rs.getTimestamp("r_regdate");
				String r_content = rs.getString("r_content");
				String userid = rs.getString("userid");

				ReviewBoardVO vo = new ReviewBoardVO(reviewNo, guestNo, r_title, r_regdate, r_content, userid);
				list.add(vo);
			}
			System.out.println(
					"글 전체 조회 결과 list.size=" + list.size() + ", 매개변수 condition=" + condition + ", keyword=" + keyword);
			return list;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}

	public ReviewBoardVO selectByUserid(int guestNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		ReviewBoardVO vo = new ReviewBoardVO();

		try {
			con = pool.getConnection();
			String sql = "select * from reviewBoard where guestno = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, guestNo);

			rs = ps.executeQuery();

			if (rs.next()) {
				guestNo = rs.getInt("guestNo");
				vo.setGuestNo(guestNo);
			}
			return vo;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}

	public ReviewBoardVO selectByNo(int reviewNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		ReviewBoardVO vo = new ReviewBoardVO();

		try {
			con = pool.getConnection();
			String sql = "select * from reviewBoard where reviewNo = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, reviewNo);

			rs = ps.executeQuery();

			if (rs.next()) {
				int guestNo = rs.getInt("guestNo");
				String r_title = rs.getString("r_title");
				Timestamp r_regdate = rs.getTimestamp("r_regdate");
				String r_content = rs.getString("r_content");

				vo.setReviewNo(reviewNo);
				vo.setGuestNo(guestNo);
				vo.setR_title(r_title);
				vo.setR_regdate(r_regdate);
				vo.setR_content(r_content);
			}
			return vo;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}

	public int updatereviewBoard(ReviewBoardVO vo, int reviewNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = pool.getConnection();
			String sql = "update reviewBoard" + " set r_title =?, r_content=?" + " where reviewNo = ?";
			ps = con.prepareStatement(sql);

			ps.setString(1, vo.getR_title());
			ps.setString(2, vo.getR_content());
			ps.setInt(3, vo.getReviewNo());

			int cnt = ps.executeUpdate();
			System.out.println(cnt);
			return cnt;

		} finally {
			pool.dbClose(ps, con);
		}
	}
	// 해당 게스트의 비밀번호와 일치하는지 확인을 해야함

	public int deletereviewBoard(int reviewNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = pool.getConnection();
			String sql = "delete from reviewBoard" + " where reviewNo =?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, reviewNo);
			int cnt = ps.executeUpdate();

			return cnt;
		} finally {
			pool.dbClose(ps, con);
		}
	}
}
