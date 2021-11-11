<%@page import="kr.co.shopping_mall.model.ProductVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="주문내역상세"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>주문내역상세</title>
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
<jsp:useBean id="dVO" class="kr.co.shopping_mall.model.DeliveryVO" scope="page"/>
<jsp:setProperty property="*" name="dVO"/>
<%	
	dVO.getDv_name();
	dVO.getDv_tel();
	dVO.getDv_addr();
	dVO.getDv_memo();
%>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	ArrayList<ProductVO> cart=null;
	
	Object obj=session.getAttribute("cart");
	if(obj==null){//세션정보가 없으면 배열을 생성
		cart = new ArrayList<ProductVO>();
	}else{ //세션정보가 있으면 강제로 캐스팅 
		cart=(ArrayList<ProductVO>)obj;
	}
%>
<style>	
	h2{text-align:left; color:#D09869; font-weight: bold; font-family: 'Sunflower', sans-serif; margin:100px 0 40px 0;}
    table, th, td{ 
        text-align: center;
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
	.table>tbody>tr>td{
		padding:10px 0;
	}
	.table tr:nth-child(1){border-bottom:1px solid #D09869; border-top: 1px solid #D09869;}
	#tbl-product{margin-bottom:90px; border-top:1px solid #D09869;}
	#tbl-product tr:last-of-type td{text-align:right; background:#D09869; color:#FFFFFF; font-family: 'Sunflower', sans-serif; font-size:27px; padding-right:20px;}
	colgroup{text-align:left;}
	#tbl-info tr td:last-of-type{text-align:left; padding-left:50px;} 
	.bold{font-weight:bold;}
	p{text-align:center;}
   .btn1{
 		width:22%; height:56px; background:#D09869; color:#FFFFFF; border-color: #FFFFFF; margin-bottom:50px;font-size:15px;
	}
	.btn1:hover{color:#FFFFFF;}
	
</style>
<body>   
<jsp:include page="../layout/header.jsp"/>
	<form name="frm" action="../board/buyCompl.jsp" method="post">
        <div class="container">
        <h2>주문 내역 상세</h2>         
        <div class="table-responsive">
	 		<table class="table table-borderless" id="tbl-product">
	            <colgroup>
	                <col style="width: 15%" />
	                <col style="width: 50%" />
	                <col style="width: 10%" />
	                <col style="width: 15%" />
	            </colgroup>
	            <tr>             
	                <th>주문상품</th>   
	                <th>상품명</th>
	                <th>수량</th>
	                <th>가격</th> 
	            </tr>
	            <% 
	            int totalSum=0, total=0;
	            DecimalFormat df = new DecimalFormat("###,###,###,###,##0");
	            for(int i=0;i<cart.size();i++){ 
	            	ProductVO pv = cart.get(i);
	            out.println("<tr>");             
	            	out.println("<td><img src='../common/upload/" + pv.getPro_img() + "'></td>");
	                out.println("<td>" + pv.getPro_name() + "</td>");
	                out.println("<td>" + pv.getPro_name() + "</td>");
	                out.println("<td>" + pv.getCnt() + "</td>");
	                total = pv.getPro_price() * pv.getCnt();
	                out.println("<td>" + df.format(total) + "</td>");
	                out.println("</tr>");
	                totalSum += total;
	             } 
	            	out.println("<td id='total' colspan='5'>총 주문금액 :"+df.format(totalSum)+"원</td>");	
	            %>
	        </table>
        </div>
        <div class="table-responsive">
	        <table class="table table-borderless" id="tbl-info" style="margin-bottom:50px; border-top:1px solid #D09869;">
	        	<colgroup>
	                <col style="width: 15%;"/>
	                <col style="width: 85%;"/>
	            </colgroup>
	              <tr style="vertical-align:middle;">             
	                  <th colspan='2' style=" border-top-color: #D09869; border-bottom:1px solid #D09869;">배송정보</th> 
	              </tr>
	              <tr>
	              	<td class="bold">받는사람</td>
	              	<td><%= dVO.getDv_name() %></td>
	              </tr>
	              <tr style="border-bottom : none;">
	              	<td class="bold">휴대전화</td>
	              	<td><%= dVO.getDv_tel() %></td>
	              </tr>
	              <tr>
	              	<td class="bold">주소</td>
	              	<td><%= dVO.getDv_addr() %></td>
	              </tr>
	              <tr>
	              	<td class="bold">배송메모</td>
	              	<td><%= dVO.getDv_memo() %></td>
	              </tr>
	        </table>
        </div>
        <p style="text-align:center">
		  <button class="btn btn-default btn-lg btn1">돌아가기</button>
		</p>
	</div>
        </form>
<jsp:include page="../layout/footer.jsp"/>
</body>
</html>