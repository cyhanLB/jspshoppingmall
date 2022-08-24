<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>게시물 내용 보기</title>

<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }
a:link { color: black; }
a:visited { color: black; }
a:hover { color: red; }
a:active { color: red; }
#hypertext { text-decoration-line: none; cursor: hand; }

.boardView {
  width:900px;
  height:auto;
  padding: 20px, 20px;
  background-color:#FFFFFF;
  border:4px solid gray;
  border-radius: 20px;
}

.mwriter, .mtitle, .mregDate, .mcontent, .filename {
  width: 90%;
  height:25px;
  outline:none;
  color: #636e72;
  font-size:16px;
  background: none;
  border-bottom: 2px solid #adadad;
  margin: 30px;
  padding: 10px 10px;
  text-align: left;
}

.textArea {
  width: 90%;
  height: 350px;
  overflow: auto;
  margin: 22px;
  padding: 10px;
  box-sizing: border-box;
  border: solid #adadad;
  text-align: left;
  font-size: 16px;
  resize: both;
}

.replyDiv {
  margin-top: 30px;
  margin-left: 200px;
  margin-right: 200px;
  background-color:#FFFFFF;
  border:4px solid white;
  border-radius: 20px;
}

.bottom_menu { margin-top: 20px; }

.bottom_menu > a:link, .bottom_menu > a:visited {
			background-color: #FFA500;
			color: maroon;
			padding: 15px 25px;
			text-align: center;	
			display: inline-block;
			text-decoration : none; 
}
.bottom_menu > a:hover, .bottom_menu > a:active { 
	background-color: #1E90FF;
	text-decoration : none; 
}


</style>

<%
	
	String session_userid = (String)session.getAttribute("userid");
	String session_username = (String)session.getAttribute("username");
	String role = (String)session.getAttribute("role");
	if(session_userid == null) response.sendRedirect("index.jsp");
	request.setCharacterEncoding("utf-8");
	String seqno = request.getParameter("seqno");
%>

<script>

function mDelete(){
	if(confirm("정말 삭제 하시겠습니까?")==true) location.href='/delete.jsp?seqno=<%=seqno %>'
}

function fileDownload(){
	
	location.href='/fileDownload.jsp?seqno=<%=seqno %>';
}

function replyRegister(){
	
	if($("#replycontent").val() == "") {
		alert("댓글을 입력하세요."); 
		$("#replycontent").focus(); 
		return false;
	}
	
	//Form문 안에 있는 항목들 값을 AJAX로 전송하기 위해서는serialize를 해줘야 한다.
	var queryString = $("form[name=replyForm]").serialize();
	
	$.ajax({
		url : "reply.jsp?option=I",
		type : "post",
		datatype : "json",
		data : queryString,
		success : replyList,
		error : function(data) {
					alert("서버오류 문제로 댓글 등록이 실패 했습니다. 잠시 후 다시 시도해주시기 바랍니다.");
              	    return false;
		}
	}); 
	$("#replycontent").val("");
}

function replyList(data){
	
	var session_userid = '<%= session_userid %>';
	var jsonInfo = JSON.parse(data);
	console.log("jsonInfo = " + jsonInfo);
	var result = "";
	
	for(const i in jsonInfo){
		
		result += "<div id='replyListView'>";
		result += "<div id = '" + jsonInfo[i].replyseqno + "' style='font-size:0.8em'>";
		result += "작성자 : " + jsonInfo[i].replywriter;
		
		if(jsonInfo[i].userid == session_userid){
			result += "[<a href=" + "'javascript:replyModify(" + jsonInfo[i].replyseqno + ")' style='cursor:pointer;'>수정</a> | ";
			result += "<a href=" + "'javascript:replyDelete(" + jsonInfo[i].replyseqno + ")' style='cursor:pointer;'>삭제</a>]"
		}
		
		result += "&nbsp;&nbsp;" + jsonInfo[i].replyregdate;
		result += "<div style='width:90%;height:auto;border-top:1px solid gray;overflow:auto;'>";
		result += "<pre class='" + jsonInfo[i].replyseqno + "'>" + jsonInfo[i].replycontent + "</pre></div>";
		result += "</div></div><br>"
		
	}
	$("#replyListView").remove();
	$("#replyList").html(result);
	
} 

