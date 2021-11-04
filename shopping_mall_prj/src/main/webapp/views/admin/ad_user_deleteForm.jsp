<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원정보삭제</title>
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
						<th>회원ID</th>
						<th>회원등급</th>
						<th>휴대전화</th>
						<th>주소</th>
						<th>이메일</th>
						<th>가입일자</th>
						<th>탈퇴일자</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="readOnly"><input type="text" class="form-control" name="user_id" value="ID" readonly="readonly"/></td>
						<td class="readOnly"><input type="text" class="form-control" name=grade_no value="등급" readonly="readonly"/></td>
						<td class="readOnly"><input type="text" class="form-control" name=user_tel value="삭제됨" readonly="readonly"/></td>
						<td class="readOnly"><input type="text" class="form-control" name="user_addr" value="삭제됨" readonly="readonly"/></td>
						<td class="readOnly"><input type="email" class="form-control" name="user_email" value="삭제됨" readonly="readonly"/></td>
						<td class="readOnly"><input type="text" class="form-control" name="reg_date" value="가입일자" readonly="readonly"/></td>
						<td class="readOnly"><input type="text" class="form-control" name="reg_date" value="탈퇴일자" readonly="readonly"/></td>
					</tr>
				</tbody>
			</table>
			<div class="row">
			<input type="button" class="btn btn-dark col-auto ml-3 mr-auto" value="회원삭제">
			<input type="button" class="btn btn-outline-primary col-auto mr-3" value="취소">
			</div>
		</form>
	</div>
</body>
</html>