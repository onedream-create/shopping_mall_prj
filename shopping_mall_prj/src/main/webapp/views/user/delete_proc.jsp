<%@page import="kr.co.shopping_mall.model.UserInfoVO"%>
<%@page import="kr.co.shopping_mall.model.UserVO"%>
<%@page import="kr.co.shopping_mall.dao.UserDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원 탈퇴 처리"%>
 <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
 <% 
request.setCharacterEncoding("UTF-8");
String user_id=(String)session.getAttribute("user_id");
String user_pw=DataEncrypt.messageDigest("MD5", request.getParameter("user_pw"));
UserDAO dao=new UserDAO();
%>
<c:catch var="e"> 
<% 
int check=dao.updateDelFl(user_id,user_pw);
if(check==1){
	session.invalidate();//삭제했다면 세션 정보를 삭제%>
<script>
	alert("회원탈퇴가 완료되었습니다.");
	location.href="http://localhost/shopping_mall_prj/views/index.jsp";
</script>
<%} else{%>
<script>
	alert("비밀번호가 일치하지 않습니다.");
	location.href="http://localhost/shopping_mall_prj/views/user/deleteForm.jsp";
</script>
<%} %>
</c:catch> 
<c:if test="${ not empty e }">
<script type="text/javascript">
	alert("탈퇴에 실패 하였습니다.");
	location.href="http://localhost/shopping_mall_prj/views/user/deleteForm.jsp";
</script>
</c:if>