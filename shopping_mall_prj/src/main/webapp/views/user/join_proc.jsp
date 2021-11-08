<%@page import="java.io.Console"%>
<%@page import="kr.co.shopping_mall.dao.UserDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원가입처리"%>
    <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://localhost/jsp_prj/common/css/main_v20211012.css"/>
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
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="uVO" class="kr.co.shopping_mall.model.UserVO" scope="page"/>
<jsp:setProperty property="*" name="uVO"/>
<%
System.out.println( uVO );
%>
<c:catch var="e">
<%
//비밀번호 복호화할 수 없는 SHA 암호화
uVO.setUser_pw(DataEncrypt.messageDigest("MD5", uVO.getUser_pw()));//SHA 암호화
//이름은 복호화 가능한 : AES 암호화
DataEncrypt de=new DataEncrypt("AbcdEfgHiJkLmnOpQ");
/* uVO.setUser_id(de.encryption(uVO.getUser_id())); */
uVO.setUser_name(de.encryption(uVO.getUser_name()));
uVO.setUser_tel(de.encryption(uVO.getUser_tel()));  
uVO.setUser_email(de.encryption(uVO.getUser_email())); 
/* uVO.setUser_addr(de.encryption(uVO.getUser_addr()));  */
//DB 작업  
UserDAO uDAO=new UserDAO();
uDAO.insertMember(uVO);//추가성공 예외
%>
<script type="text/javascript">
	location.href="joinCompl.jsp";
</script>
</c:catch>
<c:if test="${ not empty e }">
<script type="text/javascript">
	alert("회원가입 중 문제 발생");
	location.href="joinForm.jsp";
</script>
</c:if>
</body>
</html>