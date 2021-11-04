<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<h1
		style="text-align: center; font-size:2.5rem; margin: 30px 0; color: #D09869; font-weight: bold; font-family: 'Sunflower', sans-serif;">
		<a href="http://localhost/shopping_mall_prj/index.jsp" style="text-decoration:none; color:#D09869;">1조네 농산물</a></h1>
	<input type="button" class="btn" value="로그인"
		style="position: absolute; top: 10px; right: 30px;">
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<%
				String cate_total="전체상품";
				String cate_n="농산물";
				String cate_c="축산물";
				String cate_s="수산물";
				cate_total=URLEncoder.encode(cate_total,"UTF-8");
				cate_n=URLEncoder.encode(cate_n,"UTF-8");
				cate_c=URLEncoder.encode(cate_c,"UTF-8");
				cate_s=URLEncoder.encode(cate_s,"UTF-8");
			%>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="http://localhost/shopping_mall_prj/board/prod_list.jsp?name=<%=cate_total %>" >전체상품</a></li>
					<li class="nav-item"><a class="nav-link" href="http://localhost/shopping_mall_prj/board/prod_list.jsp?name=<%=cate_n%>">농산물</a></li>
					<li class="nav-item"><a class="nav-link" href="http://localhost/shopping_mall_prj/board/prod_list.jsp?name=<%=cate_s %>">수산물</a></li>
					<li class="nav-item"><a class="nav-link" href="http://localhost/shopping_mall_prj/board/prod_list.jsp?name=<%=cate_c %>">축산물</a></li>
				</ul>
				<form class="d-flex" action="#void">
					<div class="input-group" style="align-items: center;">
						<input type="text" class="form-control"
							style="border-radius: 0.25rem; width: 200px; height: 38px; margin-right: 5px; line-height: 62px;">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button"
								style="border-radius: 0.25rem; border: 1px solid #212529; color: #000000; margin-right: 20px;">검색</button>
						</span>
					</div>
					<!-- /input-group -->
					<button class="btn btn-outline-dark" type="submit"
						style="width: 176px">
						<i class="bi-cart-fill me-1"></i> Cart <span
							class="badge bg-dark text-white ms-1 rounded-pill">0</span>
					</button>
				</form>
			</div>
		</div>
	</nav>

