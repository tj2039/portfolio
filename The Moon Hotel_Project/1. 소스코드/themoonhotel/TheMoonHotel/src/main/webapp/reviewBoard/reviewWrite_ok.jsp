<%@page import="java.io.IOException"%>
<%@page import="java.io.IOError"%>
<%@page import="java.io.File"%>
<%@page import="com.moon.common.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.moon.reviewBoard.model.ReviewBoardDAO"%>
<%@page import="com.moon.reviewBoard.model.ReviewBoardVO"%>
<%@page import="java.sql.SQLException"%>
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
	//Write에서 post로 넘어옴
	 String saveDir = application.getRealPath("Utility.UPLOAD_DIR");
	 saveDir = config.getServletContext().getRealPath("Utility.TEST_DIR");
		
	saveDir = Utility.TEST_DIR;
	int maxSize = 2*1024*21024;
	try{
		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request, saveDir, maxSize, "utf-8", policy);
		
		String fileName = mr.getFilesystemName("upfile");
		long fileSize = 0;
		
		if(fileName!=null){	//파일이 첨부된 경우만
			File file = mr.getFile("upfile");
			fileSize=file.length();
		}
		
		String r_title = mr.getParameter("title");
		String r_content = mr.getParameter("content");	
		String guestNo = mr.getParameter("guestNo");
		
		System.out.println(r_title);
		System.out.println(r_content);
		
		ReviewBoardDAO dao = new ReviewBoardDAO();
		ReviewBoardVO vo = new ReviewBoardVO();
		vo.setGuestNo(Integer.parseInt(guestNo));
		vo.setR_title(r_title);
		vo.setR_content(r_content);
	
		int cnt = dao.insertReview(vo);
		
		if(cnt>0){%>
		<script type="text/javascript">
					alert('글 등록되었습니다.');
					location.href="reviewBoardList.jsp";
				</script>
		<%}else{%>
		<script type="text/javascript">
					alert('글 등록 실패!');
					history.back();
				</script>
		<%}		
		}catch(SQLException e){
			e.printStackTrace();
		}catch(IOException e){%>
		<script type="text/javascript">
			alert("2M 이상의 파일은 업로드 할수 없다.");
			history.back();
			</script>
		<%e.printStackTrace();
		}
	%>
</body>
</html>