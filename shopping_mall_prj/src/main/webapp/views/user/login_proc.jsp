<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="kr.co.shopping_mall.dao.UserDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="로그인 처리"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>로그인 처리</title>
<style type="text/css">

</style>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="http://localhost/shopping_mall_prj/common/image/favicon.png" />
<!--jQuery CDN-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@500&display=swap" rel="stylesheet">
<!-- Bootstrap icons-->
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
   rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<script type="text/javascript">

</script>
</head>
<body>
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
String user_name=uDAO.selectLogin(loginVO);
//이름을 복호화한다.
DataDecrypt dd=new DataDecrypt("AbcdEfgHiJkLmnOpQ");
user_name=dd.decryption(user_name);

//로그인 정보를 세션에 할당
//=> 비연결성인 웹에서 로그인 정보를 모든 페이지에서 사용하기 위해
session.setAttribute("user_name",user_name);
%>
<% response.sendRedirect("../index.jsp"); %>
</c:catch>
<c:if test="${ not empty e }">
<script type="text/javascript">
	alert("아이디나 비밀번호를 확인해주세요.");
	location.href="loginForm.jsp";
</script>
</c:if>
</body>
</html>