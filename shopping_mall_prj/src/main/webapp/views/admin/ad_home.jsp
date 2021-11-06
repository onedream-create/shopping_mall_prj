<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<ul class="nav nav-tabs">
	<li class="nav-item"><a class="nav-link active" data-toggle="tab"
		href="#home_dash">대시보드</a></li>
	<li class="nav-item"><a class="nav-link" data-toggle="tab"
		href="#home_account">관리자계정</a></li>
</ul>

<div class="tab-content content">
	<div class="tab-pane active h-100" id="home_dash">
		<div class="container-fluid">
			<div class="row mt-4">
				<div class="col-12">
					<div class="contentlabel">실시간 매출 현황</div>
					<table class="table table-bordered">
						<thead>
							<tr class="tcol">
								<td>오늘</td>
								<td>이번달</td>
							</tr>
						</thead>
						<tbody>
							<tr class="trow">
								<td>_원(_건)</td>
								<td>_원(_건)</td>
							</tr>
						<tbody>
					</table>
				</div>
			</div>
			<div class="row mt-5">
				<div class="col-12">
					<div class="contentlabel">기간별 매출 현황</div>
				</div>
				<div class="col-12 mt-4">
					<input type="text" id="home_datepicker1"> ~ <input type="text"
						id="home_datepicker2">
					<input type="button" class="btn btn-dark btn-sm ml-2" value="검색"/>
				</div>
				<div class="col-6 mt-4">
					<div class="period">_원(_건)</div>
				</div>
			</div>
		</div>
	</div>
	<div class="tab-pane h-100" id="home_account">
		<div class="container home_account_form">
			<div class="mb-5"><h3>관리자 비밀번호 변경</h3></div>
			<form action="#" method="post" id="passUpdateFrm">
				<div class="form-group row justify-content-md-center">
					<label class="col-md-4 col-form-label">현재 비밀번호</label>
					<div class="col-md-6">
						<input type="password" id="nowPass" class="form-control">
					</div>
				</div>
				<div class="form-group row justify-content-md-center">
					<label class="col-md-4 col-form-label">새 비밀번호</label>
					<div class="col-md-6">
						<input type="password" class="form-control">
					</div>
				</div>
				<div class="form-group row justify-content-md-center">
					<label class="col-md-4 col-form-label">비밀번호 확인</label>
					<div class="col-md-6">
						<input type="password" class="form-control">
					</div>
				</div>
				<input type="button" id="passUpdate" class="btn btn-dark col-md-2 offset-md-8" value="변경"/>
			</form>
		</div>
	</div>
</div>
