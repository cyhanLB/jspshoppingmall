
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인 테스트</title>

<script>

function filedownload(filename){
	
	document.location.href='/filedownload.jsp?filename=' + filename;
	
}
</script>

</head>
<body>

<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.*"%>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%

	String path = "C:\\Repository\\file";
	int uploadsize = 500*1024*1024;
	MultipartRequest multi = new MultipartRequest(request, path, uploadsize, "utf-8", new DefaultFileRenamePolicy());
	
	String userid = multi.getParameter("userid");
	String username = multi.getParameter("username");
	String password = multi.getParameter("password1");
	String job = multi.getParameter("job");
	String helloText = multi.getParameter("helloText");
	
	Enumeration files = multi.getFileNames();
	String name = (String)files.nextElement();
	
	String filename = multi.getFilesystemName(name);
	String original = multi.getOriginalFileName(name);
	 
	String password_org = "12345";

	//request.setCharacterEncoding("utf-8");
	/*
	String userid = request.getParameter("userid");
	String username = request.getParameter("username");
	String password = request.getParameter("password1");
	String job = request.getParameter("job");
	String helloText = request.getParameter("helloText");
	*/
	if(!password_org.equals(password)){

%>
	<script>
		alert("인증된 사용자가 아닙니다");
		document.location.href='/checkMain.jsp';
	</script>	
	
<% } %>	

<h1>사용자 로그인 정보</h1>
<table border=1>

	<tr>
		<td>아이디</td><td><%=userid %></td>
	</tr>
	<tr>
		<td>이름</td><td><%=username %></td>
	</tr>
	<tr>
		<td>패스워드</td><td><%=password %></td>
	</tr>
	<tr>
		<td>직업</td><td><%=job %></td>
	</tr>
	<tr>
		<td colspan=2>인사말</td>
	</tr>
	<tr>
		<td colspan=2><pre><%=helloText %></pre></td>
	</tr>	
	<tr>	
		<td>원본 파일 이름</td><td><%=original %></td>
	</tr>
		<tr>	
		<td>저장된 파일 이름</td><td><a href="javascript:filedownload('<%=filename %>')"><%=filename %></a></a></td>
	</tr>
	
	<tr>	
		<td>Form name</td><td><%=name %></td>
	</tr>
	
</table>

</body>
</html>