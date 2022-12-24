<%@page import="com.moon.guest.model.GuestVO"%>
<%@page import="com.moon.room.model.RoomVO"%>
<%@page import="com.moon.reservation.model.ReservationVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../inc/top.jsp"></jsp:include>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="../css/adminPage.css" />

<jsp:useBean id="reservService" 
	class="com.moon.reservation.model.ReservationService" scope="session"></jsp:useBean>
<jsp:useBean id="roomService" 
	class="com.moon.room.model.RoomService" scope="session"></jsp:useBean>
<jsp:useBean id="guestService" class="com.moon.guest.model.GuestSerivce" scope="session"></jsp:useBean>
<jsp:useBean id="facService" class="com.moon.facility.model.FacilityService" scope="session"></jsp:useBean>
<jsp:useBean id="facVo" class="com.moon.facility.model.FacilityVO" scope="page"></jsp:useBean>
<%
	String userid = (String)session.getAttribute("userid");
	String guestNo = request.getParameter("guestNo");
	
	List<ReservationVO> rlist=null;
	ReservationVO reservVo = null;
	RoomVO roomVo = null;

	try{
		rlist = reservService.selectAllReserv(Integer.parseInt(guestNo));
		
	}catch(SQLException e){
		e.printStackTrace();
	}

	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	String now = sdf.format(today);
	int thisday = Integer.parseInt(now);
	
	DecimalFormat df = new DecimalFormat("#,###");
%>

<p style="font-size: 120%; 
	text-align: center; margin-top:20px;" >회원 예약 정보</p>

<table class="table" style="width: 800px; margin:auto; text-align: center;">
	  <thead>
	    <tr>
	      <th>예약번호</th>
		  <th>회원이름</th>
		  <th>호텔정보</th>
		  <th>이용일자</th>
		  <th>가격</th>	
		  <th>이용상태</th>
	    </tr>
</thead>
<tbody>
	  <%if(rlist.size() == 0 && rlist.isEmpty()){ %>
	  	<tr><th colspan="6" rowspan="2">예약내역이 없습니다.</th></tr>
	  <%}else{ %>
		  <%for(int i=0; i<rlist.size(); i++){ 
				
			  	reservVo = rlist.get(i++);
			  	
			  	roomVo = roomService.selectRoomByRoomNo(reservVo.getRoomNo());
		  		String checkout = reservVo.getCo_date();
		  		checkout = checkout.replace("-", "");
		  		int dateout = Integer.parseInt(checkout);
		  		String checkin = reservVo.getCi_date();
		  		checkin = checkin.replace("-","");
		  		int datein = Integer.parseInt(checkin); 
		  		GuestVO guestVo = guestService.selectByGuestNo(reservVo.getGuestNo());
	  	  %>
			    <tr>
			      <td><a href="guestReservDetail.jsp?reservNo=<%=reservVo.getReservNo()%>"><%=reservVo.getReservNo()%></a></td>
			      <td><%=guestVo.getName()%></td>
				  <td><%=roomVo.getLocName() %></td>
				  <td><%=reservVo.getCi_date()%> - <%=reservVo.getCo_date() %></td>
				  <td align="right"><%=df.format(reservVo.getTotalPrice()) %></td>
			  	  <%if((datein-thisday)>0){ %>
				  <td value="incomplete">이용예정</td>	
				  <%}else if((dateout-thisday)<0){ %>
				  <td value="complete">이용완료</td>
				  <%}else{ %>
				  <td value="ing">투숙중</td>
				<%}//if %>
			    </tr>
		   <%}//for %>
		<% }//if%>
	  </tbody>
</table>
<div align="center">
	<a class="btn btn-secondary" role="button" id="reservList"
		 href="guestList.jsp">회원 목록</a>
</div>
<jsp:include page="../inc/footer.jsp"></jsp:include>