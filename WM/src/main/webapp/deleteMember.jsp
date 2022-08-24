<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%
	String sessionId = (String) session.getAttribute("u_id");
%>
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/webdev"
	driver="com.mariadb.jdbc.Driver" user="shopManager" password="1234" />

<sql:update dataSource="${dataSource}" var="resultSet">
   DELETE FROM member WHERE id = ?
   <sql:param value="<%=sessionId%>" />
</sql:update>

<c:if test="${resultSet>=1}">
	<c:import var="url" url="logout.jsp" />
	<c:redirect url="resultMember.jsp" />
</c:if>
