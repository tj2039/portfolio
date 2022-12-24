<%@page import="com.moon.askBoard.model.AskboardService"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.moon.askBoard.model.AskBoardVO"%>
<%@page import="com.moon.askBoard.model.AskBoardDAO"%>
<%@page import="com.moon.guest.model.GuestVO"%>
<%@page import="com.moon.guest.model.GuestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="guestService" class="com.moon.guest.model.GuestSerivce" 
	scope="session"></jsp:useBean>
<jsp:useBean id="guestVo" class="com.moon.guest.model.GuestVO" 
	scope="page"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	
	
 	String userid = (String)session.getAttribute("userid");	
	GuestVO vo = guestService.selectByUserid(userid);  
	
	request.setCharacterEncoding("utf-8");

	int guestno = vo.getGuestNo();
	String a_title = request.getParameter("a_title");
	String a_content = request.getParameter("a_content");
	

	AskboardService a_dao = new AskboardService();
	AskBoardVO a_vo = new AskBoardVO();
	a_vo.setGuestNo(guestno); 
	a_vo.setA_title(a_title);
	a_vo.setA_content(a_content);
	
	try{
		int cnt = a_dao.insert(a_vo);
		
		if(cnt > 0){%>
			<script type="text/javascript">
				alert('문의글이 등록되었습니다.');
				location.href="<%=request.getContextPath() %>/askBoard/askBoardList.jsp";
			</script>
		<%}else{%>
			<script type="text/javascript">
				alert('문의글 등록 중 오류발생');
				history.back();
			</script>			
	<%}		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	%>
</body>
</html>