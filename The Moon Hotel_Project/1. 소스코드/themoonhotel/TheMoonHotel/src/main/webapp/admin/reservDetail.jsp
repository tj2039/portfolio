<%@page import="com.moon.guest.model.GuestVO"%>
<%@page import="com.moon.room.model.RoomVO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.moon.reservation.model.ReservationVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../inc/top.jsp"></jsp:include>
<style>
	p{
		font-size: 120%; 
		text-align: center; 
		margin-top:100px;
	}	
	#reservList, #reservDelete{
		margin-top: 20px;
		display: inline-block;
	}
</style>
<script type="text/javascript">
	$(function(){
		$('#reservDelete').click(function(){
			if(!confirm("예약을 취소하시겠습니까?")){
				event.preventDefault();
			}
		});
	});
</script>
<jsp:useBean id="reservService" class="com.moon.reservation.model.ReservationService" scope="session"></jsp:useBean>
<jsp:useBean id="roomService" class="com.moon.room.model.RoomService" scope="session"></jsp:useBean>
<jsp:useBean id="guestService" class="com.moon.guest.model.GuestSerivce" scope="session"></jsp:useBean>
<%
	//파라미터 받아오기 - 예약 번호
	String reservNo = request.getParameter("reservNo");
	
	ReservationVO reservVo = null;
	RoomVO roomVo = null;
	GuestVO guestVo = null;
	try{
		reservVo = reservService.searchReservByNo(Integer.parseInt(reservNo));
		roomVo = roomService.selectRoomByRoomNo(reservVo.getRoomNo());
		guestVo = guestService.selectByGuestNo(reservVo.getGuestNo());
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	DecimalFormat df = new DecimalFormat("#,###");
%>
<div style="height:700px; width: 800px; margin: auto;">
	<p>예약 세부 내역</p>
	<div style="width: 800px; margin: auto;">
		<ul class="list-group" style="float:left; width: 35%; text-align: right; font-weight: bold;">
		  <li class="list-group-item">예약번호</li>
		  <li class="list-group-item">이름</li>
		  <li class="list-group-item">회원번호</li>
		  <li class="list-group-item">아이디</li>
		  <li class="list-group-item">이메일</li>
		  <li class="list-group-item">전화번호</li>
		  <li class="list-group-item">예약날짜</li>
		  <li class="list-group-item">지점정보</li>
		  <li class="list-group-item">객실타입</li>
		  <li class="list-group-item">이용객 수</li>
		  <li class="list-group-item">가격</li>
		</ul>
		<ul class="list-group" style="float:left; width: 65%">
		  <li class="list-group-item"><%=reservNo%></li>
		  <li class="list-group-item"><%=guestVo.getName()%></li>
		  <li class="list-group-item"><%=reservVo.getGuestNo()%></li>
		  <li class="list-group-item"><%=guestVo.getUserid()%></li>
		  <li class="list-group-item"><%=guestVo.getEmail()%></li>
		  <li class="list-group-item"><%=guestVo.getTel()%></li>
		  <li class="list-group-item"><%=reservVo.getCi_date()%> - <%=reservVo.getCo_date()%></li>
		  <li class="list-group-item"><%=roomVo.getLocName() %></li>
		  <li class="list-group-item"><%=roomVo.getRoomType() %></li>
		  <li class="list-group-item">성인: <%=reservVo.getAdult()%> / 아동: <%=reservVo.getKids()%></li>
		  <li class="list-group-item"><%=df.format(reservVo.getTotalPrice())%></li>
		</ul>
	</div>
	<div align="center">
		<a class="btn btn-secondary" role="button" id="reservList"
			 href="reservList.jsp">예약 목록</a>
		<a class="btn btn-secondary" role="button" id="reservDelete"
			 href="reservDelete.jsp?reservNo=<%=reservNo%>">예약 취소</a>
	</div>
</div>
<jsp:include page="../inc/footer.jsp"></jsp:include>