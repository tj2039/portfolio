<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../inc/top.jsp"></jsp:include>
<link rel="stylesheet" href="../css/reservCSS.css">
<style>
#step3{
	width:33%;
	height: 80px;
	border: 1px solid white;
	background-color: black;
	color: white;
	font-weight:900;
}
#step1, #step2{
	width:33%;
	height: 80px;
	border: 1px solid black;
	color:black;
	background-color:white;
	font-weight:900;
}

#option{
	background-color: white;
	border: 1px solid black; 
	width: 100px; 
	text-align: center;
}

</style>

<%
	String userid = (String)session.getAttribute("userid"); //로그인 정보
	
	if(userid==null || userid.isEmpty()){ %>
	<script type="text/javascript">
		alert('먼저 로그인하세요');
		location.href="<%=request.getContextPath()%>/login/login.jsp";
	</script>
	
<%	return;
	}
	
	request.setCharacterEncoding("utf-8");

	//1. 파라미터 읽어오기
	String locName = request.getParameter("locName");
	String ci_date = request.getParameter("ci_date");
	String co_date = request.getParameter("co_date");
	String adult = request.getParameter("adult");
	String kids = request.getParameter("kids");
	
	String roomType = request.getParameter("roomType");
	String totalPrice = request.getParameter("totalPrice");
%>
<div style="margin-top: 100px; margin-bottom: 800px;">
	<p style="font-size: 30px; text-align: center; font-weight: bold;">객실예약</p>

	<table class="reservList1" align="center">
		<tr>
			<td id="step1">날짜,인원 선택</td>
			<td id="step2">객실 선택</td>
			<td id="step3">옵션 선택</td>
		</tr>
	</table>
	<form name="confirmRoom" method="post" action="reservation_ok.jsp" >
		<table style="width: 900px" align="center" class="reserveOption" >
			<tr>
				<td colspan="4" align="center" 
				style="font-size: 25px; font-weight: bold; border-top:2px solid #e3e3e3;">
					예약정보
				</td>
			</tr>
			<tr id="line">
				<td align="center" id="line">
				<img src="../images/room-suite.png" style="width:280px; height: 200px"></td>
				<td colspan="3" id="line">
					<table style="width: 100%">
						<tr align="left">
							<td>지점 : <b><%=locName%></b> 
								<input type="hidden" name="locName" value="<%=locName%>">
							</td>
							<td>예약 객실 : <b><%=roomType%></b> 
								<input type="hidden" name="roomType" value="<%=roomType%>">
							</td>	
						</tr>
						<tr align="left">
							<td>체크인날짜 : <b><%=ci_date%></b> 
								<input type="hidden" name="ci_date" value="<%=ci_date%>">
							</td>
							<td>체크아웃 날짜 : <b><%=co_date%></b> 
								<input type="hidden" name="co_date" value="<%=co_date%>">
							</td>
							
						</tr>
						<tr align="left">
							<td>성인 투숙객 수 : <b><%=adult%></b>명 
								<input type="hidden" name="adult" value="<%=adult%>">
							</td>
							<td>아동 투숙객 수 : <b><%=kids%></b>명 
							    <input type="hidden" name="kids" value="<%=kids%>">
							</td>
						</tr>
						<tr><td colspan="2" style="height: 20px;"></td></tr>
						<tr>
							<td colspan="2" align="center">총 금액 :
								<input type="text" name="totalPrice" style="width: 100px"
								readonly="readonly" value="<%=totalPrice %>" >원 
								<input type="hidden" name="totalPrice" value="<%=totalPrice %>">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center" 
				style="font-size: 25px; font-weight: bold; border-top:2px solid #e3e3e3;">옵션선택</td>
			</tr>
			<tr id="line">
				<td colspan="4" id="line">
					<table style="width: 100%; height: 80px;">
						<tr align="center">
							<td colspan="2" style="width: 50%"></td>
							<td>성인</td>
							<td>아동</td>
						</tr>
						<tr align="center">
							<td colspan="2">조식 인원 수 (1인당 40,000원 / 17,000원) :</td>
							<td><input type="number" name="b_adult" id="option" value="0" min="0" max="<%=adult%>"></td>
							<td><input type="number" name="b_kids" id="option" value="0" min="0" max="<%=kids%>"></td>
						</tr>
						<tr align="center">
							<td colspan="2">수영장 인원 수 (1인당 45,000원 / 28,000원) : </td>
							<td><input type="number" name="p_adult" id="option" value="0" min="0" max="<%=adult%>"></td>
							<td><input type="number" name="p_kids" id="option" value="0" min="0" max="<%=kids%>"></td>
						</tr>
						<tr align="center">
							<td colspan="2">사우나 인원 수 (1인당 35,000원) : </td>
							<td><input type="number" name="s_adult" id="option" value="0" min="0" max="<%=adult%>"></td>
							<td><b>아동 입장 불가</b></td>
						</tr>
						<tr align="center">
							<td colspan="2">헬스장 인원 수 (1인당 20,000원) : </td>
							<td><input type="number" name="g_adult" id="option" value="0" min="0" max="<%=adult%>"></td>
							<td><b>아동 입장 불가</b></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr style="border-bottom:2px solid #e3e3e3;">
				<td colspan="4" align="center" id="line"> 
					<input type="submit" id="submitBtn" value="예약하기">
				</td>
			</tr>
		</table>
	</form>
</div>

<jsp:include page="../inc/footer.jsp"></jsp:include>