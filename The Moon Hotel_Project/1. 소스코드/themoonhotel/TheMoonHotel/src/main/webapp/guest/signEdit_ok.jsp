<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="guestService" class="com.moon.guest.model.GuestSerivce" scope="session"></jsp:useBean>
<jsp:useBean id="guestVo" class="com.moon.guest.model.GuestVO" scope="page"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signEdit_ok.jsp</title>
</head>
<body>
<%
	//signEdit.jsp 에서 post방식으로 서브밋 됨
	request.setCharacterEncoding("utf-8");
	
	String userid= (String)session.getAttribute("userid");
	
	if(userid==null&&userid.isEmpty()){%>
		 alert("로그아웃 되었습니다.");
		 location.href="../login/login.jsp";
	<%}
	
	String pwd = request.getParameter("pwd");
	String email1=request.getParameter("email1");
	String email2=request.getParameter("email2");
	String tel1=request.getParameter("tel1");
	String tel2=request.getParameter("tel2");
	String tel3=request.getParameter("tel3");
	
	String tel="", email="";
	if(tel2!=null&&!tel2.isEmpty()&&tel3!=null&&!tel3.isEmpty()){
		tel=tel1+"-"+tel2+"-"+tel3;
	}
	if(email1!=null && !email1.isEmpty()){
			if(email2!=null && !email2.isEmpty()){
		   		email=email1+"@"+email2;
			}
   	}
	
	guestVo.setUserid(userid);
	guestVo.setPwd(pwd);
	guestVo.setEmail(email);
	guestVo.setTel(tel);
	
	String msg="회원정보 수정 중 문제 발생!", url="signEdit.jsp";	
	try{
		int cnt=guestService.updateGuset(guestVo);
		if(cnt>0){
	         msg="회원정보 수정 성공!";
	      }else{
	         msg="회원정보 수정 실패!";
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