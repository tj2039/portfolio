package com.moon.noticeBoard.model;

import java.sql.Timestamp;

public class NoticeBoardVO {
	private int noticeNo;
	private int guestNo;
	private String n_title;
	private Timestamp n_regdate;
	private String n_content;
	private String userid;
	public NoticeBoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "NoticeBoardVO [noticeNo=" + noticeNo + ", guestNo=" + guestNo + ", n_title=" + n_title + ", n_regdate="
				+ n_regdate + ", n_content=" + n_content
				+ ", userid=" + userid + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString() + "]";
	}
	
	public NoticeBoardVO(int noticeNo, int guestNo, String n_title, Timestamp n_regdate, String n_content,
			String n_fileName, long n_fileSize) {
		super();
		this.noticeNo = noticeNo;
		this.guestNo = guestNo;
		this.n_title = n_title;
		this.n_regdate = n_regdate;
		this.n_content = n_content;
	}
	public NoticeBoardVO(int noticeNo, int guestNo, String n_title, Timestamp n_regdate, String n_content,
			String userid) {
		super();
		this.noticeNo = noticeNo;
		this.guestNo = guestNo;
		this.n_title = n_title;
		this.n_regdate = n_regdate;
		this.n_content = n_content;
		this.userid = userid;
	}
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public int getGuestNo() {
		return guestNo;
	}
	public void setGuestNo(int guestNo) {
		this.guestNo = guestNo;
	}
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	public Timestamp getN_regdate() {
		return n_regdate;
	}
	public void setN_regdate(Timestamp n_regdate) {
		this.n_regdate = n_regdate;
	}
	public String getN_content() {
		return n_content;
	}
	public void setN_content(String n_content) {
		this.n_content = n_content;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
}
