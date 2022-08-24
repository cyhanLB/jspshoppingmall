<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>JSP 테스트</title>
</head>

<body>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%!
 public class Person{
	
	private String name;
	private String gender;
	private int age;
	
	public Person(String name,String gender,int age){
		this.name = name;
		this.gender = gender;
		this.age = age;
	}
	
	public String getName(){
		return this.name;
	}
	
	public String getGender(){
		return this.gender;
	}
	
	public int getAge(){
		return this.age;
	}
}

%>

<h1>배열 리스트 출력하기 예제</h1>
<br>
<table border=1>

<%

	List<Person> list = new ArrayList<>();
	list.add(new Person("김현우","남자",54));
	list.add(new Person("김현주","여자",52));
	list.add(new Person("박길동","남자",52));
	
	for(Person person:list){
%>

	<tr>
		<td><% out.println(person.getName()); %></td>
		<td><%=person.getGender() %></td>
		<td><%=person.getAge() %></td>
	</tr>

<% } %>




</table>
</body>
</html>