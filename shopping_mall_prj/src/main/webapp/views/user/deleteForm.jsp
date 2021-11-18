<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="kr.co.shopping_mall.model.UserInfoVO"%>
<%@page import="kr.co.shopping_mall.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="회원정보수정"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원</title>
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
</head>
<style type="text/css">
.col-auto{width : 100px}
 .dt{
    	width:50%;
    	float:left;
    	z-index:9;
    	postion:relative;
    	text-align:center;
    	background:#FFF;
    	padding-bottom:1%;
    	padding-top:1%;
    	color:#D09869; 
    	border:1px solid #D09869; 
    	margin-bottom:3%;
    }
   #dt{
    	color:#D09869; 
    	font-weight: bold; 
    	padding-top:4px;
    	font-family: 'Sunflower', sans-serif; 
    }
    .dl{
    	postion:relative;
    	width:70%;
    	margin : auto;
    	margin-bottom: 6%;
    	
    }
    #infoUpdateBtn{
    	width:15%; 
    	height:56px; 
    	background:#D09869; 
    	color:#FFFFFF; 
    	border-color:#FFFFFF; 
    	font-size:15px;
    }
    #outBtn{
    	width:15%; 
    	height:56px; 
    	background:#D09869; 
    	color:#FFFFFF; 
    	border-color:#FFFFFF; 
    	font-size:15px;
    }
    
    #backBtn{
    	width:15%; 
    	height:56px; 
    	color:#D09869;
    	border-color: #D09869; 
    	font-size:15px;
    }

    #title2{
    	//text-align:center; 
    	color:#D09869; 
    	font-weight: bold; 
    	font-family: 'Sunflower', sans-serif; 
    	margin:0 0 40px 0;
    }
    
 	.container3 {margin-bottom: 24px !important;}
 	.passInput{width:60%; height:45px; border:1px solid #ced4da; color:#333; padding-left:1%;}
</style>
<script type="text/javascript">
$(function(){
	$("#outBtn").click(function(){
		if($("#user_pw").val() == ""){
			alert("비밀번호를 입력해 주세요.");
			$("#user_pw").focus();
			return;
		}//end if
		if($("#user_pw2").val() == ""){
			alert("비밀번호 확인을 입력해 주세요.");
			$("#user_pw2").focus();
			return;
		}//end if
		if($("#user_pw").val() != $("#user_pw2").val()){
			alert("비밀번호가 일치하지 않습니다.");
		    $('#user_pw1').focus();
		    $('#user_pw2').val('');
			return;
		}//end if
		
		$("#delFrm").submit();
	});//click
	
});//ready
function goBack(){
	location.href="http://localhost/shopping_mall_prj/views/user/infoUpdateForm.jsp";
}

</script>
<body>
	<jsp:include page="../layout/header.jsp"/>
	<%
//session을 통해 들어온 로그인 정보가 없으면 로그인페이지로 이동
String user_id=(String)session.getAttribute("user_id");
if(user_id==null){ %>
	<script>
	alert("로그인이 필요한 페이지입니다.");
	location.href="http://localhost/shopping_mall_prj/views/user/loginForm.jsp";
	</script>
<%}//end if %>  
<% 
String userId=(String)session.getAttribute("user_id");
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="uVO" class="kr.co.shopping_mall.model.UserVO" scope="page"/>
<jsp:setProperty property="*" name="uVO"/>
     &nbsp;<div class="dl" >
        	<a href="http://localhost/shopping_mall_prj/views/user/myOrder.jsp"><div class="dt" id="order"><h3 id="dt">주문내역</h3></div></a>
        	<a href="http://localhost/shopping_mall_prj/views/user/myInfo.jsp"><div class="dt" id="info"><h3 id="dt">개인정보</h3></div></a>
        </div>

     <form id="delFrm" name="delFrm" action="http://localhost/shopping_mall_prj/views/user/delete_proc.jsp" method="post">
		<div align="center" style="color: #D09869; margin-bottom: 5%;">
			<div style="width: 35%;">
			<h2 id="title2">회원 탈퇴</h2>
				<div class="container3">
					<!-- <label style="padding-right: 7%;">아이디</label> --> <input
						type="text" class="passInput" readonly="readonly" placeholder="<%= user_id%>"/>
				</div>
				<div class="container3">
					<!-- <label style="padding-right: 4%;">비밀번호</label>  --><input
						type="password" class="passInput" id="user_pw" name="user_pw" placeholder="비밀번호"/>
				</div>
				<div class="container3">
					<!-- <label style="padding-right: 2%;">비밀번호 확인</label> --> <input
						type="password" class="passInput" id="user_pw2" name="user_pw" placeholder="비밀번호 확인"/>
				</div>
			</div>
		</div>

     
     <p style="text-align:center;"><!-- 56px -->
		 <button type="button" class="btn btn-default btn-lg" id="backBtn" onclick="goBack()">돌아가기</button>
		 <button type="button" class="btn btn-default btn-lg" id="outBtn">탈퇴하기</button>
	</p>
     </form>
	
	<jsp:include page="../layout/footer.jsp"/>
</body>
</html>