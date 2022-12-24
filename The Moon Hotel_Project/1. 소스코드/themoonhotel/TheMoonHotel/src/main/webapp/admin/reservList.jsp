<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.moon.guest.model.GuestVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.moon.room.model.RoomVO"%>
<%@page import="com.moon.reservation.model.ReservationVO"%>
<%@page import="java.util.List"%>
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
</style>
<jsp:useBean id="reservService" 
	class="com.moon.reservation.model.ReservationService" scope="session"></jsp:useBean>
<jsp:useBean id="roomService" 
	class="com.moon.room.model.RoomService" scope="session"></jsp:useBean>
<jsp:useBean id="guestService" class="com.moon.guest.model.GuestSerivce" scope="session"></jsp:useBean>
<jsp:useBean id="facService" class="com.moon.facility.model.FacilityService" scope="session"></jsp:useBean>
<jsp:useBean id="facVo" class="com.moon.facility.model.FacilityVO" scope="page"></jsp:useBean>
<%
	String userid = (String)session.getAttribute("userid");
	String condition = request.getParameter("searchCondition");
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	
	List<ReservationVO> rlist=null;
	ReservationVO reservVo = new ReservationVO();
	RoomVO roomVo = new RoomVO();

	try{
		rlist = reservService.selectAllReserv();
		
		if(condition == null) condition = "all";
		
		if(startDate != null && endDate != null){
			rlist = reservService.selectAllReserv(startDate, endDate);
			
			if(condition != null){
				rlist = reservService.selectCondition(condition);
			}
		}else{
			rlist = reservService.selectCondition(condition);
		}
		
		
		
	}catch(SQLException e){
		e.printStackTrace();
	}

	Date today = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	String now = sdf.format(today);
	int thisday = Integer.parseInt(now);
	
	DecimalFormat df = new DecimalFormat("#,###");
	
	//페이징처리
	int currentPage = 1; //현재 페이지
	
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//현재 페이지와 무관한 변수들
	int totalRecord = 0;	//총 레코드 수
	if(rlist!=null && !rlist.isEmpty()){
		totalRecord = rlist.size();
	}
	
	int pageSize = 15; 	//현재 페이지에 보여줄 레코드 개수
	int totalPage = (int)Math.ceil((float)totalRecord/pageSize); //총 페이지수
	int blockSize = 10;	//한 블럭에 보여줄 페이지 수
	
	//현재 페이지를 이용해 계산하는 변수들
	int firstPage = currentPage-((currentPage-1)%blockSize);
	// -> 블럭의 시작페이지
	
	int lastPage = firstPage+(blockSize-1);
	//블럭의 마지막 페이지
	
	int curPos = (currentPage-1)*pageSize;	
	//페이지당 ArrayList에서의 시작 index

	int num = totalRecord-curPos;	//페이지당 글 라스트 시작 번호
%>
<div style="height: 800px;">
	<p style="font-size: 120%; text-align: center; margin-top:100px;">고객 예약 조회</p>
	<div style="width: 800px; margin:auto; text-align: center">
		<form name="searReserv" method="post" action="reservList.jsp">
			<span style="margin: 0 10px 0 10px; font-weight: bold">투숙기간</span>
			<select class="form-select" name="searchCondition" value = 'condition' style="width: 160px; display: inline;">
				<option value="all"
				<%if("all".equals(condition)){ %>
					selected="selected"
           		<%} %>
				>모든 예약 보기</option>
				<option value="complete"
				<%if("complete".equals(condition)){ 
					%>
					selected="selected"
           		<%} %>
				>이용완료</option>
				<option value="incomplete"
				<%if("incomplete".equals(condition)){ %>
					selected="selected"
           		<%} %>
				>이용예정</option>
				<option value="ing"
				<%if("ing".equals(condition)){ 
				%>
					selected="selected"
           		<%} %>
				>투숙중</option>
			</select>
			<input type="date" class="" name="startDate"> ~ <input type="date" name="endDate"> 
			<input type="submit" value="예약조회" > 
		</form>
	</div>
	<hr>
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
	  <%if(rlist == null && rlist.isEmpty()){ %>
	  	<tr><th colspan="4" rowspan="2">예약내역이 없습니다.</th></tr>
	  <%}else{ %>
		  <%for(int i=0; i<pageSize; i++){ 
				if(num<1) break;
				
			  	reservVo = rlist.get(curPos++);
			  	num--;
			  	
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
			      <td><a href="reservDetail.jsp?reservNo=<%=reservVo.getReservNo()%>"><%=reservVo.getReservNo()%></a></td>
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
		   <%}//for 
		  }//if%>
	  </tbody>
</table>
<div align="center">
<%	
	//page 나타내기
	//첫 페이지가 1이 아니면 앞쪽 화살표 나타내기
	if(firstPage>1){ %>
			<a href="reservList.jsp?currentPage=<%=firstPage-1%>&searchCondition=<%=condition%>">
				<img src="../images/first.JPG">
			</a>	
	<%	}	%>
	
	<%
		for(int i=firstPage;i<=lastPage;i++){
			if(i>totalPage) break;
			
			if(i==currentPage){%>
				<span style="font-weight: bold;font-size: 1em">
					<%=i %></span>
			<%}else{ %>
				<a href="reservList.jsp?currentPage=<%=i%>&searchCondition=<%=condition%>">
					[<%=i %>]</a>
			<%} %>
	<%	}	%>
	
	<!-- 다음 블럭으로 이동 -->
		<%if(lastPage < totalPage){  %>
		<a href="reservList.jsp?currentPage=<%=lastPage+1%>&searchCondition=<%=condition%>">
			<img src="../images/last.JPG">
		</a>
	<% }%> 
</div>
</div>
<jsp:include page="../inc/footer.jsp"></jsp:include>