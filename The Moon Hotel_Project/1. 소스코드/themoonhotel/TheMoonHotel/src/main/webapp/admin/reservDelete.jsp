<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reservDelete.jsp</title>
</head>
<body>
<jsp:useBean id="reservService" class="com.moon.reservation.model.ReservationService" scope="session"></jsp:useBean>
<jsp:useBean id="facService" class="com.moon.facility.model.FacilityService" scope="session"></jsp:useBean>
<%
	//파라미터 읽어오기
	String reservNo = request.getParameter("reservNo");
	
	//db 작업
	String msg="예약취소 실패하였습니다", url="reservDetail.jsp";
	try{
		//객실예약 취소
		int reservDel = reservService.deleteReserv(Integer.parseInt(reservNo));
		//부대시설 예약 취소
		int facDel = facService.deleteFacility(Integer.parseInt(reservNo));
		
		if(reservDel > 0){
			msg="예약이 취소 되었습니다.";
			url="reservList.jsp";
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