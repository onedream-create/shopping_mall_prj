<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
AdminDAO aDAO = new AdminDAO();

String countAll = aDAO.countProDashData("a");
String countSellY = aDAO.countProDashData("y");
String countSellN = aDAO.countProDashData("n");

HashMap<String, Object> hm = new HashMap<String, Object>();
hm.put("countAll", countAll);
hm.put("countSellY", countSellY);
hm.put("countSellN", countSellN);

JSONObject jo = new JSONObject(hm);
out.print(jo);
%>