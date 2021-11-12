<%@page import="java.io.File"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
String fileName = request.getParameter("fileName");
String saveDirectory = pageContext.getServletContext().getRealPath("/common/uploadImg/pro_detail");

File target = new File(saveDirectory+File.separator+fileName);

if(target.exists()) {
	target.delete();
} 
%>