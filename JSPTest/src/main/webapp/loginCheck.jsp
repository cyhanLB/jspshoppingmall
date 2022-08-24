<%@page import="javax.sql.DataSource"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>      
<%@page import="java.sql.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Locale"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인 체크</title>
</head>
<body>

<fmt:setLocale value="en" scope="page"/>

<%

	request.setCharacterEncoding("utf-8");
	
	//로그인 창에서 파리미터로 받은 값
	String userid = request.getParameter("userid");
	String password = request.getParameter("password");
	
	//DB에서 사용자 정보(아이디랑 패스워드 가져 오기)
	//String url = "jdbc:mariadb://127.0.0.1:3306/webdev";
	//String user = "webmaster";
	//String pwd = "12345";

	Connection con = null;
	
	Statement stmt1 = null;
	Statement stmt2 = null;
	Statement stmt3 = null;
	Statement stmt4 = null;
	Statement stmt5 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	
	int id_count = 0;
	int pwd_count = 0;
	
	//LocalDateTime now = LocalDateTime.now();
	//String lastlogindate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));	
	String lastlogindate = LocalDateTime.now().toString();
	
	//존재하는 아이디 인지 확인
	String query1 = "select count(*) as id_count from tbl_member where userid= '" + userid + "'";
	//패스워드가 틀렸는지 확인
	String query2 = "select count(*) as id_count from tbl_member " 
			+ "where userid='" + userid + "' and "
			+ "password='" + password + "'";
	//마지막 접속 시간 등록
	String query3 = "update tbl_member set lastlogindate = '" + lastlogindate 
			      + "' where userid = '" + userid + "'";
	String query4 = "insert into tbl_member_log (userid,inouttime,status) " 
			      + "values ('" + userid + "','" + lastlogindate + "','IN')";
	String query5 = "select username,role from tbl_member where userid = '" + userid + "'";
	
	try{
		
		//Class.forName("org.mariadb.jdbc.Driver");
		//con = DriverManager.getConnection(url, user, pwd);
				
		DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
		con = ds.getConnection();
		
		stmt1 = con.createStatement();
		stmt2 = con.createStatement();
		stmt5 = con.createStatement();
		
		rs1 = stmt1.executeQuery(query1);
		rs2 = stmt2.executeQuery(query2);
		rs3 = stmt5.executeQuery(query5);
		
		String username = "";
		String role = "";
		while(rs1.next()) id_count = rs1.getInt("id_count");
		while(rs2.next()) pwd_count = rs2.getInt("id_count");
		while(rs3.next()) { 
			username = rs3.getString("username");
			role = rs3.getString("role");
		}
		
		//아이디가 존재하고 패스워드도 틀리지 않은 사용자
		if(id_count != 0 && pwd_count !=0){
			
			session.setMaxInactiveInterval(3600*7); //세션 유지 기간 설정
			session.setAttribute("userid", userid); //세션 생성
			session.setAttribute("username", username);
			session.setAttribute("role", role);
			
			
			stmt3 = con.createStatement();
			stmt3.executeUpdate(query3);
			
			stmt4 = con.createStatement();
			stmt4.executeUpdate(query4);
						
			stmt1.close();
			stmt2.close();
			stmt3.close();
			stmt4.close();
			stmt5.close();
			rs1.close();
			rs2.close();
			rs3.close();
			con.close();
			
			Locale locale = request.getLocale();
			
			String lang = locale.getLanguage();
			System.out.println("로그인 언어 :" + lang);
			
			response.sendRedirect("welcome.jsp");
			
		} else if(id_count == 0){ //아이디가 존재하지 않는 사용자

			stmt1.close();
			stmt2.close();
			rs1.close();
			rs2.close();
			con.close();
						
%>			
			<script>
				
				alert("사용자가 존재하지 않습니다.");
				document.location.href='index.jsp';
				
			</script>	
<% 	
		}else if(id_count!=0 && pwd_count == 0){ //아이디는 있으나 패스워드가 틀린 사용자
		
			stmt1.close();
			stmt2.close();
			rs1.close();
			rs2.close();
			con.close();

%>			
	
			<script>
				
				alert("패스워드를 잘못 입력 했습니다.");
				document.location.href='index.jsp';
				
			</script>
			
<% 		 
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}

%>

</body>
</html>