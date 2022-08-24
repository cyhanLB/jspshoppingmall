<%@page import="javax.sql.DataSource"%>
<%@page import="java.io.File"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>

<%
 
	request.setCharacterEncoding("utf-8");
	int seqno = Integer.parseInt(request.getParameter("seqno"));
	String mtitle = request.getParameter("mtitle");
	String mcontent = request.getParameter("mcontent");

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
	
		String query = "update tbl_m1board set mtitle = '" + mtitle + "',"
				      + "mcontent = '" + mcontent + "' where seqno = " + seqno;
		
		System.out.println("[게시판 수정 쿼리 ] : " + query);
	
		stmt = con.createStatement();
		stmt.executeUpdate(query);
		
		stmt.close();
		con.close();
		
		response.sendRedirect("view.jsp?seqno=" + seqno);

	}catch(Exception e){
		e.printStackTrace();
		stmt.close();
		con.close();
	}

%>

</body>
</html>