<%@page import="kr.co.shopping_mall.dao.GetTempPw"%>
<%@page import="java.io.IOException"%>
<%@page import="org.springframework.dao.EmptyResultDataAccessException"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="kr.co.shopping_mall.model.UserInfoVO"%>
<%@page import="kr.co.shopping_mall.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="비밀번호 찾기 성공 페이지"%>
<%
request.setCharacterEncoding("UTF-8");

String input_name=request.getParameter("user_name");//입력된 이름(암호화 전)
String input_id=request.getParameter("user_id");//입력된 아이디(암호화 전)
String input_email=request.getParameter("user_email");//입력된 이메일(암호화 전)

//입력된 이름, 이메일 암호화
DataEncrypt de=new DataEncrypt("AbcdEfgHiJkLmnOpQ");
String de_input_name=de.encryption(input_name);
String de_input_email=de.encryption(input_email);
String user_id=null;
String tempPw=null;

UserDAO ud=new UserDAO();
//조회되는 아이디 반환 / 조회되는 결과가 없으면 idpwFind_fail.jsp로 이동
try{
	user_id=ud.findPw(de_input_name, de_input_email, input_id);
	//임시 비밀번호 발급
	GetTempPw gtp=new GetTempPw();
	tempPw=gtp.temporaryPassword(8);

	//발급된 임시 비밀번호로 회원정보 재설정
	//임시 비밀번호 암호화
	String de_tempPw=DataEncrypt.messageDigest("MD5", tempPw);
	int cnt=ud.updatePass(user_id, de_tempPw);
}catch(EmptyResultDataAccessException erdae){ %>
	<script>
	location.href="http://211.63.89.152/views/help/idpwFind_fail.jsp";
	</script>	
<%}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>비밀번호 찾기 성공 </title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="http://211.63.89.152/common/image/favicon.png" />
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
.line{margin-top: 70px; margin-left: 550px}
.lin{margin-left: 550px}
</style>
<script type="text/javascript">

</script>
<body>
	<jsp:include page="../layout/header.jsp"/>
		<hr class="line" style="border: solid 1px black; width: 800px">
		
<div style="height: 150px">
	<h1 style="text-align:center; margin : 30px; color:#D09869; font-weight: bold; font-family: 'Sunflower', sans-serif;">SEARCH</h1>
	<h2 style="text-align:center; margin : 30px; color:#D09869; font-weight: bold; font-family: 'Sunflower', sans-serif;">아이디,비밀번호 찾기</h2>
</div>
<hr class="lin" style="border: solid 1px black; width: 800px">

<h4 style="text-align:center; margin-bottom:20px; margin-top : 70px ;color:#D8D8D8; font-weight: bold; font-family: 'Sunflower', sans-serif;">임시 비밀번호가 발급되었습니다.</h4>
<h3 style="text-align:center; margin-bottom:189px; margin-top : 70px ;color:#D8D8D8; font-weight: bold; font-family: 'Sunflower', sans-serif;"><%= tempPw %></h3>
	<jsp:include page="../layout/footer.jsp"/>
</body>
</html>