<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<c:catch var="e">
<% 
String input_id = request.getParameter("admin_id");

//DBMS 비밀번호는 컬럼은 SHA 암호화된 값이므로 입력된 Plain Text를 cipher Text로 변환하여 비교하는 코드를 수행해야한다.
//MD5암호화 1234 => gdyb21LQTcIANtvYMT7QVQ==
String input_pw = DataEncrypt.messageDigest("MD5", request.getParameter("admin_pw"));

AdminDAO aDAO = new AdminDAO();
session.setAttribute("admin_id", aDAO.checkAccount(input_id, input_pw));
%>
<c:redirect url="../ad_main.jsp"/>
</c:catch>

<c:if test="${not empty e}">
<script type="text/javascript">
alert("아이디나 비밀번호를 확인해주세요");
location.replace("../ad_login.jsp");
</script>
</c:if>
