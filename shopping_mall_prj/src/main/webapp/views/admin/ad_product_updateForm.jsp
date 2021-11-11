<%@page import="kr.co.shopping_mall.model.ProductVO"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
    <c:if test="${empty sessionScope.admin_id}">
    <c:redirect url="ad_login.jsp"/>
    </c:if>
<% 
String pro_cd = request.getParameter("pro_cd");

AdminDAO aDAO = new AdminDAO();
ProductVO pVO = aDAO.getProInfo(pro_cd);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상품정보수정</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="http://localhost/shopping_mall_prj/common/css/custom_updateForm.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"
	integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF"
	crossorigin="anonymous"></script>
</head>
<script type="text/javascript">
$(function() {
	let sell_fl = '<%=pVO.getSell_fl()%>'
	$('#'+sell_fl).prop("checked",true);
});
</script>
<body>
	<div class="container">
		<form action="#" method="post">
			<table class="table table-bordered text-center">
				<thead class="thead-dark">
					<tr>
						<th>상품코드</th>
						<th>상품명</th>
						<th>판매가</th>
						<th>판매상태</th>
						<th>상품등록일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="readOnly"><input type="text" class="form-control" name="pro_cd" value='<%=pVO.getPro_cd()%>' readonly="readonly"/></td>
						<td><input type="text" class="form-control" name="pro_name" value='<%=pVO.getPro_name()%>'/></td>
						<td><input type="number" class="form-control" name="pro_price" value='<%=pVO.getPro_price()%>'/></td>
						<td>
 					<div class="col-10">
      					<div class="form-check float-sm-left">
       				 		<input class="form-check-input" type="radio" name="sell_fl" id="y" value="y">
        					<label class="form-check-label" for="sell">판매함</label>
      					</div>
      					<div class="form-check float-sm-left">
       						<input class="form-check-input" type="radio" name="sell_fl" id="n" value="n">
       					 	<label class="form-check-label" for="notSell">판매안함</label>
      					</div>
      				</div>
						</td>
						<td class="readOnly"><input type="text" class="form-control" name="input_date" value='<%=pVO.getInput_date()%>' readonly="readonly"/></td>
					</tr>
				</tbody>
			</table>
			<div class="row">
			<input type="button" class="btn btn-dark col-auto ml-3 mr-auto" value="삭제">
			<input type="button" class="btn btn-primary col-auto mr-3" value="수정완료">
			<input type="button" class="btn btn-outline-primary mr-3" value="취소">
			</div>
		</form>
	</div>
</body>
</html>