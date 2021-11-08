<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="장바구니"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>장바구니</title>
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
<%
	request.setCharacterEncoding("UTF-8");
	//1. 유효 사용자 인증 필요
	//2. 이 페이지에 직접 방문하면 null이 설정하는 문제
	session.setAttribute("user_id", request.getParameter("user_id"));
	session.setAttribute("user_pw", request.getParameter("user_pw"));
%>
</head>
<style>
	h2{
		text-align:left; color:#D09869; font-weight: bold; 
		font-family: 'Sunflower', sans-serif; margin:100px 0 40px 0;
	}
    table, th, td{ 
        text-align: center;
		font-size:16px;
        height:60px;
    }
    .table>tbody>tr>td{
        vertical-align:middle;
		font-size:16px;
		border-bottom:1px solid #F2F2F2;
    }
    .table>tbody>tr>th{
        vertical-align:middle;
		font-size:16px;
    }
    .table>tbody>tr:nth-child(1){
       border-bottom:1px solid #D09869;
    }
 	#total{
	 	text-align:right; background:#D09869; color:#FFFFFF; font-family: 'Sunflower', sans-serif; font-size:27px;
    }
    #tbl-product{margin-bottom:90px; border-top:1px solid #D09869;}
    p{text-align:center;}
   
    .btn2 {
 		width:22%; height:56px; color:#D09869; border-color: #D09869; font-size:15px;
	}
	.btn2:hover{color:#D09869;}
   .btn3{
    	background:#D09869; color:#FFFFFF; border-color:#FFFFFF;
    }
    .btn3:hover{color:#FFFFFF;}
</style>
<script type="text/javascript">
function selectAll(selectAll)  {
	  const checkboxes 
	       = document.getElementsByName('item');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  })
	}
</script>
<body>
<jsp:include page="../layout/header.jsp"/>   
	<form name="frm" action="buyForm.jsp" method="post">
        <div class="container">
	        <h2>장바구니</h2>    
	        <div class="table-responsive">
		        <table class="table table-borderless" id="tbl-product">
		            <colgroup>
		                <col style="width: 10%" />
		                <col style="width: 10%" />
		                <col style="width: 45%" />
		                <col style="width: 10%" />
		                <col style="width: 15%" />
		            </colgroup>
		            <tr>             
		                <th><input type="checkbox" name="product" onclick="selectAll(this)"></th>   
		                <th></th>   
		                <th>상품명</th>
		                <th>수량</th>
		                <th>가격</th>
		            </tr>
		            <%for(int i=0; i < 6; i++){ %>
		            <tr>                
		                <td><input type="checkbox" name="item"></td>
		                <td><img src="http://placehold.it/150x150"></td>
		                <td>호박고구마</td>
		                <td>1개</td>
		                <td>1000원</td>
		            </tr>
		            <%
					}//end for
					%>
		            <tr>
		            	<td id="total" colspan="5">총 주문금액 : 30000원</td>
		        </table>
        </div>
        <p>
		  <button type="button" class="btn btn-default btn-lg btn2">삭제하기</button>
		  <button class="btn btn-default btn-lg btn2" onclick="history.back()">쇼핑하기</button>
		  <button class="btn btn-default btn-lg btn2 btn3" onclick="location.href='buyForm.jsp'">구매하기</button>
		</p>
        </div>
        </form>
<jsp:include page="../layout/footer.jsp"/>
</body>
</html>
