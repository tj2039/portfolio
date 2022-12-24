<%@page import="com.moon.guest.model.GuestSerivce"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guestOut_ok.jsp</title>
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
	
	//db작업 - 비밀번호 확인, 탈퇴
	String msg="회원탈퇴에 실패했습니다.", url="guestOut.jsp";
	try{
		int result= guestService.loginCheck(userid, pwd);
		if(result==GuestSerivce.EXIST_ID){
			int cnt= guestService.OutGuset(userid, pwd);
			//결과처리- 탈퇴시 알림창,실패시 =>gusetOut.jsp, 로그아웃(session.invalidate(), 쿠키삭제)
			if(cnt>0){
				session.invalidate();
				Cookie[] ck= request.getCookies();
				for(int i=0; i<ck.length;i++){
					if(ck[i].getName()==userid){
						ck[i].setMaxAge(0);
						break;
					}
				}
				msg="회원 탈퇴 되었습니다";
				url="../index.jsp";
			}else{
				msg="회원탈퇴 실패";
			}
		}else{
			msg="비밀번호를 확인하세요";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<!-- jsp:forward으로 페이지 이동 -->
<jsp:forward page="../common/message.jsp"></jsp:forward>
</body>
</html>