<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="구매하기"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>구매하기</title>
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
<style type="text/css">
	form h2:nth-child(1){margin-top:100px;} 
	h2{text-align:left; color:#D09869; font-weight: bold; font-family: 'Sunflower', sans-serif; margin:0 0 40px 0;} 
	table, th, td{ 
    	text-align: center;
		height:60px;
	}  
	.table tr:nth-child(2){border-bottom : none;}
	.table>tbody>tr>th{
		vertical-align:middle;
		font-size:16px;
	 }
	 .table>tbody>tr>td{
		vertical-align:middle;
		font-size:16px;
		padding:10px 0;
	}
	.table>tbody>tr>th:first-child {
		margin-bottom:20px;
	}
	#tbl-info tr:nth-child(2)>td {
		padding-top:40px;
	}
	form table>tbody>tr:nth-child(5)>td {
		padding-bottom:40px;
	}
	.table-borderless{margin-bottom:0px;border-top:1px solid #D09869;}
	table>colgroup{text-align:left;}
	input[type="text"]{width:90%; height:45px; border:#F2F2F2 1px solid;}
	form table:first-child tr th{border-bottom:1px solid #D09869;}
	.btn-group-lg>.btn, .btn-lg {
 		width:22%; height:56px; color:#D09869; border-color: #D09869; font-size:15px;
	} 
	#tbl-product{margin-bottom:90px; border-top:1px solid #D09869;border-bottom:1px solid #D09869;}
	#tbl-product tr{border-bottom:1px solid #F2F2F2;}
	#tbl-product tr:first-of-type{border-bottom:1px solid #D09869; border-top-color: #D09869;}
	#total{text-align:right; background:#D09869; color:#FFFFFF; font-family: 'Sunflower', sans-serif; font-size:27px; padding-right:20px; padding-bottom:10px;}
	p{text-align:center;}
	p button:nth-child(2){
    	background:#D09869; color:#FFFFFF; border-color:#FFFFFF;
    } 
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
</head>
<body>   
<jsp:include page="../layout/header.jsp"/>
	<form name="frm" method="post">
        <div class="container">
	        <h2>주문서 작성</h2>         
	        <div class="table-responsive">
		        <table class="table table-borderless" id="tbl-info">
		        	<colgroup>
		                <col style="width: 20%;"/>
		                <col style="width: 80%;"/>
		            </colgroup>
		              <tr>             
		                  <th colspan='2'>배송정보</th> 
		              </tr>
		              <tr>
		              	<td>받는사람</td>
		              	<td><input type="text" name="dv_name"></td>
		              </tr>
		              <tr>
		              	<td>휴대전화</td>
		              	<td><input type="text" name="dv_tel"></td>
		              </tr>
		              <tr>
		              	<td>주소</td>
		              	<td><input type="text" name="dv_addr"></td>
		              </tr>
		              <tr>
		              	<td>배송메모</td>
		              	<td><input type="text" name="dv_memo"></td>
		              </tr>
		        </table>
	        </div>
	        <div class="table-responsive">
		 		<table class="table table-borderless" id="tbl-product">
		            <colgroup>
		                <col style="width: 10%" />
		                <col style="width: 55%" />
		                <col style="width: 10%" />
		                <col style="width: 15%" />
		            </colgroup>
		            <tr>             
		                <th><input type="checkbox" name="product"  onclick='selectAll(this)'></th>   
		                <th>상품명</th>
		                <th>수량</th>
		                <th>가격</th> 
		            </tr>
		            <%for(int i=0;i<3;i++) {%>
		            <tr>                
		                <td><input type="checkbox" name="item"></td>
		                <td style="text-align:left;">호박고구마</td>
		                <td>1개</td>
		                <td>10000원</td>
		            </tr>
		            <% } %>
		            <tr>
		            	<td colspan="5" id="total">총 주문금액 : 30000원</td>
		        </table>
	        </div>
	        <p>
			  <button class="btn btn-default btn-lg" onclick="javascript: frm.action='cart_list.jsp';">장바구니</button>
			  <button class="btn btn-default btn-lg" onclick="javascript: frm.action='buyCompl.jsp';">구매하기</button>
			</p>
        </div>
      </form> 
<jsp:include page="../layout/footer.jsp"/>
</body>
</html>
