<%@page import="com.moon.guest.model.GuestSerivce"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.SQLClientInfoException"%>
<%@page import="com.moon.noticeBoard.model.NoticeBoardVO"%>
<%@page import="com.moon.noticeBoard.model.NoticeBoardDAO"%>
<%@page import="com.moon.askBoard.model.AskBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<jsp:include page="../inc/top.jsp"></jsp:include>
<link rel="stylesheet" href="css/top.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
</head>
<jsp:useBean id="noticeBoardVo" class="com.moon.noticeBoard.model.NoticeBoardVO"></jsp:useBean>
<jsp:useBean id="guestService" class="com.moon.guest.model.GuestSerivce" scope="session"></jsp:useBean>
<jsp:useBean id="guestVo" class="com.moon.guest.model.GuestVO" scope="page"></jsp:useBean>
<style type="text/css">
body {
	padding-top: 70px;
	padding-bottom: 30px;
}

.board_title {
	font-weight: 700;
	font-size: 22pt;
	margin: 10pt;
}

.board_info_box {
	color: #6B6B6B;
	margin: 10pt;
}

.board_author {
	font-size: 10pt;
	margin-right: 10pt;
}

.board_date {
	font-size: 10pt;
}

.board_content {
	color: #444343;
	font-size: 12pt;
	margin: 10pt;
}

.board_tag {
	font-size: 11pt;
	margin: 10pt;
	padding-bottom: 10pt;
}
</style>
<%String no = request.getParameter("no");
if (no == null || no.isEmpty()) {%>
<script type="text/javascript">
	alert('잘못된 url입니다');
	location.href = "list.jsp";
</script>
	<%return;
}

NoticeBoardDAO dao = new NoticeBoardDAO();
NoticeBoardVO vo = null;
try{
	vo = dao.selectByNo(Integer.parseInt(no));
}catch(SQLException e){
	e.printStackTrace();
}
String userid = (String)session.getAttribute("userid");
boolean t_login=false;
int GuestOrAdmin=GuestSerivce.GUEST_ACCOUNT;
if(userid!=null && !userid.isEmpty()){
	try{
         guestVo=guestService.selectByUserid(userid);
         int sys = guestVo.getSys();
         if(sys==GuestSerivce.ADMIN_ACCOUNT){
            GuestOrAdmin = GuestSerivce.ADMIN_ACCOUNT;
         }
      }catch(SQLException e){
         e.printStackTrace();
      }
   }
%>
<script type="text/javascript"src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#btnList').click(function(){
			location.href="noticeBoardList.jsp";
		});
	});
</script>
<body>
	<article>
		<div class="container" role="main">
		<br><br><br>
			<h2>상세보기</h2>
			<div class="bg-white rounded shadow-sm">
				<div class="board_title">
				<%=vo.getN_title() %><!-- 클릭한 게시물 제목 보이기 -->
				</div>
				<input type="hidden" name="noticeNo" value="<%=vo.getNoticeNo() %>">
				<div class="board_info_box">
					<span class="board_author"><%=vo.getN_content()%></span><!-- 게시글 내용 -->
					<span class="board_date"><%=vo.getN_regdate() %> </span><!-- 게시글 날짜 -->
				</div>
				<div class="board_content"></div>
				<div class="board_tag">
				</div>
			</div>
			<div style="margin-top: 20px">
				<br>
				<br>
				<br>
				<button type="button" class="btn btn-sm btn-dark" id="btnUpdate" style="<%if(GuestOrAdmin != GuestSerivce.ADMIN_ACCOUNT) {%> display:none;<%}%>"
					onclick="location.href='noticeEdit.jsp?noticeNo=<%=vo.getNoticeNo()%>'">수정</button>
				<button type="button" class="btn btn-sm btn-dark" id="btnDelete" style="<%if(GuestOrAdmin != GuestSerivce.ADMIN_ACCOUNT) {%> display:none;<%}%>"
					onclick="location.href='BoardDelete.jsp?noticeNo=<%=vo.getNoticeNo()%>'">삭제</button>
				<button type="button" class="btn btn-sm btn-dark" id="btnList">목록</button>
				<br><br><br>
			</div>
		</div>
	</article>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
</body>
<jsp:include page="../inc/footer.jsp"></jsp:include>
<link rel="stylesheet" href="css/footer.css">
</html>