function replyList_delete(data){
	
	var session_userid = '<%= session_userid %>';
	var jsonInfo0 = JSON.stringify(data);
	var jsonInfo = JSON.parse(jsonInfo0);
	console.log("jsonInfo = " + jsonInfo);
	var result = "";
	
	for(const i in jsonInfo){
		
		result += "<div id='replyListView'>";
		result += "<div id = '" + jsonInfo[i].replyseqno + "' style='font-size:0.8em'>";
		result += "작성자 : " + jsonInfo[i].replywriter;
		
		if(jsonInfo[i].userid == session_userid){
			result += "[<a href=" + "'javascript:replyModify(" + jsonInfo[i].replyseqno + ")' style='cursor:pointer;'>수정</a> | ";
			result += "<a href=" + "'javascript:replyDelete(" + jsonInfo[i].replyseqno + ")' style='cursor:pointer;'>삭제</a>]"
		}
		
		result += "&nbsp;&nbsp;" + jsonInfo[i].replyregdate;
		result += "<div style='width:90%;height:auto;border-top:1px solid gray;overflow:auto;'>";
		result += "<pre class='" + jsonInfo[i].replyseqno + "'>" + jsonInfo[i].replycontent + "</pre></div>";
		result += "</div></div><br>"
		
	}
	$("#replyListView").remove();
	$("#replyList").html(result);
	
} 

function replyModify(replyseqno){
	
	var replyContent = $("." + replyseqno).html();
	
	var strReplyList = "<form id='formModify' name='formModify' method='POST'>"
		+ "작성자 : <%=session_username %>&nbsp;"
		+ "<input type='button' id='btn_replyModify' value='수정'>"
		+ "<input type='button' id='btn_replyModifyCancel' value='취소'>"
		+ "<input type='hidden' name='replyseqno' value='" + replyseqno + "'>"
		+ "<input type='hidden' name='seqno' value='<%=seqno %>'>"
		+ "<input type='hidden' name='replywriter' value='<%=session_username %>'>"
		+ "<input type='hidden' name='userid' value='<%=session_userid %>'><br>"
		+ "<textarea id='replycontent' name='replycontent' cols='80' rows='5' maxlength='150' placeholder='글자수:150자 이내'>" + replyContent + "</textarea><br>"
		+ "</form>";
		
	$("#" + replyseqno).after(strReplyList);
	$("#" + replyseqno).remove();
	
	$("#btn_replyModify").on("click", function(){
		var queryString = $("form[name=formModify]").serialize();
		$.ajax({
			url : "reply.jsp?option=U",
			type : "post",
			dataType : "json",
			data : queryString,
			success : replyList_delete,
			error : function(data) {
							alert("서버오류 문제로 댓글 등록이 실패 했습니다. 잠시 후 다시 시도해주시기 바랍니다.");
	              	    	return false;
			}
		}); //End of $.ajax
	 }); //End of $("#btn_replyModify")
	
	 $("#btn_replyModifyCancel").on("click", function(){
		 if(confirm("정말로 취소하시겠습니까?") == true  ) { $("#replyListView").remove(); startupPage(); }
	 });
	
}

function replyDelete(replyseqno){
	
	if(confirm("정말로 삭제하시겠습니까?") == true) {
		var queryString =  {"list": [replyseqno, <%=seqno %>]};
		
		$.ajax({
			url : "reply.jsp?option=D",
			type : "post",
			data : queryString,
			dataType : "json",
			success : replyList_delete,
			error : function(data) {
						alert("서버오류 문제로 댓글 등록이 실패 했습니다. 잠시 후 다시 시도해주시기 바랍니다.");
	            		return false;
			}
		}); //End od ajax
	}
}

function startupPage(){
	
	var queryString = {"seqno": "<%=seqno %>"};
	
	$.ajax({
		url : "reply.jsp?option=L",
		type : "post",
		datatype : "json",
		data : queryString,
		success : replyList,
		error : function(data) {
						alert("서버 오류로 댓글 불러 오기가 실패했습니다.");
              	    	return false;
				}
	}); //End od ajax
	
}

</script>

<body onload="startupPage()">

