<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
String division = request.getParameter("division");
String searchValue = request.getParameter("searchValue");
int category_cd = Integer.valueOf(request.getParameter("category_cd"));


AdminDAO aDAO = new AdminDAO();
int totalRows = Integer.valueOf(aDAO.countSearchPro(division, searchValue, category_cd));

int rowsPerPage = 8; //페이지당 보여줄갯수
int pageCount = (int)Math.ceil((double)totalRows/rowsPerPage);

out.print(pageCount);
%>