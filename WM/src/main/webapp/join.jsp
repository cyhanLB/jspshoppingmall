<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<!DOCTYPE html>
<html>
<head>
    <!--          meta 선언          -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!--          link 선언          -->
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/style_join.css">

    <!--          script 선언          -->
    <script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

    <script src="../js/script.js"></script>

    <title>회원가입</title>
</head>

<body>

    <div class="join_container">
        <h2>
            회원 가입
        </h2>
        	<form method="post" action="./join_Action.jsp">
            <h3>아이디</h3>
            <div class="joinID">
                <input type="text" class="input" style="ime-mode:disabled;" placeholder="아이디" name="userID" title="아이디" maxlength="20">
            </div>
            <h3>비밀번호</h3>
            <div class="joinPassword">
                <input type="password" class="input" placeholder="비밀번호" name="userPassword" title="비밀번호" maxlength="20">
            </div>
            <h3>이름</h3>
            <div class="joinName">
                <input type="text" class="input" placeholder="이름" name="userName" title="이름" maxlength="20">
            </div>
            <h3>이메일</h3>
            <div class="joinEmail">
           <input type="text" class="input" placeholder="이메일" name="userEmail" title="이메일" maxlength="40">
            </div>
            <h3>주소</h3>
             <div class="joinAddr">
             <input id="member_post"  class="input" type="text" name="userZipcode" placeholder="우편번호" readonly onclick="findAddr()"> <br>
             <input id="member_addr" class="input" type="text"  name="userAddr" placeholder="주소" readonly> <br>
             <input type="text" class="input" name="userAddr2" placeholder="상세 주소">
            </div>
            <h3>생년월일</h3>
            <div class="joinDate">
                <input type="date" class="input" name="userBirth" placeholder="생년월일" name="userDate">
            </div>
            <h3>성별</h3>
            <div class="joinGender">
                <input type="radio" name="userGender" name="userGender1" value="M" title="성별"> 남자
                <input type="radio" name="userGender" name="userGender2" value="F" title="성별"> 여자
            </div>
            <input type="submit" class="bt_join" value="회원가입">
        </form>
    </div>



<footer>
        <div class="footer_container">
            <div class="footA">
                JSP Shopping Mall
            </div>
            <div class="footB">
                Copyright © JSP Shopping Mall
            </div>
        </div>
    </footer>
</body>

<script>
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
            document.getElementById('member_post').value = data.zonecode;
            if(roadAddr !== ''){
                document.getElementById("member_addr").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("member_addr").value = jibunAddr;
            }
        }
    }).open();
}
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</html>