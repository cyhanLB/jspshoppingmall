<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<!DOCTYPE html>
<html>
<head>

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>
/*
	$(document).ready(function(){
		
		$("#btn_login").click(function(){

			if($("#userid").val() =='') {
				alert("아이디를 입력하세요");
				return false;
			}
			if($("#password").val() =='') {
				alert("패스워드를 입력하세요");
				return false;
			}
			$("#loginForm").attr("action","loginCheck.jsp").submit();
		});
		
	});
*/

function loginCheck(){
	if(document.loginForm.u_id.vale == ''){
		alert("아이디를 입력하세요");
		return false;
		
	}
	if(document.loginForm.u_pw.value == ''){
		alert("패스워드를 입력하세요");
		return false;
	}
	document.loginForm.action = "loginCheck.jsp";
	document.loginForm.submit();
}

function press(){
	
	if(event.keyCode == 13){loginCheck()}
	
}

</script>

<meta charset="utf-8">
<title>로그인</title>


</head>
<body>
<br><br><br>
<div class="main" align="center">
	<div class="login">
		<h1>로그인</h1>
		<form name="loginForm" id="loginForm" class="loginForm" method="post"> 

			<input type="text" name="u_id" id="u_id" class="u_id" placeholder="아이디를 입력하세요.">
         	<input type="password" id="u_pw" name="u_pw" class="u_pw" onkeydown="press(this.form)" placeholder="비밀번호를 입력하세요.">
         	<br><br>
     		<input type="button" id="btn_login" class="login_btn" value="로그인" onclick="loginCheck()"> 
		</form>
        <div class="bottomText">사용자가 아니면 ▶<a href="signup.jsp">여기</a>를 눌러 등록을 해주세요.<br><br>
     	       
    	  </div>
	</div>
 
</div>

</body>
</html>