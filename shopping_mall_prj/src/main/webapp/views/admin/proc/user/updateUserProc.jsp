<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%

DataEncrypt de = new DataEncrypt("AbcdEfgHiJkLmnOpQ");

String work = request.getParameter("work");
String user_id = request.getParameter("user_id");
String grade_no = request.getParameter("grade_no");
String user_tel = de.encryption(request.getParameter("user_tel"));
String user_addr = request.getParameter("user_addr");
String user_email = de.encryption(request.getParameter("user_email"));


AdminDAO aDAO = new AdminDAO();

if(work.equals("update")) {
	aDAO.updateUser(grade_no, user_tel, user_addr, user_email, user_id);
} 

if(work.equals("secession")) {
	aDAO.secessionUser(user_id);
}
%>