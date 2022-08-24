<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>자바빈즈 테스트</title>
</head>

<body>
	<%@ page import="java.util.ArrayList" %>
	<%@ page import="java.util.List" %>
	<%@ page import="com.test.jsp.Member" %>

	<jsp:useBean id="member" class="com.test.jsp.Member" scope="page"/>

	
	<%
		//member.setName("김철수");
	%>
	
	<!-- <h1>멤버 누구? <%=member.getName()%> 입니다. </h1>  -->
	
	<jsp:setProperty name="member" property="userid" value="hongsam"/>
	<jsp:setProperty name="member" property="name" value="박민정"/>
	<jsp:setProperty name="member" property="age" value="32"/>
	
	<h1>getter로 불러 오기</h1>
	<h1>멤버 정보 -> 아이디: <%=member.getUserid() %> 입니다. </h1>
	<h1>멤버 정보 -> 이름: <%=member.getName() %> 입니다. </h1>
	<h1>멤버 정보 -> 나이: <%=member.getAge() %> 입니다. </h1>
	
	<h1>getProperty로 불러 오기</h1>
	<h1>멤버 정보 -> 아이디: <jsp:getProperty name="member" property="userid" /> 입니다. </h1>
	<h1>멤버 정보 -> 이름: <jsp:getProperty name="member" property="name" /> 입니다. </h1>
	<h1>멤버 정보 -> 나이: <jsp:getProperty name="member" property="age" /> 입니다. </h1>


	<br>
	<table border=1>

	<%
	
		List<Member> list = new ArrayList<>();
	 	
	    list.add(new Member("xavier", "김철수", 35));
	    list.add(new Member("catalina", "김희주", 32));
	    list.add(new Member("mango", "김민주", 22));
	    
	    for(Member m:list){
	
	%>

	<tr>
		<td><% out.println(m.getUserid()); %></td>
		<td><%=m.getName() %></td>
		<td><%=m.getAge() %></td>
	</tr>
	
	<%} %>

	</table>




</body>
</html>