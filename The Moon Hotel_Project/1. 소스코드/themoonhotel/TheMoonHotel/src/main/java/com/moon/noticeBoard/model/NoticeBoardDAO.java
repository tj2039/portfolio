package com.moon.noticeBoard.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.spi.DirStateFactory.Result;

import com.moon.db.ConnectionPoolMgr;

public class NoticeBoardDAO {
		ConnectionPoolMgr pool = new ConnectionPoolMgr();
		
	public int insertNotice(NoticeBoardVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con=pool.getConnection();
			String sql = "insert into noticeBoard(noticeNo, guestNo, n_title, n_content)\r\n"
					+ "values(noticeboard_seq.nextval,?,?,?)";
			ps=con.prepareStatement(sql);
			 
			ps.setInt(1, vo.getGuestNo());
			ps.setString(2, vo.getN_title());
			ps.setString(3, vo.getN_content());
			
			int cnt = ps.executeUpdate();
			
			return cnt;
		} finally {
			pool.dbClose(ps, con);
		}
		
	}
	
	public List<NoticeBoardVO> selectAll(String condition, String keyword) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		List<NoticeBoardVO> list = new ArrayList<>();
		try {
			con = pool.getConnection();
			String sql = "select n.noticeNo, n.guestNo, n.n_title, n.n_regdate, n.n_content, g.userid"
							+" from NoticeBoard n, guest g";
			
			if(keyword!=null && !keyword.isEmpty()) {
				sql+=" where " + condition + " like '%' || ? || '%'"
						+" and n.guestno = g.guestno"
						+" order by noticeNo desc";
			}else {
				sql+=" where n.guestno = g.guestno "
						+" order by noticeNo desc";
			}
			ps= con.prepareStatement(sql);
			
			if(keyword!=null && !keyword.isEmpty()) {
				ps.setString(1, keyword);
			}
			
			rs=ps.executeQuery();
			while(rs.next()) {
				int noticeNo = rs.getInt("noticeNo");
				int guestNo = rs.getInt("guestNo");
				String n_title = rs.getString("n_title");
				Timestamp n_regdate = rs.getTimestamp("n_regdate");
				String n_content = rs.getString("n_content");
				String userid = rs.getString("userid");
				
				NoticeBoardVO vo = new NoticeBoardVO(noticeNo, guestNo, n_title, n_regdate, n_content, userid);
				list.add(vo);
			}
			System.out.println("글 전체 조회 결과 list.size="+list.size()
			+", 매개변수 condition="+condition+", keyword="+keyword);
			return list;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	public NoticeBoardVO selectByUserid(int guestNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		NoticeBoardVO vo = new NoticeBoardVO();
		
		try {
			con=pool.getConnection();
			String sql = "select * from noticeBoard where guestno = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, guestNo);
			
			rs= ps.executeQuery();
			
			if(rs.next()) {
				guestNo = rs.getInt("guestNo");
				vo.setGuestNo(guestNo);
			}
			return vo;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	public NoticeBoardVO selectByNo(int noticeNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		NoticeBoardVO vo = new NoticeBoardVO();
		
		try {
			con=pool.getConnection();
			String sql = "select * from noticeBoard where noticeNo = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, noticeNo);
			
			rs= ps.executeQuery();
			
			if(rs.next()) {
				int guestNo = rs.getInt("guestNo");
				String n_title = rs.getString("n_title");
				Timestamp n_regdate = rs.getTimestamp("n_regdate");
				String n_content = rs.getString("n_content");
				
				vo.setNoticeNo(noticeNo);
				vo.setGuestNo(guestNo);
				vo.setN_title(n_title);
				vo.setN_regdate(n_regdate);
				vo.setN_content(n_content);
			}
			return vo;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	public int updateNoticeBoard(NoticeBoardVO vo, int noticeNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
		con = pool.getConnection();
		String sql = "update noticeBoard"
				+ " set n_title =?, n_content=?"
				+ " where noticeNo = ?";
		ps=con.prepareStatement(sql);
		
		ps.setString(1, vo.getN_title());
		ps.setString(2, vo.getN_content());
		ps.setInt(3, vo.getNoticeNo());
		
		int cnt = ps.executeUpdate();
		System.out.println(cnt);
		return cnt;
		
		}finally {
			pool.dbClose(ps, con);
		}
	}
	//해당 게스트의 비밀번호와 일치하는지 확인을 해야함
	
	public int deleteNoticeBoard(int noticeNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = pool.getConnection();
			String sql = "delete from noticeBoard"
						+" where noticeNo =?";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, noticeNo);
			int cnt = ps.executeUpdate();
			
			return  cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public int updateN_count(int noticeNo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = pool.getConnection();
			String sql = "update noticeBoard"
					+ " setn_count = n_count+1"
					+ " where noticeNo=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, noticeNo);
			
			int cnt = ps.executeUpdate();
			
			return cnt;
			
		}finally {
			pool.dbClose(ps, con);
		}
		
	}
}
