<%@page import="java.sql.SQLException"%>
<%@page import="com.moon.guest.model.GuestVO"%>
<%@page import="com.moon.askBoard.model.CommentVO"%>
<%@page import="com.moon.askBoard.model.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="guestService" class="com.moon.guest.model.GuestSerivce" 
	scope="session"></jsp:useBean>
<jsp:useBean id="guestVo" class="com.moon.guest.model.GuestVO" 
	scope="page"></jsp:useBean>
	
<%
	String userid = (String)session.getAttribute("userid");	
	GuestVO vo = guestService.selectByUserid(userid);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	String askno = request.getParameter("askno");
	String content = request.getParameter("c_content");

	CommentDAO c_dao = new CommentDAO();
	CommentVO c_vo = new CommentVO();
	
	c_vo.setName(vo.getName());
	c_vo.setContent(content);
	c_vo.setAskno(Integer.parseInt(askno));
	
	try{
		int cnt = c_dao.insertcomment(c_vo);
		
		if(cnt > 0){%>
			<script type="text/javascript">
				alert('답변이 등록되었습니다.');
				location.href="<%=request.getContextPath() %>/askBoard/askDetail.jsp?askno=<%=askno%>";
			</script>
		<%}else{%>
			<script type="text/javascript">
				alert('답변 등록 중 오류발생');
				history.back();
			</script>			
	<%}		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	%>
</body>
</html>