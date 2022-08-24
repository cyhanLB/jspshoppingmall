<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시물 수정</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<%

	request.setCharacterEncoding("utf-8");
	String userid = (String)session.getAttribute("userid");
	if(userid == null) response.sendRedirect("index.jsp");
	
	int seqno = Integer.parseInt(request.getParameter("seqno"));

%>

<script>

function registerForm(){

	if($("#mwriter").val()=='') { alert("이름을 입력하세요!!!"); $("#mwriter").focus(); return false;  }
	if($("#mtitle").val()=='') { alert("제목을 입력하세요!!!");  $("#mtitle").focus(); return false;  }
	if($("#mcontent").val()=='') { alert("내용을 입력하세요!!!");  $("#mcontent").focus(); return false;  }
	
	$("#WriteForm").attr("action", "modify_proc.jsp").submit();
	
}

</script>

<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }
a:link { color: black; }
a:visited { color: black; }
a:hover { color: red; }
a:active { color: red; }
#hypertext { text-decoration-line: none; cursor: hand; }

.WriteForm {
  width:900px;
  height:auto;
  padding: 20px, 20px;
  background-color:#FFFFFF;
  text-align: center;
  border:4px solid gray;
  border-radius: 30px;
}

#mwriter, #mtitle {
  width: 90%;
  border:none;
  border-bottom: 2px solid #adadad;
  margin: 20px;
  padding: 10px 10px;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
}

#mcontent{
  width: 850px;
  height: 300px;
  padding: 10px;
  box-sizing: border-box;
  border: solid #adadad;
  font-size: 16px;
  resize: both;
}

.btn_write  {
  position:relative;
  left:20%;
  transform: translateX(-50%);
  margin-top: 20px;
  margin-bottom: 10px;
  width:40%;
  height:40px;
  background: red;
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

.btn_cancel{
  position:relative;
  left:20%;
  transform: translateX(-50%);
  margin-top: 20px;
  margin-bottom: 10px;
  width:40%;
  height:40px;
  background: pink;
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}

</style>

</head>   
<body>

<%

 	//String url = "jdbc:mariadb://127.0.0.1:3306/webdev";
	//String uid = "webmaster";
	//String pwd = "12345";
	String query = "select mwriter,mtitle,mcontent from tbl_m1board where seqno=" + seqno; 
	System.out.println("[수정 보기 쿼리] : " + query);
	
	Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    String mwriter = "";
    String mtitle = "";
    String mcontent = "";
        
	try{
		
		//Class.forName("org.mariadb.jdbc.Driver");
		//con = DriverManager.getConnection(url, uid, pwd);

		DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
		con = ds.getConnection();
		
		stmt = con.createStatement();
		rs = stmt.executeQuery(query);
		
		while(rs.next()){ 
			
			mwriter = rs.getString("mwriter");
			mtitle = rs.getString("mtitle");
			mcontent = rs.getString("mcontent");
		}
		
	}catch(Exception e)	 {
		e.printStackTrace();
	}
	
	stmt.close();
	rs.close();
	con.close();
	
	

%>

<div align="center">
	<h1>게시물 수정</h1>
	<br>
	
	<form id="WriteForm" class="WriteForm" method="POST">
		<input type="text" id="mwriter" value="작성자 : <%=mwriter %> 님" disabled>
		<input type="hidden" name="seqno" value="<%=seqno %>">
		<input type="hidden" name="userid" value="<%=userid%>">
		<input type="text" id="mtitle" name="mtitle" value="<%=mtitle %>">
		<textarea id="mcontent" cols="100" rows="500" name="mcontent"><%=mcontent %></textarea>
		<br>
		<input type="button" class="btn_write" value="수정" onclick="registerForm()" />
		<input type="button" class="btn_cancel" value="취소" onclick="history.back()" />
	</form>
</div>
</body>
</html>