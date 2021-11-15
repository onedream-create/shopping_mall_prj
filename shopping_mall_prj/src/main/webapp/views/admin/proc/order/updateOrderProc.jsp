<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
System.out.println("proc들어옴");
String ord_cd = request.getParameter("ord_cd");
String dv_addr = request.getParameter("dv_addr");
String ord_stat_cd = request.getParameter("ord_stat_cd");

AdminDAO aDAO = new AdminDAO();

aDAO.updateOrder(ord_cd, dv_addr, ord_stat_cd);
%>