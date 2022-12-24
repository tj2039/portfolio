<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.SQLClientInfoException"%>
<%@page import="com.moon.reviewBoard.model.ReviewBoardVO"%>
<%@page import="com.moon.reviewBoard.model.ReviewBoardDAO"%>
<%@page import="com.moon.askBoard.model.AskBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<jsp:include page="../inc/top.jsp"></jsp:include>
<link rel="stylesheet" href="css/top.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String reviewNo = request.getParameter("no");
	String guestNo = request.getParameter("gno");
	
	
	ReviewBoardDAO dao = new ReviewBoardDAO();
	int cnt=0;
	try{
		cnt = dao.deletereviewBoard(Integer.parseInt(reviewNo));
		
		if(cnt>0){%>
		<script type="text/javascript">
			alert("삭제가 완료되었습니다.");
			location.href="reviewBoardList.jsp";
		</script>
		<%}else{%>
		<script type="text/javascript">
			alert("삭제 에러 확인요망");
			history.go(-1);
			</script>
		<%}
	}catch(SQLException e){
		e.printStackTrace();
	}

%>



<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
</body>
<jsp:include page="../inc/footer.jsp"></jsp:include>
<link rel="stylesheet" href="css/footer.css">
</html>