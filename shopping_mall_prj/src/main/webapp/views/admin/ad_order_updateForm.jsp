<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
    <c:if test="${empty sessionScope.admin_id}">
    <c:redirect url="ad_login.jsp"/>
    </c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>주문정보수정</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="http://localhost/shopping_mall_prj/common/css/custom_updateForm.css" >
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

<script type="text/javascript">

</script>
</head>
<body>
	<div class="container">
		<form action="#" method="post">
			<table class="table table-bordered text-center">
				<thead class="thead-dark">
					<tr>
						<th>주문코드</th>
						<th>회원ID</th>
						<th>배송주소</th>
						<th>주문일자</th>
						<th>주문상태</th>
						<th>상품코드</th>
						<th>수량</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan="0" class="readOnly"><input type="text" class="form-control" name="ord_cd" value="주문코드" readonly="readonly"/></td>
						<td rowspan="0" class="readOnly"><input type="text" class="form-control" name="ord_cd" value="회원ID" readonly="readonly"/></td>
						<td rowspan="0" ><input type="text" class="form-control" name="dv_addr" value="배송주소"/></td>
						<td rowspan="0" class="readOnly"><input type="text" class="form-control" name="ord_date" value="주문일자" readonly="readonly"/></td>
						<td rowspan="0" width="12%">
							<select class="custom-select" name="ord_stat_cd">
  								<option value="1">주문완료</option>
 						 		<option value="2">배송중</option>
  								<option value="3">구매완료</option>
  								<option value="4">주문취소</option>
								</select>
						</td>
					</tr>
					<tr>
						<td class="readOnly"><input type="text" class="form-control" name="pro_cd" value="상품코드" readonly="readonly"/></td>
						<td><input type="text" class="form-control" name="ordd_qty" value="수량"/></td>
					</tr>
					<tr>
						<td class="readOnly"><input type="text" class="form-control" name="pro_cd" value="상품코드" readonly="readonly"/></td>
						<td><input type="text" class="form-control" name="ordd_qty" value="수량"/></td>
					</tr>
										<tr>
						<td class="readOnly"><input type="text" class="form-control" name="pro_cd" value="상품코드" readonly="readonly"/></td>
						<td><input type="text" class="form-control" name="ordd_qty" value="수량"/></td>
					</tr>
										<tr>
						<td class="readOnly"><input type="text" class="form-control" name="pro_cd" value="상품코드" readonly="readonly"/></td>
						<td><input type="text" class="form-control" name="ordd_qty" value="수량"/></td>
					</tr>

				</tbody>
			</table>
			<div class="row">
			<input type="button" class="btn btn-primary col-auto ml-auto mr-3" value="수정완료">
			<input type="button" class="btn btn-outline-primary mr-3" value="취소">
			</div>
		</form>
	</div>
</body>
</html>