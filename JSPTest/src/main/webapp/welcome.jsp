
<%@page import="javax.sql.DataSource"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.sql.*"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>환영 페이지</title>
</head>
<body>

<%

	String userid = (String)session.getAttribute("userid");
	if(userid == null) response.sendRedirect("index.jsp");

	String regdate = "";
	String lastlogindate = "";
	String inouttime = "";

 	//String url = "jdbc:mariadb://127.0.0.1:3306/webdev";
	//String uid = "webmaster";
	//String pwd = "12345";
	String query1 = "select regdate, to_char(lastlogindate,'YYYY-MM-DD HH24:MI:SS') as lastlogindate from tbl_member where userid = '" 
	              + userid + "'"; 
	
	String query2 = "select max(to_char(inouttime,'YYYY-MM-DD HH24:MI:SS')) as inouttime from tbl_member_log where userid = " 
					+ "'" + userid + "' and status='OUT'";

	System.out.println("tbl_member_log 쿼리 : " + query2);
	
	Connection con = null;
    Statement stmt1 = null;
    ResultSet rs1 = null;
    Statement stmt2 = null;
    ResultSet rs2 = null;
    
	try{
		
		//Class.forName("org.mariadb.jdbc.Driver");
		//con = DriverManager.getConnection(url, uid, pwd);
		
		DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
		con = ds.getConnection();

		stmt1 = con.createStatement();
		rs1 = stmt1.executeQuery(query1);
		
		while(rs1.next()) {
			regdate = rs1.getString("regdate");
			lastlogindate = rs1.getString("lastlogindate");
		}
		
		stmt2 = con.createStatement();
		rs2 = stmt2.executeQuery(query2);
		
		while(rs2.next()) inouttime = rs2.getString("inouttime");
		
	}catch(Exception e)	 {
		e.printStackTrace();
	}
	
	stmt1.close();
	stmt2.close();
	rs1.close();
	rs2.close();
	
	con.close();
		
%>

<!-- <fmt:setLocale value="ko" /> --> 
<fmt:setBundle basename="Bundle.message" var="resourceBundle" />

<h1><%=session.getAttribute("userid") %>, <fmt:message key="hello" bundle="${resourceBundle}"/> </h1>

<fmt:setLocale value="en" />
<fmt:setBundle basename="Bundle.message" var="resourceBundle" />

<h1><%=session.getAttribute("userid") %>, <fmt:message key="hello" bundle="${resourceBundle}"/></h1>


<h1>회원 가입일 : <%=regdate %></h1>
<h1>마지막 로그인 날짜 : <%=lastlogindate %></h1>
<h1>마지막 로그아웃 날짜 : <%=inouttime %></h1>

<h1>[ <a href="list.jsp?page=1">게시판 가기</a> ] | [ <a href="logout.jsp">로그아웃</a> ]</h1>

</body>
</html>