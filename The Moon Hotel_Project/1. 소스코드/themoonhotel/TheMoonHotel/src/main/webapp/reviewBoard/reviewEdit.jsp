<%@page import="java.sql.SQLException"%>
<%@page import="com.moon.reviewBoard.model.ReviewBoardDAO"%>
<%@page import="com.moon.reviewBoard.model.ReviewBoardVO"%>
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
<style type="text/css">
#div1{
	width: 900px;
}
#formFile{
	width: 400px;
}
#btn1{
	clear: none;
}
</style>


<script type="text/javascript"
	src="../js/smartEdit/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
var oEditors=[];
	$(function() {
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder : "txtCon",
			sSkinURI : "../js/smartEdit/SmartEditor2Skin.html",
		      htParams : {
		          bUseToolbar : true,             
		          bUseVerticalResizer : true,     
		          bUseModeChanger : true,         
		          fOnBeforeUnload : function(){
		          }
		      }, 
		      fCreator: "createSEditor2"
		      });
	  	  $("#sub1").click(function(){
	        //id가 smarteditor인 textarea에 에디터에서 대입
	          oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	        $('#frm').submit();
	    });
			$('#btn1').click(function() {
			location.href = "reviewBoardList.jsp";
		});
	});
</script>
<%
String reviewNo = request.getParameter("reviewNo");
ReviewBoardVO vo = new ReviewBoardVO();
ReviewBoardDAO dao = new ReviewBoardDAO();

try{
	vo = dao.selectByNo(Integer.parseInt(reviewNo));
}catch(SQLException e){
	e.printStackTrace();
}
%>
<body>
<br><br><br>
<div id="div1" class="container text-left">
	<form id="frm" method="post" enctype="multipart/form-data" action="reviewEdit_ok.jsp">
		<input type ="hidden" name="reviewNo" value="<%=vo.getReviewNo() %>">
		<input type ="hidden" name="guestNo" value="<%=vo.getGuestNo() %>">
		<fieldset>
			<legend>게시글 수정</legend>
			<div class="form-group">
				<label for="exampleSelect1" class="form-label mt-4">게시판 목록</label>
				<select class="form-select" id="selBoard">
					<option>공지사항</option>
				</select>
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1" class="form-label mt-4"></label>
				<input type="text" name="title" class="form-control" id="title1" value="<%=vo.getR_title()%>">
				
			</div>
			<div class="form-group">
				<label for="exampleTextarea" class="form-label mt-4"></label>
				<textarea id="content" name="content"class="form-control" rows="6"><%=vo.getR_content() %></textarea>
			</div>
			<div class="form-group">
				<label for="formFile" class="form-label mt-4">파일 첨부</label>
				<input class="form-control" type="file" id="formFile" name="fileName">
			</div>
			<button id="sub1" type="submit" class="btn btn-dark">작성</button>
			<button id="btn1" type="button" class="btn btn-dark">목록</button>
		</fieldset>
	</form>
	</div>
</body>
<br><br><br>
<jsp:include page="../inc/footer.jsp"></jsp:include>
<link rel="stylesheet" href="css/footer.css">
</html>