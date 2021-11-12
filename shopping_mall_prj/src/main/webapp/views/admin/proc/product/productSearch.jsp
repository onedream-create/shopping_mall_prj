<%@page import="com.google.gson.Gson"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.shopping_mall.model.ProductVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
String division = request.getParameter("division");
String searchValue = request.getParameter("searchValue");
int category_cd = Integer.valueOf(request.getParameter("category_cd"));

int index = Integer.valueOf(request.getParameter("index"));
int rowsPerPage = 8; //페이지당 보여줄갯수
//데이터시작점
int start = (index-1) * rowsPerPage;

AdminDAO aDAO = new AdminDAO();
List<ProductVO> proList = aDAO.searchPro(division, searchValue, category_cd, start, rowsPerPage);

Gson gson = new Gson();
String json = gson.toJson(proList);

out.println(json);	
%>