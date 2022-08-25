<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>사용자 정보 등록</title>
<script>

	$(document).ready(function(){
	
		$("#btn_register").click(function(){
			
			if($("#u_id").val() == '') { alert("아이디를 입력하세요."); $("#u_id").focus();  return false; }
			if($("#u_name").val() == '') { alert("이름을 입력하세요."); $("#u_name").focus(); return false; }
			var Pass = $("#u_pw").val();
			var Pass1 = $("#u_pw1").val();
			if(Pass == '') { alert("암호를 입력하세요."); $("#u_pw").focus(); return false; }
			if(Pass1 == '') { alert("암호를 입력하세요."); $("#u_pw1").focus(); return false; }
			if(Pass != Pass1) 
				{ alert("입력된 비밀번호를 확인하세요"); $("#u_pw1").focus(); return false; }
			
			// 암호유효성 검사
			var num = Pass.search(/[0-9]/g);
		 	var eng = Pass.search(/[a-z]/ig);
		 	var spe = Pass.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);	
			if(Pass.length < 8 || Pass.length > 20) { alert("암호는 8자리 ~ 20자리 이내로 입력해주세요."); return false; }
			else if(Pass.search(/\s/) != -1){ alert("암호는 공백 없이 입력해주세요."); return false; }
			else if(num < 0 || eng < 0 || spe < 0 ){ alert("암호는 영문,숫자,특수문자를 혼합하여 입력해주세요."); return false; }
			
			if($("#u_email").val() == '') { alert("이메일주소를 입력하세요."); $("#u_email").focus(); return false; }
			
			if($("#zip_code").val() == '') { alert("주소를 입력하세요."); $("#zip_code").focus(); return false; }
			
			if($("#u_address1").val() == '') { alert("상세 주소를 입력하세요."); $("#u_address1").focus(); return false; }
			
			if($("#u_phone").val() == '') { alert("전화번호를 입력하세요."); $("#u_phone").focus(); return false; }
		 	//전화번호 문자열 정리
			var beforeTelno = $("#u_phone").val();
		 	var afterTelno = beforeTelno.replace(/\-/gi,"").replace(/\ /gi,"").trim();
		 	//console.log("afterTelno : " + afterTelno);
		 	$("#u_phone").val(afterTelno);
		 	
			
			$("#registerForm").attr("action","memberRegistry.jsp").submit();	
		});
	});
	

function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
        	
        	console.log(data);
        	
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zip_code').value = data.zonecode;
            if(roadAddr !== ''){
                document.getElementById("u_address").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("u_address").value = jibunAddr;
            }
        }
    }).open();
}
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  
  
  
  
</head>
<body>
<br><br><br>

<div class="main" align="center">
  <div class="registerForm">
	      
    <h1>사용자 등록</h1>
    <form name="registerForm" id="registerForm" method="post"> 
        <h3>아이디</h3>
        <input type="text" id="u_id" name="u_id" class="u_id" placeholder="아이디를 입력하세요.">
        <p id="checkID" style="color:red;text-align:center;"></p>
        <h3>이름</h3>
		<input type="text" id="u_name" name="u_name" class="u_name" placeholder="이름을 입력하세요.">
        <h3>비밀번호</h3>
        <input type="password" id="u_pw" name="u_pw" class="u_pw" placeholder="암호를 입력하세요.">
        <p style="color:red;text-align:center;">※ 8~20이내의 영문자, 숫자, 특수문자 조합으로 암호를 만들어 주세요.</p>
        <h3>비밀번호 확인</h3>
        <input type="password" id="u_pw1" name="u_pw1" class="u_pw1" placeholder="암호를 한번 더 입력하세요.">
        <h3>이메일</h3>
        <input type="text" id="u_email" name="u_email" class="u_email" placeholder="이메일주소를 입력하세요.">
        <h3>주소</h3>
        <p style="color:red;text-align:center;">※ 상세주소를 꼭 입력해 주세요.</p>
        <input type="text" id="zip_code"  name="zip_code" class="input" placeholder="우편번호" readonly onclick="findAddr()">
        <input type="text" id="u_address" name="u_address" class="input" placeholder="주소" readonly>
        <input type="text" id="u_address1" name="u_address1"class="input" placeholder="상세 주소">
        <h3>전화번호</h3>
        <input type="text" id="u_phone" name="u_phone" class="u_phone" placeholder="전화번호를 입력하세요.">
      
      
        <input type="button" id="btn_register" class="btn_register" value="사용자 등록">
        <input type="button" id="btn_cancel" class="btn_cancel" value="취소" onclick="history.back()">
	  </form>

  </div>
</div>
<br><br>
</body>
</html>