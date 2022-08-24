<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%
	request.setCharacterEncoding("UTF-8");

	String u_id = request.getParameter("u_id");
	String u_pw = request.getParameter("u_pw");
	String u_name = request.getParameter("u_name");
	String u_email = request.getParameter("u_email");
	String zip_code = request.getParameter("zip_code");
	String u_address = request.getParameter("u_address");
	String u_address1 = request.getParameter("u_address1");
	String u_phone = request.getParameter("u_phone");


	Date currentDatetime = new Date(System.currentTimeMillis());
	java.sql.Date sqlDate = new java.sql.Date(currentDatetime.getTime());
	java.sql.Timestamp timestamp = new java.sql.Timestamp(currentDatetime.getTime());
%>

<sql:setDataSource var="dataSource"
	String url = "jdbc:mariadb://10.10.14.30:3306/webdev";
	String user = "shopManager";
	String pwd = "1234"; />

<sql:update dataSource="${dataSource}" var="resultSet">
   UPDATE MEMBER SET PASSWORD=?, NAME=?, GENDER=?, BIRTH=?, MAIL=?, PHONE=?, ADDRESS=? WHERE ID=?
	<sql:param value="<%=u_id%>" />
	<sql:param value="<%=u_pw%>" />
	<sql:param value="<%=u_name%>" />
	<sql:param value="<%=u_email%>" />
	<sql:param value="<%=zip_code%>" />
	<sql:param value="<%=u_address%>" />
	<sql:param value="<%=u_address1%>" />
	<sql:param value="<%=u_phone%>" />
	

</sql:update>

<c:if test="${resultSet>=1}">
	<c:redirect url="resultMember.jsp?msg=0" />
</c:if>

