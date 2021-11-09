<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<c:catch var="e">
<%
String newPass = DataEncrypt.messageDigest("MD5", request.getParameter("newPass")); 
String nowPass = DataEncrypt.messageDigest("MD5", request.getParameter("nowPass")); 
String admin_id = (String)session.getAttribute("admin_id");

AdminDAO aDAO = new AdminDAO();

aDAO.checkAccount(admin_id, nowPass);
aDAO.changePass(admin_id, newPass);
%>
<script type="text/javascript">
alert("비밀번호 변경에 성공하셨습니다. 다음 로그인시 새로운 비밀번호로 로그인 해주세요.");
location.replace("../ad_main.jsp");
</script>

</c:catch>
<c:if test="${not empty e}">
<script type="text/javascript">
alert("비밀번호 변경에 실패했습니다. 현재 비밀번호를 확인해주세요");
history.back();
</script>
</c:if>