<%@page import="kr.co.shopping_mall.dao.OrderDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="구매하기 처리"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 파라메터 처리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="oVO" class="kr.co.shopping_mall.model.OrderVO" scope="page"/>
<jsp:setProperty property="*" name="oVO"/>
<c:catch var="e">
<%
DataEncrypt de=new DataEncrypt("AbcdEfgHiJkLmnOpQ");
//System.out.println( oVO );
oVO.getOrd_cd(); 
oVO.setDv_name(de.encryption(oVO.getDv_name()));
oVO.setDv_tel(de.encryption(oVO.getDv_tel()));
oVO.getDv_addr();
oVO.getDv_memo();

//DB 작업
OrderDAO oDAO=new OrderDAO();
oDAO.insertOrders(oVO);
%>
<% response.sendRedirect("buyCompl.jsp"); %>
</c:catch>
<c:if test="${ not empty e }">
<script type="text/javascript">
	${ e }
	<% out.println(oVO.getDv_name()); %>
	<% out.println(oVO.getDv_tel()); %>
	alert("구매하기에 실패하였습니다.");
	location.href="buyForm.jsp";
</script>
</c:if>