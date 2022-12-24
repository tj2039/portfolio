<%@page import="com.moon.guest.model.GuestVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.moon.askBoard.model.CommentDAO"%>
<%@page import="com.moon.askBoard.model.CommentVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="../css/sales.css">

<jsp:useBean id="guestSerivce" class="com.moon.guest.model.GuestSerivce" scope="session"></jsp:useBean>
<jsp:useBean id="guestVO" class="com.moon.guest.model.GuestVO" scope="page"></jsp:useBean>
<%
	String userid=(String)session.getAttribute("userid");
	GuestVO g_vo = guestSerivce.selectByUserid(userid);
%>
<%
	String askno = request.getParameter("askno");
	List<CommentVO> list = null;
	
	CommentVO vo = new CommentVO();
	CommentDAO dao = new CommentDAO();
	try{
		list = dao.selectComment(Integer.parseInt(askno));
	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>


<style>
	table{
		border-collapse: collapse;
		width: 800px;
		margin-top: 30px;
		margin-left: 90px;
	}
	.co_list{
		width: 1000px;
		margin-left: 210px;
	}
	
	textarea{

	font-size: 1em; 
	width:600px; 
	height: 60px;
	overflow: hidden;
	}
</style>
<div class="co_list">
	<h4 style="margin-left: 90px">답글</h4>
	<div class="tableSize">
		<input type="hidden" id="askno" name="askno" value="<%=askno%>">
		<table class="table">
			<thead>
				<tr>
					<th scope="col">작성자</th>
					<th scope="col">내용</th>
					<th scope="col">등록시간</th>
					<th></th>
				</tr>
				
			<tbody>
				<%if(list==null||list.isEmpty()){ %>
				<tr>
					<td colspan="3" style="text-align: center">등록된 답변이 없습니다.</td>
				</tr>
				<% }else{%>
					<%for(int i=0; i<list.size(); i++){ 
						vo = list.get(i);%>
					
						<tr style="text-align: center">
							<td><%=vo.getName()%></td>
							<td style="margin-left: 100px">
								<textarea readonly><%=vo.getContent()%></textarea>
							</td>
							<td><%=sdf.format(vo.getRegdate())%></td>
							<%if(g_vo.getSys() != 1){ %>
								<td>
									<input type="button" class="Delete" value="삭제">
								</td>
							<%} %>
						</tr>
					<% }%>
				<%} %>
			</tbody>
		</table>
	</div>
</div>

<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('.Delete').click(function(){
			if(!confirm('해당 답변을 삭제하시겠습니까?')){
				event.preventDefault();
			}else{
				location.href
					="<%=request.getContextPath() %>/askBoard/commentDelete_ok.jsp?no=<%=vo.getNo() %>";
			}
		});
	});
</script>