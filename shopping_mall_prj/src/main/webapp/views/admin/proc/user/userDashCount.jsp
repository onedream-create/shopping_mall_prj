<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
AdminDAO aDAO = new AdminDAO();

String countNewUser = aDAO.countUserDashData("n");
String countSecUser = aDAO.countUserDashData("y");
String countAllUser = aDAO.countUserDashData("a");

HashMap<String, Object> hm = new HashMap<String, Object>();
hm.put("countNewUser", countNewUser);
hm.put("countSecUser", countSecUser);
hm.put("countAllUser", countAllUser);

JSONObject jo = new JSONObject(hm);
out.print(jo);
%>