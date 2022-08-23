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
    <link rel="stylesheet" href="../css/style_login.css">

    <!--          script 선언          -->
    <script src="https://kit.fontawesome.com/e1bd1cb2a5.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>

    <script src="../js/script.js"></script>

    <title>Login</title>
</head>
<body>
    <div class="login_containers">
        <h2>
            로그인
        </h2>
        <form method="post" action="./login_Action.jsp">
            <h3>아이디</h3>
            <div class="loginID">
                <input type="text" class="input" placeholder="아이디" name="userID" maxlength="20">
            </div>
            <h3>비밀번호</h3>
            <div class="loginPassword">
                <input type="password" class="input" placeholder="비밀번호" name="userPassword" maxlength="20">
            </div>
            <br><a class="menu_title" href="./join.jsp">회원가입</a><br>
            <br><input type="submit" class="bt_login" value="로그인">
        </form>
    </div>
    
   <br><footer>
        <div class="footer_container">
            <div class="footA">
                JSP ShoppingMall
            </div>
            <div class="footB">
                Copyright © JSP ShoppingMall All Rights Reserved.
            </div>
        </div>
    </footer>
</body>
</html>