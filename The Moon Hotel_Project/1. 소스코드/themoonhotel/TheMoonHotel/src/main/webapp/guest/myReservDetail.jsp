<%@page import="com.moon.facility.model.FacilityVO"%>
<%@page import="com.moon.room.model.RoomVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.moon.reservation.model.ReservationVO"%>
<%@page import="com.moon.guest.model.GuestVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../inc/top.jsp"></jsp:include>
<style>
	p{
		font-size: 200%; 
		text-align: center; 
		margin-top:20px;
		font-weight: bold;	
	}
	th{
		font-size: 1.2em;
	}
	.facTable td{
		width: 200px;
	}
</style>
<jsp:useBean id="guestSerivce" class="com.moon.guest.model.GuestSerivce" scope="session"></jsp:useBean>
<jsp:useBean id="guestVO" class="com.moon.guest.model.GuestVO" scope="page"></jsp:useBean>
<jsp:useBean id="reservService" class="com.moon.reservation.model.ReservationService" scope="session"></jsp:useBean>
<jsp:useBean id="roomService" class="com.moon.room.model.RoomService" scope="session"></jsp:useBean>
<jsp:useBean id="facSerive" class="com.moon.facility.model.FacilityService" scope="session"></jsp:useBean>
<%
	String userid = (String)session.getAttribute("userid"); //로그인 정보
	
	GuestVO guestVo = guestSerivce.selectByUserid(userid);

	String reservNo = request.getParameter("reservNo");
	
	ReservationVO reservVo = null;
	RoomVO roomVo = null;
	FacilityVO bVo = null;
	FacilityVO pVo = null;
	FacilityVO sVo = null;
	FacilityVO gVo = null;
	try{
		reservVo = reservService.searchReservByNo(Integer.parseInt(reservNo));
		roomVo = roomService.selectRoomByRoomNo(reservVo.getRoomNo());
		bVo = facSerive.selectBreakFastInfo(Integer.parseInt(reservNo));
		pVo = facSerive.selectPoolInfo(Integer.parseInt(reservNo));
		sVo = facSerive.selectSaunaInfo(Integer.parseInt(reservNo));
		gVo = facSerive.selectGymInfo(Integer.parseInt(reservNo));
		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//출력처리
	String ci_date = reservVo.getCi_date(); //2022-11-29
	String co_date = reservVo.getCo_date(); //2022-11-29
	ci_date = ci_date.replace("-", "");
	co_date = co_date.replace("-", "");
	SimpleDateFormat oldFormat = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat newFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
	
	Date checkin = oldFormat.parse(ci_date);
	String datein = newFormat.format(checkin);
	Date checkout = oldFormat.parse(co_date);
	String dateout = newFormat.format(checkout);
%>
<div style="height: 800px; margin-top: 100px;">
	<p id="title">예약 내역</p>
	<table class="table" style="width: 800px; margin:auto; text-align: center">
		<thead>
		<tr>
			<th>예약번호</th>
			<th>예약자 성명</th>
		</tr>
		</thead>
		<tr>
			<td><%=reservNo %></td>
			<td><%=guestVo.getName() %></td>
		</tr>
		<tr>
			<th>연락처</th>
			<th>이메일</th>
		</tr>
		</thead>
		<tr>
			<td><%=guestVo.getTel()%></td>
			<td><%=guestVo.getEmail()%></td>
		</tr>
	</table><br><br>
	<div style="width: 950px; margin:auto">
		<div id="reservHotelImg" style="float:left;">
			<img src="../images/<%=roomVo.getRoomImage() %>" style="width: 500px; float:left;">
		</div>
		<div id="reservInfo" style="float:left; margin-top:65px">
			<div id="reservInfo1" style="float:left; font-weight: bold;">
				<ui class="list-group list-group-flush">
					<li class="list-group-item">호텔 및 객실</li>
					<li class="list-group-item">투숙 날짜</li>
					<li class="list-group-item">객실 및 인원</li>
				</ui>
			</div>
			<div id="reservInfo2" style="float:left;">
				<ui class="list-group list-group-flush">
					<li class="list-group-item"><%=roomVo.getLocName() %> <%=roomVo.getRoomType() %></li>
					<li class="list-group-item"><%=datein%> - <%=dateout%></li>
					<li class="list-group-item">성인: <%=reservVo.getAdult() %>명 / 아동: <%=reservVo.getKids() %>명</li>
				</ui>
			</div>
		</div>		
	</div><br><br>
	<table class="facTable" style="width: 800px; margin:auto; margin-top:200px; text-align: center">
			<tr><th colspan="8" style="height: 60px;">부대시설예약정보</th></tr>
			<tr>
				<td>조식</td>
				<td>수영장</td>
				<td>사우나</td>
				<td>헬스장</td>
			<tr>
				<%if(bVo.getAdultNo()!=0){%>
					<td>성인: <%=bVo.getAdultNo() %>명 / 아동: <%=bVo.getKidsNo() %>명</td>
				<%}else{ %>
					<td>-</td>
				<%} %>
				<%if(pVo.getAdultNo()!=0){%>
					<td>성인: <%=pVo.getAdultNo() %>명 / 아동: <%=pVo.getKidsNo() %>명</td>
				<%}else{ %>
					<td>-</td>
				<%} %>
				<%if(sVo.getAdultNo()!=0){%>
					<td>성인: <%=sVo.getAdultNo() %>명 </td>
				<%}else{ %>
					<td>-</td>
				<%} %>
				<%if(gVo.getAdultNo()!=0){%>
					<td>성인: <%=gVo.getAdultNo() %>명 </td>
				<%}else{ %>
					<td>-</td>
				<%} %>
			</tr>
	</table><br><br>
</div>
<jsp:include page="../inc/footer.jsp"></jsp:include>