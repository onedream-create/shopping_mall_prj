<%@page import="kr.co.shopping_mall.dao.UserDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원가입처리"%>
    <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="uVO" class="kr.co.shopping_mall.model.UserVO" scope="page"/>
<jsp:setProperty property="*" name="uVO"/>
<c:catch var="e">
<%
//비밀번호 복호화할 수 없는 SHA 암호화
uVO.setUser_pw(DataEncrypt.messageDigest("MD5", uVO.getUser_pw()));//SHA 암호화
//이름은 복호화 가능한 : AES 암호화
DataEncrypt de=new DataEncrypt("AbcdEfgHiJkLmnOpQ");
uVO.setUser_name(de.encryption(uVO.getUser_name()));
uVO.setUser_tel(de.encryption(uVO.getUser_tel()));  
uVO.setUser_email(de.encryption(uVO.getUser_email())); 
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
	alert("회원가입에 실패하였습니다.");
	location.href="joinForm.jsp";
</script>
</c:if>