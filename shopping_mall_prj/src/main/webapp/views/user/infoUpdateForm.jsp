<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="회원정보수정"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원정보수정</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
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
    	font-family: 'Sunflower', sans-serif;
    }
    .dl{
    	postion:relative;
    	width:70%;
    	margin : auto;
    	margin-bottom: 6%;
    	
    }
</style>
<script type="text/javascript">

</script>
<body>
	<jsp:include page="../layout/header.jsp"/>
     <form action="frm">
     &nbsp;<div class="dl" >
        	<a href="http://localhost/shopping_mall_prj/user/myOrder.jsp"><div class="dt" id="order"><h3 id="dt">주문내역</h3></div></a>
        	<a href="http://localhost/shopping_mall_prj/user/myInfo.jsp"><div class="dt" id="info"><h3 id="dt">개인정보</h3></div></a>
        </div>
	<div align="center" style="color:#D09869; font-weight: bold; font-family: 'Sunflower', sans-serif;">
      <div class="mb-5" align="center" style="margin-bottom:70px; margin-top: 70px" >
         <h6 style="text-align:center; font-weight: bold; font-size: 30px">회원 정보 수정</h6>
      </div>
   <div class="row g-2 align-items-center" style="width:600px" >
     <div class="col-auto" >
       <label for="inputPassword6" class="col-form-label">아이디</label>
     </div>
     <div class="col-auto">
       <input type="text" id="inputPassword6" class="form-control-lg"  style="width: 400px" placeholder="아이디(readonly)" readonly="readonly">
     </div>
     
  </div>
   <div class="row g-2 align-items-center" style="width: 600px;margin-top:10px">
     <div class="col-auto">
       <label class="col-form-label">비밀번호</label>
     </div>
     <div class="col-auto">
       <input type="password" class="form-control-lg" style="width: 400px" placeholder="비밀번호 입력">
     </div>
  </div>
   <div class="row g-2 align-items-center" style="width: 600px;margin-top:10px">
     <div class="col-auto">
       <label class="col-form-label">이름</label>
     </div>
     <div class="col-auto">
       <input type="password" class="form-control-lg" style="width: 400px" placeholder="이름(read only)" readonly="readonly">
     </div>
  </div>
   <div class="row g-2 align-items-center" style="width: 600px;margin-top:10px">
     <div class="col-auto">
       <label class="col-form-label">휴대폰번호</label>
     </div>
     <div class="col-auto">
       <input type="text" class="form-control-lg" style="width: 400px" placeholder="휴대폰번호(read only)" readonly="readonly">
     </div>
  </div>
   <div class="row g-2 align-items-center" style="width: 600px;margin-top:10px">
     <div class="col-auto">
       <label class="col-form-label">이메일</label>
     </div>
     <div class="col-auto">
       <input type="text" class="form-control-lg" style="width: 400px" placeholder="이메일" >
     </div>
  </div>
   <div class="row g-2 align-items-center" style="width: 600px;margin-top:10px">
     <div class="col-auto">
       <label class="col-form-label">주소</label>
     </div>
     <div class="col-auto">
       <input type="text" class="form-control-lg" style="width: 400px" placeholder="주소">
     </div>
  </div>

     </div> 
              <p style="text-align:center;margin-top:10px; font-family: 'Sunflower', sans-serif;">
        <button type="button" class="btn btn-default btn-lg" style="width:200px; height:56px; background:#D09869 ;color:#FFFFFF ">회원탈퇴</button>
        <button type="button" class="btn btn-default btn-lg" style="width:200px; height:56px; background:#D09869 ;color:#FFFFFF ">돌아가기</button>
        <button type="button" class="btn btn-default btn-lg" style="width:200px; height:56px; color:#000000">수정완료</button>
      </p>
     </form>
	
	<jsp:include page="../layout/footer.jsp"/>
</body>
</html>