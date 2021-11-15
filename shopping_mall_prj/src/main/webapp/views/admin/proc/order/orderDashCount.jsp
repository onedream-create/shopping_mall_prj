<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
AdminDAO aDAO = new AdminDAO();

String countProcessing = aDAO.countOrderDashData("1");
String countInDelivery = aDAO.countOrderDashData("2");

HashMap<String, Object> hm = new HashMap<String, Object>();
hm.put("countProcessing", countProcessing);
hm.put("countInDelivery", countInDelivery);

JSONObject jo = new JSONObject(hm);
out.print(jo);
%>