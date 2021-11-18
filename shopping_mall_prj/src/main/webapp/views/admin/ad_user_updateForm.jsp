<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="kr.co.shopping_mall.model.UserVO"%>
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
<title>회원정보수정</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="http://211.63.89.152/common/css/custom_updateForm.css" >
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
	//현재등급 선택
	let grade_no = $('#grade_no').val();
	$("#user_grade").val(grade_no).prop("selected", true);
});
	
function btnClick(str) {
	let formData = $("#updateForm").serializeArray();
	
	formData.push({name: 'work', value: str});
	let answer;

	if(str == 'update'){
		answer = confirm("수정완료하시겠습니까?");
		if (!answer) {
			return false;
		}
		work(formData);
	}
	if(str == 'secession'){
		answer = confirm("정말 탈퇴시키겠습니까?");
		if (!answer) {
			return false;
		}
		work(formData);
	}
	if(str == 'cancle'){
		self.close();
	}
	
	function work(formData) {
        $.ajax({
        	cache: false,
            url: "proc/user/updateUserProc.jsp", 
            type : "POST", 
            data : formData, 
            success: function(data) {
            	alert("성공");
            	opener.parent.userDashCount();
            	self.close();
            },
			error: function() {
				alert("실패");
				self.close();
			}
        });
	}
}
</script>
</head>
<body>
<% 
String user_id = request.getParameter("user_id");
AdminDAO aDAO = new AdminDAO();
UserVO uVO = aDAO.getUserInfo(user_id);

DataDecrypt dd = new DataDecrypt("AbcdEfgHiJkLmnOpQ");
try {	
	uVO.setUser_name(dd.decryption(uVO.getUser_name()));
	uVO.setUser_tel(dd.decryption(uVO.getUser_tel()));
	uVO.setUser_email(dd.decryption(uVO.getUser_email()));		
} catch (NullPointerException e) {
	uVO.setUser_name("삭제됨");
	uVO.setUser_tel("삭제됨");
	uVO.setUser_email("삭제됨");
}
%>
	<div class="container">
		<form id="updateForm" method="post">
			<table class="table table-bordered text-center">
				<thead class="thead-dark">
					<tr>
						<th>회원ID</th>
						<th>이름</th>
						<th>회원등급</th>
						<th>휴대전화</th>
						<th>주소</th>
						<th>이메일</th>
						<th>가입일자</th>
						<%if(uVO.getSec_date() != null) { %>
						<th>탈퇴일자</th>	
						<%} %>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="readOnly"><input type="text" class="form-control" name="user_id" value="<%=uVO.getUser_id()%>" readonly="readonly"/></td>
						<td><input type="text" class="form-control" name="user_name" value="<%=uVO.getUser_name()%>"/></td>
						<td>
							<input type="hidden" id="grade_no" value="<%=uVO.getGrade_no()%>">
							<select class="custom-select" id="user_grade" name="grade_no">
  								<option value="1">New</option>
 						 		<option value="2">Bronze</option>
  								<option value="3">Silver</option>
  								<option value="4">Gold</option>
  								<option value="5">Diamond</option>
  								<option value="6">VIP</option>
								</select>
						</td>
						<td><input type="text" class="form-control" name=user_tel value="<%=uVO.getUser_tel()%>"/></td>
						<td><input type="text" class="form-control" name="user_addr" value="<%=uVO.getUser_addr()%>"/></td>
						<td><input type="email" class="form-control" name="user_email" value="<%=uVO.getUser_email()%>"/></td>
						<td class="readOnly"><input type="text" class="form-control" name="reg_date" value="<%=uVO.getReg_date()%>" readonly="readonly"/></td>
						<%if(uVO.getSec_date() != null) { %>
						<td class="readOnly"><input type="text" class="form-control" name="reg_date" value="<%=uVO.getSec_date()%>" readonly="readonly"/></td>
						<%} %>
					</tr>
				</tbody>
			</table>
			<div class="row">
			<%if(uVO.getSec_date() == null) { %>
			<input type="button" class="btn btn-dark col-auto ml-3 mr-auto" onclick="btnClick('secession');" value="회원탈퇴">
			<input type="button" class="btn btn-primary col-auto mr-3" onclick="btnClick('update');" value="수정완료">
			<input type="button" class="btn btn-outline-primary mr-3" onclick="btnClick('cancle');" value="취소">
			<%} %>
			</div>
		</form>
	</div>
</body>
</html>