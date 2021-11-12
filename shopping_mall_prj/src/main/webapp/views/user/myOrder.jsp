<%@page import="kr.co.shopping_mall.model.OrderInfoVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.shopping_mall.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="마이페이지_주문내역"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp"/>
<%
//session을 통해 들어온 로그인 정보가 없으면 회원가입페이지로 이동
String user_id=(String)session.getAttribute("user_id");
if(user_id==null){ %>
	<script>
	alert("로그인이 필요한 페이지입니다.");
	location.href="http://localhost/shopping_mall_prj/views/user/loginForm.jsp";
	</script>
<%}//end if

//user_id값을 통한 주문정보조회
OrderDAO od=new OrderDAO();
List<OrderInfoVO> list=od.selectOrder(user_id);

pageContext.setAttribute("orderData", list);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이페이지_주문내역</title>

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
<style>
	
    table, th, td{ 
        text-align: center; 
		font-size:16px;
        height:60px;
    }
    .table>tbody>tr>td{
        vertical-align:middle;
		font-size:16px;
    }
    .table>tbody>tr>th{
        vertical-align:middle;
		font-size:16px;
    }
    .table>tbody>tr{
    	border-bottom:1px solid #DDD;
    }
    
    .dl{
    	postion:relative;
    	width:100%;
    	/* height:10%; */
     	/* margin-top:10%; */
    	margin-bottom:10%;
    }
    
    .dt{
    	/* height:50%; */
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
    	padding-top:10px;
    }
    
    .orderInfo{ 
    	text-align: left;
    }
    .infoDiv{ 
    	border-bottom: 2px solid #D09869; 
    }
    
    #title{
    	text-align:left; 
    	color:#D09869; 
    	font-weight: bold; 
    	font-family: 'Sunflower', sans-serif; 
    	margin:10% 0 40px 0;
    }
    
    #chkStyle{ 
    	border-bottom: 2px solid #D09869; 
    	border-top: 2px solid #D09869; 
    	vertical-align: middle;
    }
    #listStyle{
    	border-bottom: 2px solid #D09869; 
    	border-top: 2px solid #D09869; 
    	vertical-align: middle;
    }
    
    #tableDiv{
    	width:100%; 
    	height: 400px; 
    	border-bottom:1px solid #DDD; 
    	overflow:auto;
    	margin-bottom:5%;
    }
    
    #cancelBtn{
    	width:22%; 
    	height:56px; 
    	background:#D09869; 
    	color:#FFFFFF; 
    	border-color:#FFFFFF; 
    	font-size:15px;
    }
    
    #backBtn{
    	width:22%; 
    	height:56px; 
    	color:#D09869;
    	border-color: #D09869; 
    	font-size:15px;
    }

</style>
<script type="text/javascript">
function goBack(){
	window.history.back();
}

$(function(){
	$("#chkAll").click(function(){
		if($("#chkAll").prop("checked")){
			$("input[name=chk]").prop("checked",true);
		}else{
			$("input[name=chk]").prop("checked",false);
		}//end else
	});//click
	
	$("#cancelBtn").click(function(){
		if(confirm("정말 취소하시겠습니까?")){			
			$("#OrderFrm").submit();
		}//end if
		return;
	});//click
	
});//ready
</script>
<body>   
	<form id="OrderFrm" method="post" action="http://localhost/shopping_mall_prj/views/user/myOrder_proc.jsp">
        <div class="container">
        &nbsp;<div class="dl">
        	<a href="myOrder.jsp"><div class="dt"><h3 id="dt">주문내역</h3></div></a>
        	<a href="myInfo.jsp"><div class="dt"><h3 id="dt">개인정보</h3></div></a>
        </div>
        <h2 id="title">주문관리</h2>    
        <div id="tableDiv">
        <table class="table table-responsive" id="tbl-product">
            <colgroup>
                <col style="width:7%;">
				<col style="width:31%;">
				<col style="width:31%;">
				<col style="width:31%;">
            </colgroup>
            <thead>
				<tr>
				<th id="chkStyle"><input type="checkbox" id="chkAll"></th>
				<th colspan="3" id="listStyle">주문내역</th>
				</tr>
			</thead>
			<tbody>
            <c:forEach var="ord" items="${ orderData }">
            <tr>
				<td rowspan="5"><input type="checkbox" name="chk" value="${ ord.ord_cd }"
					<c:if test="${ ord.ord_stat_name eq '주문취소' }"> disabled="disabled"</c:if>
				></td>
				<!-- <td class="orderInfo" colspan="3"><strong>1조네 해남 호박 고구마 3kg 외 1건</strong></td> -->
				<td class="orderInfo" colspan="3"><strong>${ ord.pro_name }</strong></td>
			</tr>
			<tr>
				<!-- <td class="orderInfo" colspan="3">주문번호:123456</td> -->
				<td class="orderInfo" colspan="3">주문번호 : ${ ord.ord_cd }</td>
			</tr>
			<tr>
				<!-- <td class="orderInfo" colspan="3">2021.01.01</td> -->
				<td class="orderInfo" colspan="3">${ ord.ord_date }</td>
			</tr>
			<tr>
				<!-- <td class="orderInfo" colspan="3">0원</td> -->
				<td class="orderInfo" colspan="3">${ ord.ord_price }원</td>
			</tr>
			<tr style="border-bottom: 2px solid #D09869;">
				<!-- <td class="orderInfo" colspan="3">배송중</td> -->
				<td class="orderInfo" colspan="3">${ ord.ord_stat_name }</td>
			</tr>
            </c:forEach>
			</tbody>
        </table>
        </div>
        
        <p style="text-align:center;"><!-- 56px -->
		  <button type="button" class="btn btn-default btn-lg" id="cancelBtn">주문취소</button>
		  <button type="button" class="btn btn-default btn-lg" id="backBtn" onclick="goBack()">돌아가기</button>
		</p>
        </div>
        </form>
<jsp:include page="../layout/footer.jsp"/>
</body>
</html>
