<%@page import="com.moon.guest.model.GuestSerivce"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guestEdit_pwdChk_ok.jsp</title>
</head>
<body>
<jsp:useBean id="guestService" class="com.moon.guest.model.GuestSerivce" scope="session"></jsp:useBean>
<jsp:useBean id="guestVo" class="com.moon.guest.model.GuestVO" scope="page"></jsp:useBean>
<%
	//memberOut.jsp에서 post방식으로 서브밋 됨
	request.setCharacterEncoding("utf-8");
	
	//입력 파라미터 읽어오기(세션으로 usesrid 불러오기)
	String userid= (String)session.getAttribute("userid");
	
	if(userid==null&&userid.isEmpty()){%>
		 alert("로그아웃 되었습니다.");
		 location.href="memberOut.jsp";
	<%}
	
	String pwd = request.getParameter("pwd");
	
	//db작업 - 비밀번호 확인
	try{
		int result= guestService.loginCheck(userid, pwd);
		if(result==GuestSerivce.EXIST_ID){
			
			//결과처리- 비밀번호 확인 
			response.sendRedirect("signEdit.jsp");
		
		
		}else{%>
			<script type="text/javascript">
				alert("비밀번호를 확인하세요");
				location.href="guestEdit_pwdChk.jsp";
			</script>	
	<%	}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
%>
</body>
</html>