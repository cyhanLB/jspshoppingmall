<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>체크박스 테스트</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js">
</script>

<script>

	$(document).ready(function(){
		
		$("#checkAll").click(function(){
			if($("#checkAll").is(":checked"))
				$("input[name=item]").prop("checked",true);
			else $("input[name=item]").prop("checked",false);
		});
	
		$("input[name=item]").click(function(){
			var total = $("input[name=item]").length;
			var checked = $("input[name=item]:checked").length;
			
			if(total != checked) $("#checkAll").prop("checked", false);
			else $("#checkAll").prop("checked",true);

		});
	

	$("#btn_select").click(function(){
		
		if($("input[name=item]:checked").length == 0){
			alert("선택할 항목을 체크해 주세요!!!");
			return false;			
		}else 
			$("#checkboxForm").attr("action","/test/checkView.jsp").submit();
		
	});
	
});

function registerForm(){
	
	if(document.textForm.userid.value == ''){
		
		alert("아이디를 입력해 주세요");
		document.textForm.userid.focus();
		return false;
	}
	
	if(document.textForm.username.value == ''){
		
		alert("이름을 입력해 주세요");
		document.textForm.username.focus();
		return false;
	}
	
	var passwd1 = document.textForm.password1.value;
	var passwd2 = document.textForm.password2.value;
	
	if(passwd1 == ''){
		alert("패스워드를 입력해 주세요");
		document.textForm.password1.focus();
		return false;
	}
	
	if(passwd2 == ''){
		alert("패스워드 확인을 입력해 주세요");
		document.textForm.password2.focus();
		return false;
	}

	if(passwd1 != passwd2) {
		alert("패스워드 입력이 틀렸습니다");
		document.textForm.password2.focus();
		return false;		
	} 
	
	document.textForm.action = '/test/checkInfo.jsp';
	document.textForm.submit();
}	

</script>


</head>
<body>



<%@page import="java.util.*" %>

<%

	List<String> list = new ArrayList<>();
	list.add("자동차");
	list.add("비행기");
	list.add("탱크");
	list.add("잠수함");
	list.add("미사일");

%>

<h1>체크박스 연습</h1>

<form name="checkboxForm" id="checkboxForm" method="POST">

<table border=1>

	<tr>
		<td><input type="checkbox" name="selectAll" id="checkAll"></td>
		<td>목록</td>
	</tr>

<%
	for(int i=0;i<list.size(); i++){

%>

	<tr>
		<td><input type="checkbox" name="item" value="<%= list.get(i) %>"></td>
		<td><%= list.get(i) %></td>
	</tr>
	
<% } %>

</table>
<input type="button" value="선택" id="btn_select">

</form>

<h1>Input text 입력 연습</h1>
<form name="textForm" id="textForm" method="POST" enctype="multipart/form-data">

아이디 : <input type="text" name="userid" id="userid" placeholder="아이디를 입력하세요"><br> 
이름 : <input type="text" name="username" id="username" placeholder="이름을 입력하세요"><br>
패스워드 : <input type="password" name="password1" id="password1" ><br>
패스워드 확인: <input type="password" name="password2" id="password2"><br>
직업 : <select name="job" size="3">
	<option value="학생">학생</option>
	<option selected value="회사원">회사원</option>
	<option value="군인">군인</option>
	<option value="공무원">공무원</option>
	<option value="자영업">자영업</option>
</select><br>
인사말 <br>
<textarea name="helloText" cols="30" rows="5" wrap="soft" placeholder="인사말을 등록해 주세요">
</textarea>
<br>
<input type="file" name="upload" multiple>
<br>
<br>
<input type="button" name="btn_text" id="btn_text" value="등록" onclick="registerForm()">
<input type="reset" value="취소">

</form>



</body>
</html>