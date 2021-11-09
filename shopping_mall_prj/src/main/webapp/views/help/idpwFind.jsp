<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" info="아이디 비밀번호 찾기"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>아이디 비밀번호 찾기</title>
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
.line {
  border-left: 1px solid ;
  height: 300px;
  position: absolute;
  left: 50%;
  margin-left: -3px;
  top:0;
  margin-top: 90px
}
   /* div{border : 1px solid;}   */
 
#contents{
position: relative;
height: 600px; 
} 
.selectid{
position: relative;
float: left;  
margin-left: 360px;
margin-top: 80px;
}
.selectpass{
position: absolute;
float: right;
margin-left: 1120px;
margin-top: 80px;
}
</style>
<script type="text/javascript">
$(function(){
	$("#bt").click(function() {
		alert("df")
	})
});//ready
</script>
<body>
 <jsp:include page="../layout/header.jsp"/> 
 
<form id="frm">
<div id="contents"> 
   <div class="selectid" align="left" style="color:#D09869; font-weight: bold; font-family: 'Sunflower', sans-serif;">
      <div class="mb-5" >
         <h6 style=" font-weight: bold; font-size: 30px;">아이디찾기</h6>
     </div>
     <div>
   <div class="row g-2 align-items" style="width:600px;" >
     <div class="col-auto" >
       <input type="text" class="form-control-lg"  style="width: 400px" placeholder="이름">
   <div class="row g-2 align-items" style="width: 600px;margin-top:10px">
     <div class="col-auto">
       <input type="text" class="form-control-lg" style="width: 400px" placeholder="이메일">
        </div>
     </div>
     </div>   
      </div>
     </div>
     <div style="margin-left: 150px; margin-top: 40px; "> 
           <button id="btnn" type="button" class="btn btn-default btn-lg" style="background-color:#D09869; color : #FFFFFF; font-weight: bold; font-family: 'Sunflower', sans-serif;">확인</button>
      </div>
  </div>
	<div class="line"></div>
	
	<div style="width: 600px;">
   <div class="selectpass"align="left" style="color:#D09869; font-weight: bold; font-family: 'Sunflower', sans-serif;">
      <div class="mb-5" >
         <h6 style=" font-weight: bold; font-size: 30px;">비밀번호찾기</h6>
     </div>
     <div >
   <div class="row g-2 align-items" style="width:600px;" >
     <div class="col-auto" >
       <input type="text" class="form-control-lg"  style="width: 400px" placeholder="이름">
   <div class="row g-2 align-items" style="width: 600px;margin-top:10px">
     <div class="col-auto">
       <input type="text" class="form-control-lg" style="width: 400px" placeholder="아이디">
   <div class="row g-2 align-items" style="width: 600px;margin-top:10px">
     <div class="col-auto">
       <input type="text" class="form-control-lg" style="width: 400px" placeholder="이메일">
     </div>
        </div>
     </div>   
      </div>
     </div>
     </div>
     <div style="margin-left: 170px; margin-top: 40px">
           <button id="bt" type="button" class="btn btn-default btn-lg" style="background-color:#D09869; color : #FFFFFF; font-weight: bold; font-family: 'Sunflower', sans-serif;">확인</button>
</div>
     </div>
      </div>
  </div>
</div>

</form>
    <jsp:include page="../layout/footer.jsp"/> 
</body>
</html>