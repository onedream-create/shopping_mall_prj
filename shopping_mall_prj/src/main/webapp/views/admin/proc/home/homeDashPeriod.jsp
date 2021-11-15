<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.HashMap"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
AdminDAO aDAO = new AdminDAO();

String date1 = request.getParameter("date1");
String date2 = request.getParameter("date2");

String countPrice = aDAO.countHomeDashPrice(date1,date2);
String countOrder = aDAO.countHomeDashOrder(date1,date2);

HashMap<String, Object> hm = new HashMap<String, Object>();
hm.put("countPrice", countPrice);
hm.put("countOrder", countOrder);

JSONObject jo = new JSONObject(hm);
out.print(jo); 
%>