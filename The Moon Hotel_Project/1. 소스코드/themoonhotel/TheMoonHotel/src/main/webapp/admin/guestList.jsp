<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.moon.guest.model.GuestVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../inc/top.jsp"></jsp:include>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<style>
	tr, td{
		text-align: center; 
	
	}
</style>
<jsp:useBean id="guestService" class="com.moon.guest.model.GuestSerivce" scope="session"></jsp:useBean>
<%
	String userid = (String)session.getAttribute("userid");

	request.setCharacterEncoding("utf-8");
	
	String condition = request.getParameter("searchCondition");
	String keyword = request.getParameter("searchKeyword");
	
	if(keyword==null) keyword="";
	
	List<GuestVO> glist = null;
	GuestVO guestVo = null;
	try{
		glist = guestService.selectAllGuest(condition, keyword);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	//페이징처리
	int currentPage = 1; //현재 페이지
	
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//현재 페이지와 무관한 변수들
	int totalRecord = 0;	//총 레코드 수
	if(glist!=null && !glist.isEmpty()){
		totalRecord = glist.size();
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
<p style="font-size: 120%; text-align: center; margin-top:20px;" >회원 정보 조회</p>

<table class="table" style="width: 800px; margin:auto;">
  <thead>
    <tr>
      <th scope="col">회원번호</th>
      <th scope="col">이름</th>
      <th scope="col">아이디</th>
      <th scope="col">이메일</th>
      <th scope="col">전화번호</th>
      <th scope="col">가입날짜</th>
    </tr>
  </thead>
  <tbody>
    <%if(glist == null && glist.isEmpty()){ %>
    	<tr><th colspan="6" rowspan="2">가입된 회원이 없습니다.</th></tr>
    <%}else{ %>
    	<%for(int i=1; i<pageSize; i++){ 
    		if(num<1) break;
    		
    		guestVo = glist.get(curPos++);
    		num--;
    	%>
		    <tr>
		      <td>
		      	<a href="guestDetail.jsp?guestNo=<%=guestVo.getGuestNo() %>">
		      		<%=guestVo.getGuestNo() %></a>
		      </td>
			  <td><%=guestVo.getName() %></td>
			  <td><%=guestVo.getUserid() %></a></td>
			  <td><%=guestVo.getEmail() %></td>
			  <td><%=guestVo.getTel() %></td>
			  <td><%=sdf.format(guestVo.getJoindate())%></td>	
		    </tr>
		<%} %>
	<%} %>
  </tbody>
</table>
<div align="center">
<%	
	//page 나타내기
	//첫 페이지가 1이 아니면 앞쪽 화살표 나타내기
	if(firstPage>1){ %>
			<a href="guestList.jsp?currentPage=<%=firstPage-1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
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
				<a href="guestList.jsp?currentPage=<%=i%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
					[<%=i %>]</a>
			<%} %>
	<%	}	%>
	
	<!-- 다음 블럭으로 이동 -->
		<%if(lastPage < totalPage){  %>
		<a href="guestList.jsp?currentPage=<%=lastPage+1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
			<img src="../images/last.JPG">
		</a>
	<% }%> 
</div>
<div class="guestSearch" style="text-align: center; padding: 10px">
   	<form name="frmSearch" method="post" action='guestList.jsp'>
        <select name="searchCondition">
            <option value="name" 
            <%if("name".equals(condition)) {%>
            		selected="selected"
            <%} %>
            >이름</option>
            <option value="userid"
            <%if("userid".equals(condition)) {%>
	            		selected="selected"
	            	<%} %>
	        >아이디</option>
            <option value="guestNo"
            <%if("guestNo".equals(condition)) {%>
	            		selected="selected"
	            	<%} %>
            >회원번호</option>
        </select>   
        <input type="text" name="searchKeyword" title="검색어 입력"
        	value="<%=keyword%>">   
		<input type="submit" value="검색">
    </form>
</div>
</div>
<jsp:include page="../inc/footer.jsp"></jsp:include>
