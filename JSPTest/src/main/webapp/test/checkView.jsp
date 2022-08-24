<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>체크박스 값 가져 오기</title>
</head>
<body>

<%

	request.setCharacterEncoding("utf-8");
	String[] item = request.getParameterValues("item");

	for(String str:item){

%>

	<%=str %>

<% } %>

</body>
</html>