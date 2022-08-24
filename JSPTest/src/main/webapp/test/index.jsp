<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>JSP 프로젝트</title>
</head>
<body>

<%-- 요건 JSP --%>

<h1>나의 첫 JSP 프로젝트...</h1>
<%!

class A{
	
	int c = 100;
	
	public int getC(){
		
		return this.c;
	}
	
}
%>

<%

	String name = "김현우";

	int i = 0;
	int result = 0;
	int c;
	
	for(i=0;i<=100;i++)
		result+=i;
	
	A a = new A();
	c = a.getC();
    
%>
  <h1>안녕하세요? 나는 <%=name %>입니다.</h1>
  <br>
  <h1>1부터 100까지의 합은 <%=result %>입니다.</h1>
  <br>
  <h1>변수 C의 값은 <%=c %>입니다.</h1>
<br>
<a href=/test/person.jsp>배열 리스트 출력하기 예제</a><br>
<a href=/test/member.jsp>자바빈즈 이해을 위한 예제</a><br>
<a href=/test/checkMain.jsp>폼문 및 체크박스 이해를 위한 예제</a><br>



<jsp:include page="person.jsp"></jsp:include>

</body>
</html>