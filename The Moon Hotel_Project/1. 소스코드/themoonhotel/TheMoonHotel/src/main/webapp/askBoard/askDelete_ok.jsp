askDelete_ok.jsp<%@page import="com.moon.askBoard.model.AskboardService"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.moon.askBoard.model.AskBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

	
	AskboardService dao = new AskboardService();
	try {
		int cnt = dao.deleteAskboard(Integer.parseInt(askno));
		
		if (cnt > 0) {%>
			<script type="text/javascript">
				alert('삭제되었습니다.');
				location.href = "askBoardList.jsp";
			</script>
		<%}else {%>
			<script type="text/javascript">
				alert('삭제오류');
				history.back();
			</script>
		<%}

	} catch (SQLException e) {
		e.printStackTrace();
	} catch (NumberFormatException e) {
		e.printStackTrace();
	}
	%>
</body>
</html>