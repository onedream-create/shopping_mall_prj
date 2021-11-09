<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
    <c:if test="${empty sessionScope.admin_id}">
    <c:redirect url="ad_login.jsp"/>
    </c:if>
<ul class="nav nav-tabs">
	<li class="nav-item"><a class="nav-link active" data-toggle="tab"
		href="#product_dash">대시보드</a></li>
	<li class="nav-item"><a class="nav-link" data-toggle="tab"
		href="#product_regist">상품등록</a></li>
	<li class="nav-item"><a class="nav-link" data-toggle="tab"
		href="#product_search">상품검색</a></li>
</ul>

<div class="tab-content content">
	<div class="tab-pane active h-100" id="product_dash">
		<div class="container-fluid">
			<div class="row mt-4">
				<div class="col-12">
					<div class="contentlabel">상품현황</div>
					<table class="table table-bordered">
						<thead>
							<tr class="tcol">
								<td class="col-3">등록된 상품</td>
								<td class="col-3">판매중인 상품</td>
								<td class="col-3">판매중이지 않은 상품</td>
							</tr>
						</thead>
						<tbody>
							<tr class="trow">
								<td>_개</td>
								<td>_개</td>
								<td>_개</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="container-fluid">-각 개수를 클릭시 항목에 맞는 데이터를 보여준다.</div>
		<div class="container-fluid">
			<div class="row mt-4">
				<div class="col-12">
					<div class="contentlabel">상품목록</div>
					<table class="table table-bordered">
						<thead>
							<tr class="tcol">
								<td class="col-2">상품코드</td>
								<td class="col-2">상품명</td>
								<td class="col-1">판매가</td>
								<td class="col-2">상품등록일자</td>
								<td class="col-1">판매상태</td>
								<td class="col-1">관리</td>
							</tr>
						</thead>
						<tbody>
							<tr class="trow">
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-md-center">
					<li class="page-item"><a class="page-link" href="#"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</ul>
			</nav>
		</div>
	</div>

	<div class="tab-pane h-100" id="product_regist">
		<div class="container-fluid">
			<div class="row">
				<div class="col-12">
					<div class="contentlabel">상품등록</div>
				</div>
			</div>
			<form id="addProductForm" method="post" enctype="multipart/form-data">
				<div class="row">
					<div class="col-7">
						<div class="row mt-3">
							<label class="col-3 col-form-label text-center">상품명</label> 
							<input type="text" name="pro_name" class="col-6 form-control">
						</div>
						<div class="row mt-3">
							<label class="col-3 col-form-label text-center">상품가격</label> 
							<input type="number" name="pro_price" class="col-6 form-control">
						</div>
						<div class="row mt-3">
							<label class="col-3 col-form-label text-center">이미지</label> 
							<input type="file" class="filestyle" name="pro_img">
						</div>
						<div class="row mt-3">
							<label class="col-3 col-form-label text-center">상품분류</label>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="category_cd" id="pro_category1" value="1"> 
								<label class="form-check-label" for="pro_category1">농산물</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="category_cd" id="pro_category2" value="2"> 
								<label class="form-check-label" for="pro_category2">수산물</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="category_cd" id="pro_category3" value="3"> 
								<label class="form-check-label" for="pro_category3">축산물</label>
							</div>
						</div>
					</div>
					<div class="col-5 mt-3"><img src="" id="loadImg" style="width: 300px;height:200px;"/></div>
				</div>
				<div class="row mt-3 justify-content-center">
					<div class="col-11">
						<label class="col-form-label text-center">상품상세설명</label>
						<textarea id="summernote" name="pro_detail"></textarea>
						<input type="button" id="addProductBtn" class="btn btn-dark px-4 mt-2 offset-11" value="등록" onclick="addProduct(); return false;"/>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div class="tab-pane h-100" id="product_search">
		<div class="container-fluid">
			<div class="row mt-4">
				<div class="col-12">
					<div class="contentlabel">상품검색</div>
					<div class="col-12 mt-2">
						<form action="#" method="post">
							<div class="form-group row">
								<label class="col-auto col-form-label text-center">상품검색</label>
								<div class="col-md-2">
									<select class="form-control">
										<option value="1">상품명</option>
										<option value="2">상품코드</option>
									</select>
								</div>
								<div class="col-md-3">
									<input type="text" name="pro_name" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-auto col-form-label text-center">상품분류</label>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="category_cd"
										id="pro_category4" value="4"> <label
										class="form-check-label" for="pro_category4">전체</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="category_cd"
										id="pro_category5" value="1"> <label
										class="form-check-label" for="pro_category5">농산물</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="category_cd"
										id="pro_category6" value="2"> <label
										class="form-check-label" for="pro_category6">수산물</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="category_cd"
										id="pro_category7" value="3"> <label
										class="form-check-label" for="pro_category7">축산물</label>
								</div>
								<input type="button" class="btn btn-dark ml-3" value="검색" />
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row mt-4">
				<div class="col-3">
					<input type="button" class="btn btn-dark mb-2" value="전체상품보기" />
				</div>
				<div class="col-12">
					<div class="contentlabel">상품목록</div>
					<table class="table table-bordered">
						<thead>
							<tr class="tcol">
								<td class="col-2">상품코드</td>
								<td class="col-2">상품명</td>
								<td class="col-1">판매가</td>
								<td class="col-2">상품등록일자</td>
								<td class="col-1">판매상태</td>
								<td class="col-1">관리</td>
							</tr>
						</thead>
						<tbody>
							<tr class="trow">
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-md-center">
					<li class="page-item"><a class="page-link" href="#"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</ul>
			</nav>
		</div>
	</div>
</div>