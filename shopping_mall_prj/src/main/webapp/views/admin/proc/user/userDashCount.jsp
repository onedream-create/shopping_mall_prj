<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
AdminDAO aDAO = new AdminDAO();

String countNewUser = aDAO.countUserDashData("n");
String countSecUser = aDAO.countUserDashData("y");
String countAllUser = aDAO.countUserDashData("a");

JSONObject jo = new JSONObject();
jo.put("countNewUser", countNewUser);
jo.put("countSecUser", countSecUser);
jo.put("countAllUser", countAllUser);

out.print(jo);
%>