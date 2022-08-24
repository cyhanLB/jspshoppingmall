
<%@page import="javax.sql.DataSource"%>
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
	String userid = request.getParameter("userid");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String telno = request.getParameter("telno");
	String email = request.getParameter("email");
	
	//String url = "jdbc:mariadb://127.0.0.1:3306/webdev";
	//String user = "webmaster";
	//String pwd = "12345";

	Connection con = null;
	Statement stmt = null;

	try{
		
		//Class.forName("org.mariadb.jdbc.Driver");
		//con = DriverManager.getConnection(url, user, pwd);
		
		DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
		con = ds.getConnection();
		
		// insert into tbl_member (userid,username,password,telno,email,regdate) 
		// values (?,?,?,?,?,?)
	
		LocalDateTime now = LocalDateTime.now();
		String regdate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		
		String query = "insert into tbl_member "
	             + "(userid,username,password,telno,email,regdate, role) " 
				 + "values ('" + userid + "','" + username 
				 + "','" + password + "','" + telno + "','"
				 + email + "','" + regdate + "','user')";
		
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