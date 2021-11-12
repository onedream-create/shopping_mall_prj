<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String pro_cd=request.getParameter("pro_cd");
session.getAttribute("cart");
String[] check=request.getParameterValues("item");
 for(int i=0;i<check.length;i++){
	out.println(check[i]);
} 
%>
<script>
alert(check[1]);
alert(check[2]);
/* location.href="http://localhost/shopping_mall_prj/views/board/cart_list.jsp"; */
</script>