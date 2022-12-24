<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<jsp:include page="../inc/top.jsp"></jsp:include>
<%
	String ck_value="";
	Cookie [] ckArr=request.getCookies();
	if(ckArr!=null){
		for(int i=0;i<ckArr.length;i++){
			if(ckArr[i].getName().equals("ck_userid")){
				ck_value=ckArr[i].getValue();
				break;
			}
		}//for
	}
%>
<!-- <section class="loginBanner">
	<article>
		<div>
			<img alt="" src="../images/greetings_banner.png" >
		</div>
	</article>
</section> -->
<!-- <div class="container text-center loginTitle">
		<h1>Login</h1>
</div> -->
<style>
	.btn-group{
		display: table;
		width: 45%;
		margin: auto;
		text-align: center;
	}
	.input-group-text{
		width: 114px;
		text-align: center;
	}
</style>	
<div style="height: 800px; margin-top: 150px; text-align: center;">
<section>
	<article>
			<div>
				<img style="width: 350px" alt="logo" src="../images/logotext.png" >
			</div>
	</article>
</section>
<!-- <p style="font-size: 1.5rem; text-align: center; margin-top: 20px;">Welcome to The Moon Hotel</p> -->
<br>
<article class="singleForm">
	<form name="frmLogin" method="post" action="login_ok.jsp">
	<fieldset>
	
		<div style="display:table; width: 400px; margin: auto;">
			<div class="input-group mb-3">
				<span class="input-group-text">ID</span>
 				<div class="form-floating">
				    <input type="text" class="form-control" id="userid" 
				    placeholder="userid" name="userid"  value="<%=ck_value%>">
	   				<label for="userid">아이디를 입력하세요</label>
 				 </div>
			</div>
	
			<div class="input-group mb-3">
				<span class="input-group-text">PASSWORD</span>
 				<div class="form-floating">
				    <input type="password" class="form-control" id="pwd" 
				    placeholder="pwd" name="pwd">
	   				<label for="pwd">비밀번호를 입력하세요</label>
 				 </div>
			</div>
		</div>
		<div style="display:table; width: 400px; margin: auto;">
			<div style="text-align: right;">
				<input class="form-check-input mt-0" type="checkbox" name="chkSave" 
					<%
						if(ck_value!=null && !ck_value.isEmpty()){%>
							ckecked='checked'	
					<%  }%>
				> 
				<label for="chkSave">아이디 저장하기</label>	
			</div><br>
			<div class="btn-group" role="group">
				<button type="submit" class="btn btn-dark btn-block" style="width: 400px;">로그인</button>
			</div>
		</div>
	</fieldset>
	</form>
</article>
</div>
<br>
<br>

<jsp:include page="../inc/footer.jsp"></jsp:include>
