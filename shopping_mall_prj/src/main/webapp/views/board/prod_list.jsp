<%@page import="java.text.DecimalFormat"%>
<%@page import="kr.co.shopping_mall.model.ProductVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.shopping_mall.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="상품게시판페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상품게시판</title>

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
<style type="text/css">
#title{ 
	text-align:left; color: #D09869; 
	font-weight: bold; 
	font-family: 'Sunflower', sans-serif; 
	margin-top:50px; 
}
#pro{
	text-decoration: none;
	color:#000;
}
</style>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%
ProductDAO pd=new ProductDAO();
String tempPage=request.getParameter("page");
int cnt=0;
String category_cd=null;
String searchValue=null;
if(request.getParameter("category_cd") != null){
	category_cd=request.getParameter("category_cd");
	cnt=Integer.parseInt(pd.countPro(Integer.parseInt(category_cd)));//전체 데이터 개수
}else{
		searchValue=request.getParameter("searchValue");
		cnt=Integer.parseInt(pd.countSearchPro(searchValue));
}//end else
	
if(searchValue == ""){%>
	<script>
	alert("검색어를 입력해주세요.");
	window.history.back();
	</script>
<%}

int cPage;//현재 페이지

//현재 페이지 정하기
if(tempPage ==null || tempPage.length() == 0){
	cPage=1;
}//end if
try{
	cPage=Integer.parseInt(tempPage);
}catch(NumberFormatException e){
	cPage=1;
}//end catch

//전체 데이터 개수(행수) 구하기
int totalRows=cnt;

//총 페이지 수 구하기
int len=20; //한 페이지에 보여줄 데이터 수
int totalPages=(totalRows%len==0?totalRows/len:(totalRows/len)+1);
if(totalPages==0){
	totalPages=1;
}//end if
if(cPage>totalPages){
	cPage=1;
}//end if

//각 페이지 데이터 시작점 구하기
int start=(cPage-1)*len;

//각 페이지의 시작점으로 len개의 데이터 가져오기
List<ProductVO> list=null;
if(request.getParameter("category_cd") != null){
	list=pd.selectPro(Integer.parseInt(category_cd), start, len);
}else{
	list=pd.selectSearchPro(searchValue, start, len);
}//end else
	
DecimalFormat fmt=new DecimalFormat("#,###,###,##0원");
for(ProductVO pv : list){
	pv.setPro_price_fmt(fmt.format(pv.getPro_price()));
}//end for

pageContext.setAttribute("proData", list);
pageContext.setAttribute("proCnt", cnt);

int pageLength=3;
int currentBlock=cPage % pageLength ==0?cPage/pageLength : (cPage/pageLength)+1;
int startPage=(currentBlock-1)*pageLength+1;
int endPage=startPage+pageLength-1;
if(endPage>totalPages){
	endPage=totalPages;
}//end if
%>
<!-- Section-->
<section class="py-5">
<div class="container px-4 px-lg-5">
	<c:if test="${ param.category_cd eq 0 }">
		<h2 id="title">전체상품</h2>
	</c:if>
	<c:if test="${ param.category_cd eq 1 }">
		<h2 id="title">농산물</h2>
	</c:if>
	<c:if test="${ param.category_cd eq 2 }">
		<h2 id="title">수산물</h2>
	</c:if>
	<c:if test="${ param.category_cd eq 3 }">
		<h2 id="title">축산물</h2>
	</c:if>
	<c:if test="${ param.category_cd eq null }">
		<h2 id="title">'${ param.searchValue }' 검색 결과</h2>
	</c:if>

</div>
	<div class="container px-4 px-lg-5 mt-5">
		<div
			class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
			<!-- 상품 -->
			
			<c:if test="${ proCnt ne 0 }">
			<c:forEach var="pro" items="${ proData }">
			<c:set var="i" value="${ i+1 }"/>
			<div class="col mb-5">
			<a href="http://localhost/shopping_mall_prj/views/board/prod_detail.jsp?pro_cd=${ pro.pro_cd }" id="pro">
				<div class="card h-100" id="pro">
					<!-- Product image-->
					<img class="card-img-top"
						src="http://placehold.it/550X500" alt="..." />
					<!-- Product details-->
					<div class="card-body p-4">
						<div class="text-center">
							<!-- Product name-->
							<h5 class="fw-bolder"><c:out value="${ pro.pro_name }"/></h5>
							<!-- Product price-->
							<c:out value="${ pro.pro_price_fmt }"/>
						</div>
					</div>
				</div>
			</a>
			</div>
			</c:forEach>
			<%-- </c:if>
			<c:if test="${ proCnt eq 0 }">
				<div>해당 상품이 존재하지 않습니다.</div>
			</c:if> --%>

		</div>
	</div>
	
	<!-- 페이징 -->	
	<nav aria-label="Page navigation example">
		<ul class="pagination pagination justify-content-center">
			<%
				if(startPage ==1){
			%>
			<li class="page-item disabled"><a class="page-link" href="#" tabindex="-1"
				aria-disable="true">Previous </a></li>
			<%
				}else{
			%>
			<li class="page-item"><a class="page-link" href="http://localhost/shopping_mall_prj/views/board/prod_list.jsp?<%if(category_cd!=null) {%>category_cd=<%=category_cd%><%}else{ %>searchValue=<%=searchValue %><%} %>&page=<%=startPage-1 %>"
				 tabindex="-1" aria-disable="true">Previous </a></li>
			<%
				}//end else
			%>
			<%
				for(int i=startPage; i <= endPage; i++){
			%>
			<li class="page-item">
			<a class="page-link" href="http://localhost/shopping_mall_prj/views/board/prod_list.jsp?<%if(category_cd!=null) {%>category_cd=<%=category_cd%><%}else{ %>searchValue=<%=searchValue %><%} %>&page=<%=i%>"><%= i  %></a></li>
			<%
				}//end for
			%>
			<%
				if(totalPages==endPage){
			%>
			<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
			<%
				}else{
			%>
			<li class="page-item"><a class="page-link" 
			href="http://localhost/shopping_mall_prj/views/board/prod_list.jsp?<%if(category_cd!=null) {%>category_cd=<%=category_cd%><%}else{ %>searchValue=<%=searchValue %><%} %>&page=<%=endPage+1%>">Next</a></li>
			<%
				}//end else
			%>
		</ul>
	</nav>	
	</c:if>
		<c:if test="${ proCnt eq 0 }">
			<div>해당 상품이 존재하지 않습니다.</div>
		</c:if>
</section>

<%@ include file="../layout/footer.jsp"%>
</body>
</html>