<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
AdminDAO aDAO = new AdminDAO();

String countAll = aDAO.countProDashData("a");
String countSellY = aDAO.countProDashData("y");
String countSellN = aDAO.countProDashData("n");


JSONObject jo = new JSONObject();
jo.put("countAll", countAll);
jo.put("countSellY", countSellY);
jo.put("countSellN", countSellN);

out.print(jo);
%>