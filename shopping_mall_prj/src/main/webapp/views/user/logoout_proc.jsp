<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="로그아웃 처리"%>
<%
    // 1: 기존의 세션 데이터를 모두 삭제
    session.invalidate();
%>
<!--  2: 로그인 페이지로 이동시킴. -->
<script type="text/javascript">
location.href="http://211.63.89.152/views/index.jsp";
</script> 
