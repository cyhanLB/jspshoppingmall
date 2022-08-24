<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="java.util.*,
    com.google.gson.Gson,
    com.google.gson.JsonObject" %>
<%
   request.setCharacterEncoding("utf-8");
   String userid = request.getParameter("userid");
   String uid = "admin";

   Gson gson = new Gson();
   JsonObject obj = new JsonObject();
   if(uid.equals(userid)) {
      obj.addProperty("result", "ok");
      obj.addProperty("userid", userid);
      obj.addProperty("username", "admin");
      obj.addProperty("email", "admin@localhost");
   } else {
      obj.addProperty("result", "ng");
   }
   
   System.out.println("gson.toJson(obj) = " + gson.toJson(obj));
   out.print(gson.toJson(obj));
%>