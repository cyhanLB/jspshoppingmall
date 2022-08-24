<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>다운로드 테스트</title>
</head>
<body>

<%
  	
	String filename = request.getParameter("filename");

	byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("c:\\Repository\\file\\"+filename));
	
	response.setContentType("application/octet-stream");
	response.setContentLength(fileByte.length);
	response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(filename, "UTF-8")+"\";");
	response.getOutputStream().write(fileByte);
	response.getOutputStream().flush();
	response.getOutputStream().close();

%>


</body>
</html>