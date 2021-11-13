<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<%
String work = request.getParameter("work");
String pro_cd = request.getParameter("pro_cd");
String pro_name = request.getParameter("pro_name");
String pro_price = request.getParameter("pro_price");
String sell_fl = request.getParameter("sell_fl");

AdminDAO aDAO = new AdminDAO();

if(work.equals("update")) {
	aDAO.updatePro(pro_cd, pro_name, pro_price, sell_fl);
} 

if(work.equals("delete")) {
	aDAO.deletePro(pro_cd);
}

%>