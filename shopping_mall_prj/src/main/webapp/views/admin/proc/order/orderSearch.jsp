<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.shopping_mall.model.OrderVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
String division = request.getParameter("division");
String searchValue = request.getParameter("searchValue");
int order_stat_cd = Integer.valueOf(request.getParameter("order_stat_cd"));
String order_date1 = request.getParameter("order_date1");
String order_date2 = request.getParameter("order_date2");

int index = Integer.valueOf(request.getParameter("index"));
int rowsPerPage = 8; //페이지당 보여줄갯수
//데이터시작점
int start = (index-1) * rowsPerPage;

AdminDAO aDAO = new AdminDAO();
List<OrderVO> ordList = aDAO.searchOrder(division, searchValue, order_stat_cd, order_date1, order_date2, start, rowsPerPage);

Gson gson = new Gson();
String json = gson.toJson(ordList);

out.println(json);	
%>