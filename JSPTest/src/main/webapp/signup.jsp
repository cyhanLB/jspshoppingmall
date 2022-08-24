<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>사용자 정보 등록</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }

.registerForm {
  width:900px;
  height:auto;
  padding: 10px, 10px;
  background-color:#FFFFFF;
  border:4px solid gray;
  border-radius: 20px;
}
.userid, .username, .userpasswd, .userpasswd1, .telno, .email {
  width: 80%;
  border:none;
  border-bottom: 2px solid #adadad;
  margin: 5px;
  padding: 10px 10px;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}
.btn_register  {
  position:relative;
  left:20%;
  transform: translateX(-50%);
  margin-top: 20px;
  margin-bottom: 10px;
  width:40%;
  height:40px;
  background: red;
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}
.btn_cancel  {
  position:relative;
  left:20%;
  transform: translateX(-50%);
  margin-top: 20px;
  margin-bottom: 10px;
  width:40%;
  height:40px;
  background: pink;
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}
</style>

<script>

	$(document).ready(function(){
	
		$("#btn_register").click(function(){
			
			if($("#userid").val() == '') { alert("아이디를 입력하세요."); $("#userid").focus();  return false; }
			if($("#username").val() == '') { alert("이름을 입력하세요."); $("#username").focus(); return false; }
			var Pass = $("#userpasswd").val();
			var Pass1 = $("#userpasswd1").val();
			if(Pass == '') { alert("암호를 입력하세요."); $("#userpasswd").focus(); return false; }
			if(Pass1 == '') { alert("암호를 입력하세요."); $("#userpasswd1").focus(); return false; }
			if(Pass != Pass1) 
				{ alert("입력된 비밀번호를 확인하세요"); $("#userpasswd1").focus(); return false; }
			
			// 암호유효성 검사
			var num = Pass.search(/[0-9]/g);
		 	var eng = Pass.search(/[a-z]/ig);
		 	var spe = Pass.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);	
			if(Pass.length < 8 || Pass.length > 20) { alert("암호는 8자리 ~ 20자리 이내로 입력해주세요."); return false; }
			else if(Pass.search(/\s/) != -1){ alert("암호는 공백 없이 입력해주세요."); return false; }
			else if(num < 0 || eng < 0 || spe < 0 ){ alert("암호는 영문,숫자,특수문자를 혼합하여 입력해주세요."); return false; }
			
		 	if($("#telno").val() == '') { alert("전화번호를 입력하세요."); $("#telno").focus(); return false; }
		 	//전화번호 문자열 정리
			var beforeTelno = $("#telno").val();
		 	var afterTelno = beforeTelno.replace(/\-/gi,"").replace(/\ /gi,"").trim();
		 	//console.log("afterTelno : " + afterTelno);
		 	$("#telno").val(afterTelno);
		 	
			if($("#email").val() == '') { alert("이메일주소를 입력하세요."); $("#email").focus(); return false; }
			
			$("#registerForm").attr("action","memberRegistry.jsp").submit();	
		});
		
		$("#userid").change(function(){
			
			$.ajax({
				url: "idCheck.jsp",
				type: "post", 
				datatype: "json",
				data: {"userid": $("#userid").val()},
				success: function(data){
					var jsonInfo = JSON.parse(data);
					console.log("jsonInfo = " + jsonInfo)
					if(jsonInfo.id_count == 1 ){
						$("#checkID").html("동일한 아이디가 존재합니다. 새로운 아이디를 입력하세요.");
						$("#userid").val("").focus();
					}else $("#checkID").html("사용 가능한 아이디입니다.");
				}
			});

		});
		
	});
	
</script>

</head>
<body>
<br><br><br>

<div class="main" align="center">
  <div class="registerForm">
	      
    <h1>사용자 등록</h1>
    <form name="registerForm" id="registerForm" method="post"> 
        <input type="text" id="userid" name="userid" class="userid" placeholder="아이디를 입력하세요.">
        <p id="checkID" style="color:red;text-align:center;"></p>
		    <input type="text" id="username" name="username" class="username" placeholder="이름을 입력하세요.">
        <input type="password" id="userpasswd" name="password" class="userpasswd" placeholder="암호를 입력하세요.">
        <p style="color:red;text-align:center;">※ 8~20이내의 영문자, 숫자, 특수문자 조합으로 암호를 만들어 주세요.</p>
        <input type="password" id="userpasswd1" name="userpasswd1" class="userpasswd1" placeholder="암호를 한번 더 입력하세요.">
        <input type="text" id="telno" name="telno" class="telno" placeholder="전화번호를 입력하세요.">
        <input type="text" id="email" name="email" class="email" placeholder="이메일주소를 입력하세요.">
        <input type="button" id="btn_register" class="btn_register" value="사용자 등록">
        <input type="button" id="btn_cancel" class="btn_cancel" value="취소" onclick="history.back()">
	  </form>

  </div>
</div>
<br><br>
</body>
</html>