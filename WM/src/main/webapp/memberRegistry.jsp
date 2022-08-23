<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page errorPage="error.jsp" %>
<%@page import="java.sql.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>사용자정보 등록</title>
</head>
<body>

<%

	request.setCharacterEncoding("utf-8");
	String u_id = request.getParameter("u_id");
	String u_pw = request.getParameter("u_pw");
	String u_name = request.getParameter("u_name");
	String u_email = request.getParameter("u_email");
	String zip_code = request.getParameter("zip_code");
	String u_address = request.getParameter("u_address");
	String u_address1 = request.getParameter("u_address1");
	String u_phone = request.getParameter("u_phone");
	
	
	String url = "jdbc:mariadb://127.0.0.1:3306/shop_db";
	String user = "root";
	String pwd = "1234";

	Connection con = null;
	Statement stmt = null;

	try{
		
		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection(url, user, pwd);
		
		// insert into tbl_member (u_id, u_pw, u_name, u_email, zip_code, u_address, u_phone, u_regdate) 
		// values (?,?,?,?,?,?,?,?)
	
		LocalDateTime now = LocalDateTime.now();
		String u_regdate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		
		String query = "insert into user "
	             + "(u_id, u_pw, u_name, u_email, zip_code, u_address, u_address1, u_phone, u_regdate) " 
				 + "values ('" + u_id + "','" + u_pw 
				 + "','" + u_name + "','" + u_email + "','"
				 + zip_code + "','" + u_address + "','" + u_address1 + "','" 
				 + u_phone + "','" + u_regdate + "')";
		
		//System.out.println(query);
	
		stmt = con.createStatement();
		stmt.executeUpdate(query);
		
		stmt.close();
		con.close();
		
		response.sendRedirect("index.jsp");

	}catch(Exception e){
		e.printStackTrace();
		stmt.close();
		con.close();
	}
	
	
%>

   
</body>
</html>