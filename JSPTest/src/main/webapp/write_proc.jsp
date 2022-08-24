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

	//파일 업로드 처리 부분
	String path = "C:\\Repository\\file";
	int uploadsize = 500*1024*1024;
	MultipartRequest multi = new MultipartRequest(request, path, uploadsize, "utf-8", new DefaultFileRenamePolicy());

	String userid = multi.getParameter("userid");
	String mwriter = multi.getParameter("mwriter");
	String mtitle = multi.getParameter("mtitle");
	String mcontent = multi.getParameter("mcontent");
	String mregdate = LocalDateTime.now().toString();
	int filesize = 0;
		
	Enumeration files = multi.getFileNames();
	String name = (String)files.nextElement();
	
	String originalFileName = multi.getOriginalFileName(name); //오리지널 파일명을 가져 온다.
	String storedFileName = "";
	
	if(originalFileName != null){
		//변경되기 전 파일 이름에서 확장자 분리
		String originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
		//난수값을 발생시켜 새로운 파일명 생성 
		storedFileName = UUID.randomUUID().toString().replaceAll("-","") + originalFileExtension;
	}

	String changedFileName = multi.getFilesystemName(name); //바꾼 파일명을 가져 온다
	
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
	
		String query = "insert into tbl_m1board "
	             + "(userid,mwriter,mtitle,mcontent,org_filename,stored_filename,filesize, mregdate) "
				 + "values ('" + userid + "','" + mwriter 
				 + "','" + mtitle + "','" + mcontent + "','"
				 + originalFileName + "','" + storedFileName + "'," + filesize + ",'" + mregdate + "')";
		
		System.out.println("[게시판 등록 쿼리 ] : " + query);
	
		stmt = con.createStatement();
		stmt.executeUpdate(query);
		
		stmt.close();
		con.close();
		
		File file = new File(path + "\\" + changedFileName);
		if(file.exists()) file.renameTo(new File(path + "\\" + storedFileName));
		
		response.sendRedirect("list.jsp?page=1");

	}catch(Exception e){
		e.printStackTrace();
		stmt.close();
		con.close();
	}

%>

</body>
</html>