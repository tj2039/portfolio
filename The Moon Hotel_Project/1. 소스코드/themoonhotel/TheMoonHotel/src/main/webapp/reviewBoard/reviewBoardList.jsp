<%@page import="com.moon.guest.model.GuestSerivce"%>
<%@page import="com.moon.guest.model.GuestVO"%>
<%@page import="java.awt.Event"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.SQLClientInfoException"%>
<%@page import="com.moon.reviewBoard.model.ReviewBoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.moon.reviewBoard.model.ReviewBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../inc/top.jsp"></jsp:include>
<style type="text/css">
#div1 {
	width: 800px;
}
</style>
<jsp:useBean id="reviewBoardDAO" class="com.moon.reviewBoard.model.ReviewBoardDAO" scope="session"></jsp:useBean>
<jsp:useBean id="reviewBoardVo" class="com.moon.reviewBoard.model.ReviewBoardVO" scope="page"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	String userid = (String)session.getAttribute("userid");
	
	String keyword = request.getParameter("search");
	String condition = request.getParameter("select1");
	if(keyword==null) keyword="";
	
	List<ReviewBoardVO> list = null;
	try{
		ReviewBoardDAO dao = new ReviewBoardDAO();
		list = dao.selectAll(condition, keyword);
				
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	//페이징 처리하기
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//현재펭지ㅣ와 무관한 변수들?
	int totalRecord = 0;
	if(list!= null && !list.isEmpty()){
		totalRecord = list.size();
	}
	int pageSize = 5;
	int totalPage = (int)Math.ceil((float)totalRecord/pageSize);	//총 페이지수 
	int blockSize=10; //한 블럭의 페이지 수
	
	//현재 페이지를 이용해 계산하는 변수들
	int firstPage = currentPage - ((currentPage-1)%blockSize);
	//블럭의 시작 페이지
	
	int lastpage = firstPage+(blockSize-1);
	//블럭의 마지막 페이지
	
	int curPos = (currentPage-1)*pageSize; //페이지당 ArrayList에서의 시작 index
	//0, 5, 10, 15...
	
	int num = totalRecord-curPos;
	boolean t_login=false;
	
%>
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btn1').click(function(){
			location.href="reviewWrite.jsp";
		});
	});
</script>
<div style="height: 800px;">
	<div class="container text-center" style="margin-top: 100px;">
	<br><br>
		<h2>리뷰게시판</h2>
	</div>
	<div id="div1" class="container text-center">
		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">no</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">날짜</th>
				</tr>
			</thead>
			<tbody>
				<%if(list==null || list.isEmpty()){ %>
				<tr>
					<td colspan="5">데이터가 없..</td>
				</tr>
				<%}else{ %>
				<%
				for(int i=0;i<pageSize;i++){
						if(num<1)break;
						reviewBoardVo = list.get(curPos++);
						num--;
				%>
				<tr>
					<td><%=reviewBoardVo.getReviewNo() %></td>
					<td><a href="detail.jsp?no=<%=reviewBoardVo.getReviewNo()%>"><%=reviewBoardVo.getR_title() %></a></td>
					<td><%=reviewBoardVo.getUserid()%></td>
					<td><%=reviewBoardVo.getR_regdate() %></td>
				</tr>
				<%} %>
			<%} %>
			</tbody>
		</table>
			<div class="divPage">
		<!-- 이전 블럭으로 이동 -->
		<%
			if(firstPage>1){%>
				<a href="reviewBoardList.jsp?currentPage=<%=firstPage-1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
					[]
				</a>
				
			<%}	%>
	
		<!-- 페이지 번호 추가 -->
		<!-- [1][2][3][4][5][6][7][8][9][10] -->
		<%
		for(int i=firstPage;i<=lastpage;i++){
			if(i>totalPage)break;%>
			<%if(currentPage!=i){ %>
				<a href="reviewBoardList.jsp?currentPage=<%=i%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">[<%=i %>]</a>
			<%}else{%>
			
				<b>[<%=i %>]</b>
			<%}%>
		<%} %>
		<!--  페이지 번호 끝 -->
		<%if(lastpage<totalPage){%>
				<a href="reviewBoardList.jsp?currentPage=<%=lastpage+1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
					asd</a>
		<%}%>
	</div>
	<form name= "frm1" method="post" action="reviewBoardList.jsp" style="width: 100%">
		<div class="form-group"style="display:inline-block">
			<label for="exampleSelect1" class="form-label mt-4"></label>
			<select class="form-select" name="select1" style="width:100px" style="float:left">
				<option value="n_title"
					<%if("r_title".equals(condition)) {%>
						selected="selected"
					<%} %>
				>제목</option>
				<option value="userid"
					<%if("userid".equals(condition)) {%>
						selected="selected"
					<%} %>				
				>작성자</option>
				<option value="regdate"
					<%if("regdate".equals(condition)) {%>
						selected="selected"
					<%} %>				
				>작성일</option>
			</select>
			</div>
		<div class="form-group"style="display:inline-block">
			<input type="text" class="form-control" name="search" placeholder="검색하고자 하는 내용 입력"
			style="width:400px" style="float:right" value="<%=keyword%>">
			</div>
		<div class="form-group"style="display:inline-block">
			<button id="searchBtn" type="submit" class="btn btn-dark" style="margin-bottom: 5px">검색</button>
			</div>
	</form>
			<br><br>
		<button id="btn1" type="button" class="btn btn-dark" style="float: right;">글쓰기</button>
		<br> <br> <br>
	</div>
</div>
<jsp:include page="../inc/footer.jsp"></jsp:include>
