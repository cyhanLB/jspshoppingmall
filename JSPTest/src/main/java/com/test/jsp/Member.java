package com.test.jsp;


public class Member implements java.io.Serializable {

	private String userid;
	private String name;
	private int age;
	
	public Member() {};//자바빈즈 만들때는 반드시 넣어주어야 한다
	
	public Member(String userid, String name, int age) {
		
		this.userid = userid;
		this.name = name;
		this.age = age;
	}
	
	public String getUserid() {
		return userid;
	}

	public String getName() {
		return name;
	}

	public int getAge() {
		return age;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setAge(int age) {
		this.age = age;
	}
	
	
}
