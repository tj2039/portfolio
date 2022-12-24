<%@page import="com.moon.room.model.RoomVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.moon.reservation.model.ReservationVO"%>
<%@page import="java.util.List"%>
<%@page import="com.moon.reservation.model.ReservationService"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.moon.guest.model.GuestVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	p{
		font-size: 200%; 
		text-align: center; 
		margin-top:20px;
		font-weight: bold;	
	}
</style>
<jsp:include page="../inc/top.jsp"></jsp:include>
<jsp:useBean id="reservService"
	class="com.moon.reservation.model.ReservationService" scope="session"></jsp:useBean>
<jsp:useBean id="guestService" class="com.moon.guest.model.GuestSerivce" scope="session"></jsp:useBean>
<jsp:useBean id="guestVO" class="com.moon.guest.model.GuestVO" scope="page"></jsp:useBean>
<jsp:useBean id="roomService" class="com.moon.room.model.RoomService" scope="session"></jsp:useBean>
<%
	String userid = (String)session.getAttribute("userid"); //로그인 정보
	
	GuestVO guestVo = guestService.selectByUserid(userid);
	int guestNo = guestVo.getGuestNo();
	
	List<ReservationVO> rlist = null;
	ReservationVO reservVo = new ReservationVO();
	RoomVO roomVo = new RoomVO();
	try{
		rlist = reservService.selectAllReserv(guestNo);
		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	String now = sdf.format(today);
	int thisday = Integer.parseInt(now);
%>
	
<div style="height: 800px; margin-top: 100px;">
	<p style="text-align: center; margin-top:20px;"><%=guestVo.getName() %>님의 예약 내역</p>
<!-- 	<div style="width: 800px; margin:auto; text-align: center">
		<form name="searMyReserv" method="post" action="myReservList_ok.jsp">
			<span style="margin: 0 10px 0 10px; font-weight: bold">투숙기간</span>
			<select class="form-select" style="width: 160px; display: inline;">
				<option>모든예약보기</option>
				<option>이용완료</option>
				<option>투숙중</option>
				<option>이용예정</option>
			</select>
			<input type="date" class="" name="startDate" required>
			 ~ 
			<input type="date" name="endDate" required> 
			<input type="submit" value="예약조회"> 
		</form>
	</div> -->
	<hr>
	<table class="table" style="width: 800px; margin:auto; text-align: center;">
	  <thead>
	    <tr>
	      <th>예약번호</th>
	      <th>지점</th>
		  <th>객실타입</th>
		  <th>이용일자</th>
		  <th>이용상태</th>	
	    </tr>
	  </thead>
	  <tbody>
	  <%if(rlist==null || rlist.isEmpty()){ %>
	  		<tr><td colspan="5" align="center">예약된 객실이 없습니다.</td></tr>
	  <%}else{%>
	  	<%for(int i=0; i<rlist.size(); i++){
	  		reservVo = rlist.get(i);
	  		roomVo = roomService.selectRoomByRoomNo(reservVo.getRoomNo());
	  		String checkout = reservVo.getCo_date();
	  		checkout = checkout.replace("-", "");
	  		int dateout = Integer.parseInt(checkout);
	  		String checkin = reservVo.getCi_date();
	  		checkin = checkin.replace("-","");
	  		int datein = Integer.parseInt(checkin);
	  		%>
			<tr>
		      <td><a href="myReservDetail.jsp?reservNo=<%=reservVo.getReservNo()%>">
		      		<%=reservVo.getReservNo()%></a></td>
		      <td><%=roomVo.getLocName() %></td>
			  <td><%=roomVo.getRoomType() %></td>
			  <td><%=reservVo.getCi_date()%> ~ <%=reservVo.getCo_date() %></td>
			<%if((datein-thisday)>0){ %>
			  <td>이용예정</td>	
			<%}else if((dateout-thisday)<0){ %>
			 	<td>이용완료</td>
			<%}else{ %>
				<td>투숙중</td>
			<%}//if %>
		    </tr>
		 <%}//for
	  	}//if%>
	  </tbody>
</table>
</div>
<jsp:include page="../inc/footer.jsp"></jsp:include>