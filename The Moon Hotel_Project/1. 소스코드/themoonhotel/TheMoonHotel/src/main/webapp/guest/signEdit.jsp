<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../inc/top.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="../css/login.css">
<jsp:useBean id="guestSerivce" class="com.moon.guest.model.GuestSerivce" scope="session"></jsp:useBean>
<jsp:useBean id="guestVO" class="com.moon.guest.model.GuestVO" scope="page"></jsp:useBean>
<%
	String userid=(String)session.getAttribute("userid");
	
	try{
		guestVO=guestSerivce.selectByUserid(userid);
	}catch(SQLException e){
		e.printStackTrace();
	}
	String tel=guestVO.getTel();
	String tel1="", tel2="", tel3="";
	if(tel!=null&& !tel.isEmpty()){
		String[] telArr=tel.split("-");
		tel1=telArr[0];
		tel2=telArr[1];
		tel3=telArr[2];
	}
	String email=guestVO.getEmail();
	String email1="", email2="", email3="";
	if(email!=null && !email.isEmpty()){
		String[] emailArr=email.split("@");
		email1=emailArr[0];
		email2=emailArr[1];
	}
%>
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#pwd').focus();
	
	$('#wr_submit').click(function(){
		if($('#pwd').val().length<1){
			alert('비밀번호를 입력하세요');
			$('#pwd').focus();
			event.preventDefault();
		}else if($('#pwd').val()!=$('#pwd2').val()){
			alert('비밀번호가 일치하지 않습니다.');
			$('#pwd2').focus();
			event.preventDefault();
		}else if(!validate_phone($('#hp2').val())
				|| !validate_phone($('#hp3').val())){
			alert('전화번호는 숫자만 가능합니다.');
			$('#hp2').focus();
			event.preventDefault();
		}
	});
   
    
    
 });
function vaildate_phone(tel){
	var pattern new EegExp(/^[0-9]*$/g);
	return pattern.test(tel);
}
</script>
<section class="loginBanner">
	<article>
		<div>
			<img alt="" src="../images/signEditBanner.png" >
		</div>
	</article>
</section>
<div class="container text-center loginTitle">
		<h1>회원정보수정</h1>
</div>
<section class="content" >
	<article>
			<div class="input-form container input-form-backgroud row" style=" margin: 0 auto; width:800px;">
			<br><br><br>
				<form class="validation-form container" novalidate action="signEdit_ok.jsp">
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="name">이름</label>
							<input type="text" class="form-control" id="name" name="name" value="<%=guestVO.getName() %>" disabled>
						</div>
						<div class="col-md-6 mb-3">
							<label for="userid">ID</label>
							<input type="text" class="form-control" id="userid" name="userid" value="<%=userid %>" disabled>
						</div>
						<div class="col-md-6 mb-3">
							<label for="pwd">비밀번호</label>
							<input type="password" class="form-control" id="pwd" name="pwd" value="" >
						</div>
						<div class="col-md-6 mb-3">
							<label for="pwd2">비밀번호 확인</label>
							<input type="password" class="form-control" id="pwd2" name="pwd2" value="" >
						</div>
						<p style="margin-bottom: 1px">이메일</p>
						<div class="input-group mb-3">
						  <input type="text" class="form-control" id="email1" name="email1" aria-label="TheMoonHotel" value="<%=email1 %>">
						  <span class="input-group-text">@</span>
						  <input type="text" class="form-control" id="email2" name="email2" aria-label="naver.com"  value="<%=email2 %>">
						</div>
					</div>
					     	<label for="tel1">전화번호</label> <br>
					<div class="container " style="height: 30px">
					  <div class="row">
					    <div class="col" style="padding:0">
					      	<select class="form-select"
								aria-label="Default select example" id="tel1" name="tel1">
								<option value="010"
									<%if(tel1.equals("010")){ %>
										selected="selected"
									<%} %>
									>010</option>
								<option value="011"
									<%if(tel1.equals("011")){ %>
										selected="selected"
									<%} %>
									>011</option>
								<option value="016"
									<%if(tel1.equals("016")){ %>
										selected="selected"
									<%} %>
									>016</option>
								<option value="017"
									<%if(tel1.equals("017")){ %>
										selected="selected"
									<%} %>
									>017</option>
								<option value="018"
									<%if(tel1.equals("018")){ %>
										selected="selected"
									<%} %>
									>018</option>
								<option value="019"
									<%if(tel1.equals("019")){ %>
										selected="selected"
									<%} %>
									>019</option>
							</select>
					    </div>
					    <div class="" style="padding:5px;text-align: center;width: 20px;">
					      -
					    </div>
					    <div class="col" style="padding:0">
					      <input type="text" class="form-control" style="width: auto%" id="tel2" name="tel2" maxlength="4" title="휴대폰 가운데자리"value="<%=tel2%>">
					    </div>
					    <div class="" style="padding:5px;text-align: center;width: 20px;">
					      -
					    </div>
					    <div class="col" style="padding:0">
					      <input type="text" class="form-control" id="tel3" name="tel3" maxlength="4" title="휴대폰 뒷자리" value="<%=tel3%>">
					    </div>
					  </div>
					</div>
					<br>
					<button id="sub1" class="btn btn-dark btn-block editChk"  type="submit">회원정보수정</button>
				</form>
			</div>
	</article>
</section>
<jsp:include page="../inc/footer.jsp"></jsp:include>