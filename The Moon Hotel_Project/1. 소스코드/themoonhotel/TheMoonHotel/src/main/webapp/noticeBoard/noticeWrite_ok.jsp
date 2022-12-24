<%@page import="java.io.IOException"%>
<%@page import="java.io.IOError"%>
<%@page import="java.io.File"%>
<%@page import="com.moon.common.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.moon.noticeBoard.model.NoticeBoardVO"%>
<%@page import="com.moon.noticeBoard.model.NoticeBoardDAO"%>
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
		
		String n_title = mr.getParameter("title");
		String n_content = mr.getParameter("content");	
		String guestNo = mr.getParameter("guestNo");
		
		NoticeBoardDAO dao = new NoticeBoardDAO();
		NoticeBoardVO vo = new NoticeBoardVO();
		vo.setGuestNo(Integer.parseInt(guestNo));
		vo.setN_title(n_title);
		vo.setN_content(n_content);
	
		int cnt = dao.insertNotice(vo);
		
		if(cnt>0){%>
		<script type="text/javascript">
					alert('글 등록되었습니다.');
					location.href="noticeBoardList.jsp";
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