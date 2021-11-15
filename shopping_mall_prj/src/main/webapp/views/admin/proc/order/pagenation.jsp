<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
String division = request.getParameter("division");
String searchValue = request.getParameter("searchValue");
int order_stat_cd = Integer.valueOf(request.getParameter("order_stat_cd"));
String order_date1 = request.getParameter("order_date1");
String order_date2 = request.getParameter("order_date2");

AdminDAO aDAO = new AdminDAO();
int totalRows = Integer.valueOf(aDAO.countSearchOrder(division, searchValue, order_stat_cd, order_date1, order_date2));

int rowsPerPage = 8; //페이지당 보여줄갯수
int pageCount = (int)Math.ceil((double)totalRows/rowsPerPage);

out.print(pageCount);

%>