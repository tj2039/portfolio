<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signUp_ok.jsp</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="guestVo" class="com.moon.guest.model.GuestVO" scope="page"></jsp:useBean>
<jsp:useBean id="guestSerivce" class="com.moon.guest.model.GuestSerivce" scope="page"></jsp:useBean>
	
<%	
	request.setCharacterEncoding("UTF-8");
	String name= request.getParameter("name");
	String userid= request.getParameter("userid");
	String pwd= request.getParameter("pwd");
	String email1= request.getParameter("email1");
	String email2= request.getParameter("email2");
	String tel1= request.getParameter("tel1");
	String tel2= request.getParameter("tel2");
	String tel3= request.getParameter("tel3");
	
	String tel="", email="";
	if(tel2!=null&&!tel2.isEmpty()&&tel3!=null&&!tel3.isEmpty()){
		tel=tel1+"-"+tel2+"-"+tel3;
	}
	
	if(email1!=null && !email1.isEmpty()){
			if(email2!=null && !email2.isEmpty()){
		   		email=email1+"@"+email2;
			}
	}
   	
	guestVo.setName(name);
	guestVo.setUserid(userid);
	guestVo.setPwd(pwd);
	guestVo.setEmail(email);
	guestVo.setTel(tel);
	
	String msg="회원가입 실패", url="signUp.jsp";
	try{
		int cnt = guestSerivce.insertGuest(guestVo);
		if(cnt>0){
			msg="회원가입되었습니다.";
			url="../index.jsp";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>
</body>
</html>