<% 	
	//String url = "jdbc:mariadb://127.0.0.1:3306/jspdev";
	//String uid = "webmaster";
	//String pwd = "@Ajendbh7!";
	
	//게시물 내용 보기
	String query1 = "select userid,mwriter,mtitle,to_char(mregdate, 'YYYY-MM-DD HH24:MI:SS') as mregdate,mcontent,hitno,org_filename,stored_filename "
				+ "from tbl_m1board where seqno =" + seqno; 
	//게시물 이전 보기
	String query2 = "select max(seqno) as seqno from tbl_m1board where seqno < " + seqno;
	//게시물 다음 보기
	String query3 = "select min(seqno) as seqno from tbl_m1board where seqno > " + seqno;
		
	//System.out.println(query1);
	
	Connection con = null;
	Statement stmt1 = null;
	Statement stmt2 = null;
	Statement stmt3 = null;
	Statement stmt4 = null;
	
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	
	String db_userid = "";
	String mwriter = "";
	String mtitle = "";
	String mregdate = "";
	String mcontent = "";
	int hitno = 0;
	String org_filename = "";
    
	//게시판 내용 보기
	try{
	
		DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
		con = ds.getConnection();
		//Class.forName("org.mariadb.jdbc.Driver");
		//con = DriverManager.getConnection(url, uid, pwd);
	
		stmt1 = con.createStatement();
		rs1 = stmt1.executeQuery(query1);
		
		while(rs1.next()) {
			db_userid = rs1.getString("userid");
			mwriter = rs1.getString("mwriter");
			mtitle = rs1.getString("mtitle");
			mregdate = rs1.getString("mregdate");
			mcontent = rs1.getString("mcontent");
			hitno = rs1.getInt("hitno");
			org_filename = rs1.getString("org_filename");
		}
		
	}catch(Exception e){
			e.printStackTrace();
	}
		
	stmt1.close();
	rs1.close();
		
	//이전 글 , 다음 글
	int pre_seqno = 0;
	int next_seqno = 0;
	try{
		
		stmt2 = con.createStatement();
		rs2 = stmt2.executeQuery(query2);
				
		while(rs2.next()) pre_seqno = rs2.getInt("seqno"); //이전글 
		
		stmt3 = con.createStatement();
		rs3 = stmt3.executeQuery(query3);
				
		while(rs3.next()) next_seqno = rs3.getInt("seqno"); //다음글
		
	}catch(Exception e){
			e.printStackTrace();
	}
	

	stmt2.close();
	stmt3.close();
	rs2.close();
	rs3.close();

	
	//조회수 증가
	
	if(!session_userid.equals(db_userid)) {
	
		hitno++;
		String query4 = "update tbl_m1board set hitno = " + hitno + " where seqno=" + seqno;
		//System.out.println(query4);
		try{
			stmt4 = con.createStatement();
			stmt4.executeUpdate(query4);
			stmt4.close();
		}catch(Exception e){
			e.printStackTrace();
			stmt4.close();
		}
	}

	con.close();
		
%>

<div class="main" align="center">
	<h1>게시물 내용 보기</h1>
	<br>
	<div class="boardView">
		<div class="mwriter">이름 : <%=mwriter %></div>
		<div class="mtitle">제목 : <%=mtitle %></div>
		<div class="mregDate">날짜 : <%=mregdate %></div>
		<div class="textArea"><pre><%=mcontent %></pre></div>
		<% if(!org_filename.equals("null")){ %>
			<div class="filename">파일명 : <a href="javascript:fileDownload()"><%=org_filename %></a></div>
		<% } else {%>
			<div class="filename">업로드된 파일이 없습니다.</div>
		<% } %>	
	</div>

	<div class="bottom_menu">
		<% if(pre_seqno !=0){ %>
				&nbsp;&nbsp;<a href="view.jsp?seqno=<%=pre_seqno %>" onMouseover="this.style.textDecoration='underline';" 
					onmouseout="this.style.textDecoration='none';">이전글 ▼</a> &nbsp;&nbsp;
		<% } %>		
			<a href="list.jsp?page=1" onMouseover="this.style.textDecoration='underline';" 
					onmouseout="this.style.textDecoration='none';">목록보기</a> &nbsp;&nbsp;

		<% if(next_seqno !=0){ %>
			<a href="view.jsp?seqno=<%=next_seqno %>" onMouseover="this.style.textDecoration='underline';" 
						onmouseout="this.style.textDecoration='none';">다음글 ▲</a> &nbsp;&nbsp;
		<% } %>	
			<a href="write.jsp" onMouseover="this.style.textDecoration='underline';" 
					onmouseout="this.style.textDecoration='none';">글 작성</a> &nbsp;&nbsp;
		<% if(session_userid.equals(db_userid) || role.equals("admin")) {%>
			<a href="modify.jsp?seqno=<%=seqno %>" onMouseover="this.style.textDecoration='underline';" 
					onmouseout="this.style.textDecoration='none';">글 수정</a> &nbsp;&nbsp;
			<a href="javascript:mDelete()" onMouseover="this.style.textDecoration='underline';" 
						onmouseout="this.style.textDecoration='none';">글 삭제</a> &nbsp;&nbsp;
		<%} %>				
	</div>
	
	<div class="replyDiv" style="text-align:left;">
	
		<p id="replyNotice">댓글을 작성해 주세요</p>
		<form id="replyForm" name="replyForm" method="POST">
			작성자 : <input type="text" id="replywriter" name="replywriter" value=<%=session_username %> disabled><br>
			<textarea id="replycontent" name="replycontent" cols="80" rows="5" maxlength="150" placeholder="글자수:150자 이내"></textarea><br>
			<input type="hidden" name="seqno" value="<%=seqno %>">
			<input type="hidden" name="replywriter" value="<%=session_username %>"> 
			<input type="hidden" name="userid" value="<%=session_userid %>">
		</form>
		<input type="button" id="btn_mreply" value="댓글등록" onclick="replyRegister()"> 
		<hr>
		
		<div id="replyList" style="width:100%;height:600px;overflow:auto;">
			<div id="replyListView"></div>
		</div>
	</div>
	
</div>
</body>
</html>