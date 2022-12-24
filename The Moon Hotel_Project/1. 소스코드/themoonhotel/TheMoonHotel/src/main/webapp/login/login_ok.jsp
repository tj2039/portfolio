<%@page import="com.moon.guest.model.GuestSerivce"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>login_ok.jsp</title>
</head>
<body>
<jsp:useBean id="guestService" class="com.moon.guest.model.GuestSerivce" scope="session"></jsp:useBean>

<!-- 로그인 처리 -->
<%
	//login.jsp에서 post 방식으로 서브밋
	request.getParameter("utf-8");
	//1
	String userid=request.getParameter("userid");
	String pwd=request.getParameter("pwd");
	String chkSave=request.getParameter("chkSave");
	//2
	String msg="로그인 처리 실패", url="login.jsp";
	try{
		int result=guestService.loginCheck(userid,pwd);
		
		if(result==GuestSerivce.LOGIN_OK){
			//session에 저장
			session.setAttribute("userid", userid);
			//쿠키에 저장 - 아이디 저장하기가 체크되었다면
			Cookie ck =new Cookie("ck_userid",userid);
			ck.setPath("/");
			
			//체크하면 on, 체크 안하면 null
			if(chkSave!=null){//체크된 경우
				ck.setMaxAge(90*24*60*60);//쿠키 유지시간 : 90일
				response.addCookie(ck);
			}else{	//체크 안한 경우
				ck.setMaxAge(0);//쿠키 삭제
				response.addCookie(ck);
			}
			msg=userid+"님이 로그인되었습니다.";
			url="../index.jsp";
		}else if(result==GuestSerivce.DISAGREE_PWD){
			msg="비밀번호가 일치하지 않습니다.";
		}else if(result==GuestSerivce.NONE_USERID)	{
			msg="해당 아이디가 존재하지 않습니다.";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	//3
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>
</body>
</html>