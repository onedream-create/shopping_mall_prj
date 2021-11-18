<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="kr.co.shopping_mall.model.DeliveryVO"%>
<%@page import="kr.co.shopping_mall.model.OrderDetailVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.shopping_mall.dao.OrderDAO"%>
<%@page import="kr.co.shopping_mall.model.ProductVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="주문내역상세"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:catch var="e">
<%
//session을 통해 들어온 로그인 정보가 없으면 로그인페이지로 이동
String user_id=(String)session.getAttribute("user_id");
<<<<<<< HEAD
if(user_id==null){ %>
	<script>
	alert("로그인이 필요한 페이지입니다.");
	location.href="http://211.63.89.152/views/user/loginForm.jsp";
	</script>
<%}//end if
=======
if(user_id==null){ 
	
 response.sendRedirect("http://localhost/shopping_mall_prj/views/user/loginForm.jsp?err_flag=1");
 return;
}//end if %> 
<%
request.setCharacterEncoding("UTF-8");
//session을 통해 들어온 로그인 정보가 없으면 로그인페이지로 이동
>>>>>>> refs/heads/master
String ord_cd=request.getParameter("ord_cd");
//out.println(ord_cd);
OrderDAO od=new OrderDAO();
//ord_cd 값을 통한 주문 상세 정보 조회
List<OrderDetailVO> list=od.selectOrdDetail(ord_cd);
DeliveryVO dVO=od.selectDelivery(ord_cd);
List<ProductVO> pVO=od.selectPrd(ord_cd);

//개인정보 복호화
DataDecrypt dd=new DataDecrypt("AbcdEfgHiJkLmnOpQ");
dVO.setDv_name(dd.decryption(dVO.getDv_name()));
dVO.setDv_tel(dd.decryption(dVO.getDv_tel()));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>주문내역상세</title>
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
	                <col style="width: 40%" />
	                <col style="width: 15%" />
	                <col style="width: 20%" />
	            </colgroup>
	            <tr>             
	                <th>주문상품</th>   
	                <th>상품명</th>
	                <th>수량</th>
	                <th>가격</th> 
	            </tr>
	            <%
		         DecimalFormat df = new DecimalFormat("###,###,###,###,##0");
	             int totalSum=0, total=0;
	             for(int i=0; i< list.size() ;i++){
	             OrderDetailVO ov=list.get(i);
	             ProductVO pv=pVO.get(i);
	             %>
	             <tr>
				<td><img src="http://211.63.89.152/common/uploadImg/pro_img/<%=pv.getPro_img() %>" width='100' height='100'></td>
				<td><%=pv.getPro_name() %></td>
				<td><%= ov.getOrdd_qty() %></td>
				<% total = pv.getPro_price() * ov.getOrdd_qty(); %>
				<td><%= df.format(total) %></td>
				<% totalSum += total; %>
				</tr>
				<%} 
	            out.println("<tr>");
	            out.println("<td id='total' colspan='5'>총 주문금액 : "+df.format(totalSum)+"원</td>"); 
	            out.println("</tr>");
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
	              	<td><%=  dVO.getDv_name() %></td>
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
		  <button type="button" class="btn btn-default btn-lg btn1" onclick="location.href='http://211.63.89.152/views/user/myOrder.jsp'">돌아가기</button>
		</p>
	</div>
        </form>
<jsp:include page="../layout/footer.jsp"/>
</body>
</html>
</c:catch>
<c:if test="${ not empty e }">
<script type="text/javascript">
	alert("Error");
	location.href="http://211.63.89.152/views/user/myOrder.jsp";
</script>
</c:if>