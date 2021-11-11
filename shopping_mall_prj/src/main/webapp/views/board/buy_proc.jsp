<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.shopping_mall.dao.DeliveryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="구매하기 처리"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 파라메터 처리 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dVO" class="kr.co.shopping_mall.model.DeliveryVO" scope="page"/>
<jsp:setProperty property="*" name="dVO"/>
<c:catch var="e">
<%
DataEncrypt de=new DataEncrypt("AbcdEfgHiJkLmnOpQ");
//System.out.println( dVO );
dVO.getOrd_cd(); 
dVO.setDv_name(de.encryption(dVO.getDv_name()));
dVO.setDv_tel(de.encryption(dVO.getDv_tel()));
dVO.getDv_addr();
dVO.getDv_memo();
/* oVO.setDv_name(oVO.getDv_name());
oVO.setDv_tel(oVO.getDv_tel());
oVO.getDv_addr();
oVO.getDv_memo(); */

//DB 작업
DeliveryDAO dDAO=new DeliveryDAO();
dDAO.insertDelivery(dVO);
%>
<% response.sendRedirect("buyCompl.jsp"); %>
</c:catch>
<c:if test="${ not empty e }">
<script type="text/javascript">
	${ e }
	<% out.println(dVO.getDv_name()); %>
	<% out.println(dVO.getDv_tel()); %>
	alert("구매하기에 실패하였습니다.");
	location.href="buyForm.jsp";
</script>
</c:if>