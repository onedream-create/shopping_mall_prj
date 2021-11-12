<%@page import="kr.co.shopping_mall.model.ProductVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
String flag = request.getParameter("flag");
int index = Integer.valueOf(request.getParameter("index"));

int rowsPerPage = 8; //페이지당 보여줄갯수
//데이터시작점
int start = (index-1) * rowsPerPage;

AdminDAO aDAO = new AdminDAO();
List<ProductVO> proList = aDAO.proDashSearch(flag, start, rowsPerPage);

Gson gson = new Gson();
String json = gson.toJson(proList);

out.println(json);	
%>