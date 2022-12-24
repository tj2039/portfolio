<%@page import="java.sql.SQLException"%>
<%@page import="com.moon.askBoard.model.AskBoardVO"%>
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
	
	String a_title = request.getParameter("a_title");
	String a_content = request.getParameter("a_content");
	String askno = request.getParameter("askno");

	//2.

	AskBoardDAO dao = new AskBoardDAO();
	AskBoardVO vo = new AskBoardVO();

	vo.setA_title(a_title);
	vo.setA_content(a_content);
	vo.setAskNo(Integer.parseInt(askno));

	try {
		int cnt = dao.updateAskboard(vo);

		//3.
		if (cnt > 0) {%>
	<script type="text/javascript">
			alert('문의글이 수정되었습니다.');
			location.href="askDetail.jsp?askno=<%=askno%>";
	</script>
	<%} else {%>
	<script type="text/javascript">
		alert('문의글 수정 에러');
		history.back();
	</script>

	<%} //if

	} catch (SQLException e) {
		e.printStackTrace();
	}
	%>

</body>
</html>