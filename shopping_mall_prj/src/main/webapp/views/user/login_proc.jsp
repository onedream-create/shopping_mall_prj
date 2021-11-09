<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="kr.co.shopping_mall.dao.UserDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="로그인 처리"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 파라메터 처리 -->
<jsp:useBean id="loginVO" class="kr.co.shopping_mall.model.UserVO" scope="page"/>
<jsp:setProperty property="*" name="loginVO"/>
<c:catch var="e">
<%

//DBMS 비밀번호 컬럼은 SHA 암호화된 값이므로 입력된 Plain Text를
//cipher Text로 변환하여 비교하는 코드를 수행해야 한다.
loginVO.setUser_pw(DataEncrypt.messageDigest("MD5", loginVO.getUser_pw()));

///로그인 수행
UserDAO uDAO=new UserDAO();

String user_Id = uDAO.checkAccount(loginVO.getUser_id(), loginVO.getUser_pw());
//로그인 정보를 세션에 할당
//=> 비연결성인 웹에서 로그인 정보를 모든 페이지에서 사용하기 위해
session.setAttribute("user_id",user_Id);
%>
<% response.sendRedirect("../index.jsp"); %>
</c:catch>
<c:if test="${ not empty e }">
<script type="text/javascript">
	alert("아이디나 비밀번호를 확인해주세요.");
	location.href="loginForm.jsp";
</script>
</c:if>