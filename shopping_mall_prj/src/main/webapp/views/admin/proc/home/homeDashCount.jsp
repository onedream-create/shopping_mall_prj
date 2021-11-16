<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.HashMap"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
AdminDAO aDAO = new AdminDAO();

SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
String NowDate = sdf.format(new Date());
SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMM01");
String monDate = sdf1.format(new Date());

String countPrice1 = aDAO.countHomeDashPrice(NowDate,NowDate);
String countOrder1 = aDAO.countHomeDashOrder(NowDate,NowDate);

String countPrice2 = aDAO.countHomeDashPrice(monDate,NowDate);
String countOrder2 = aDAO.countHomeDashOrder(monDate,NowDate);

HashMap<String, Object> hm = new HashMap<String, Object>();
hm.put("countPrice1", countPrice1);
hm.put("countOrder1", countOrder1);
hm.put("countPrice2", countPrice2);
hm.put("countOrder2", countOrder2); 

JSONObject jo = new JSONObject(hm);
out.print(jo); 
%>