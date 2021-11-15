<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
String division = request.getParameter("division");
String searchValue = request.getParameter("searchValue");
String user_category = request.getParameter("user_category");


AdminDAO aDAO = new AdminDAO();
int totalRows = Integer.valueOf(aDAO.countSearchUser(division, searchValue, user_category));

int rowsPerPage = 8; //페이지당 보여줄갯수
int pageCount = (int)Math.ceil((double)totalRows/rowsPerPage);

out.print(pageCount);
%>