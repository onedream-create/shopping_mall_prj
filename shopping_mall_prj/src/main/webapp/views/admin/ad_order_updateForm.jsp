<%@page import="java.util.List"%>
<%@page import="kr.co.shopping_mall.model.OrderDetailVO"%>
<%@page import="kr.co.shopping_mall.model.OrderVO"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
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
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<script type="text/javascript">
$(function() {
	//주문상태 설정
	let ord_stat_cd = $('#ord_stat_cd').val();
	$("#ord_stat").val(ord_stat_cd).prop("selected", true);
});

function btnClick(str) {
	
	if(str == 'update') {
		let answer = confirm("수정완료하시겠습니까?");
		if (!answer) {
			return false;
		}
		//수정기능추가해야함
	}
	
	if(str == 'cancle'){
		self.close();
	}
}

</script>
</head>
<body>
<% 
String order_cd = request.getParameter("user_id");

AdminDAO aDAO = new AdminDAO();
OrderVO oVO = aDAO.getOrderInfo(order_cd);

List<OrderDetailVO> listOd = aDAO.getOrderDetailInfo(order_cd);
%>
	<div class="container-fluid">
		<form method="post" id="updateForm">
			<table class="table table-bordered text-center">
				<thead class="thead-dark">
					<tr>
						<th class="col-1">주문코드</th>
						<th class="col-1">받는분</th>
						<th class="col-2">배송주소</th>
						<th class="col-2">주문일자</th>
						<th class="col-1">주문상태</th>
						<th class="col-1">상품</th>
						<th class="col-1">수량</th>
						<th class="col-1">단가</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan="0" class="readOnly"><input type="text" class="form-control" name="ord_cd" id="ord_cd" value="<%=oVO.getOrd_cd()%>" readonly="readonly"/></td>
						<td rowspan="0" class="readOnly"><input type="text" class="form-control" name="dv_name" value="<%=oVO.getDv_name()%>" readonly="readonly"/></td>
						<td rowspan="0" ><input type="text" class="form-control" name="dv_addr" id="dv_addr" value="<%=oVO.getDv_addr()%>"/></td>
						<td rowspan="0" class="readOnly"><input type="text" class="form-control" name="ord_date" value="<%=oVO.getOrd_date()%>" readonly="readonly"/></td>
						<td rowspan="0" width="12%">
							<input type="hidden" id="ord_stat_cd" value="<%=oVO.getOrd_stat_cd()%>">
							<select class="custom-select" name="ord_stat" id="ord_stat">
  								<option value="1">주문완료</option>
 						 		<option value="2">배송중</option>
  								<option value="3">구매완료</option>
  								<option value="4">주문취소</option>
								</select>
						</td>
					</tr>
					<%for(int i=0; i<listOd.size(); i++) {%>
					<tr>
						<td class="readOnly"><input type="text" class="form-control" name="pro_name" value=<%=listOd.get(i).getPro_name()%> readonly="readonly"/></td>
						<td class="readOnly"><input type="text" class="form-control" name="ordd_qty" value=<%=listOd.get(i).getOrdd_qty()%> readonly="readonly"/></td>
						<td class="readOnly"><input type="text" class="form-control" name="pro_price" value=<%=listOd.get(i).getPro_price()%> readonly="readonly"/></td>
					</tr>
					<%}%>
					
				</tbody>
			</table>
			<div>
				<input type="text" class="form-control" name="dv_memo" value="<%=oVO.getDv_memo()%>" readonly="readonly"/>
			</div>
			<div class="mt-2" align="right"><h2>총 주문금액 : <span style="color: orange;"><%=oVO.getOrd_price()%></span>원</h2></div>
			<div class="row mt-3">
			<input type="button" class="btn btn-primary col-auto ml-auto mr-3" onclick="btnClick('update');" value="수정완료">
			<input type="button" class="btn btn-outline-primary mr-3" onclick="btnClick('cancle');" value="취소">
			</div>
		</form>
	</div>
</body>
</html>