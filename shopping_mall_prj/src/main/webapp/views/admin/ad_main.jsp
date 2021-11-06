<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
    <c:if test="${empty sessionScope.admin_id}">
    <!-- 세션에 이름이 없음 -->
    <c:redirect url="ad_login.jsp"/>
    </c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 페이지</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="http://localhost/shopping_mall_prj/common/css/custom.css" >
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"
	integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF"
	crossorigin="anonymous"></script>
	
<!-- datepicker -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- /datepicker -->	

<!-- summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- /summernote -->

<script type="text/javascript">
$(function() {
    $("#home_datepicker1,#home_datepicker2,#order_datepicker1,#order_datepicker2").datepicker({
        dateFormat: 'yy-mm-dd' //달력 날짜 형태
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
        ,changeYear: true //option값 년 선택 가능
        ,changeMonth: true //option값  월 선택 가능                
        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
        ,buttonImage: "http://localhost/shopping_mall_prj/common/image/calendar.png" //버튼 이미지 경로
        ,buttonImageOnly: false //버튼 이미지만 깔끔하게 보이게함
        ,buttonText: "선택" //버튼 호버 텍스트              
        ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
        ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        ,maxDate: "+0D" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)  
    });                    
    
    //초기값을 오늘 날짜로 설정
    $("#home_datepicker1,#home_datepicker2,#order_datepicker1,#order_datepicker2").datepicker("setDate", "today"); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)     
    
	$('#summernote').summernote({
		  height: 450,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
        
	});
});

function fileUpload(fis) {
	var reader = new FileReader();
	reader.onload = function(e) {
		$('#loadImg').attr('src', e.target.result);
	}
	reader.readAsDataURL(fis.files[0]);
}

/*  탭유지
	$(function() {
    $('a[data-toggle="list"]').on('click', function(e) {
        window.localStorage.setItem('activeTab', $(e.target).attr('href'));
    });
    var activeTab = window.localStorage.getItem('activeTab');
    if (activeTab) {
        $('#menuList a[href="' + activeTab + '"]').tab('show');
    }
});  */
</script>
</head>
<!-- 네비바를 fiexd-top으로 설정했을 때 컨텐츠와 겹치는 문제 방지 -->
<body class="pt-5">
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">관리자페이지</a>
		</div>
	</nav>
	
	<!-- Page Content -->
	<div class="container-fluid h-100">
		<div class="row h-100">
			<div class="col-md-3 col-lg-2 menuTab">
				<div class="list-group mb-4 mt-4" id="menuList">
					<a href="#list-home" class="list-group-item list-group-item-action active text-left py-4 mb-2 font-weight-bold" data-toggle="list">HOME</a>
					<a href="#list-user" class="list-group-item list-group-item-action text-left py-4 mb-2 font-weight-bold" data-toggle="list">회원관리</a>
					<a href="#list-order" class="list-group-item list-group-item-action text-left py-4 mb-2 font-weight-bold" data-toggle="list">주문관리</a>
					<a href="#list-product" class="list-group-item list-group-item-action text-left py-4 mb-2 font-weight-bold" data-toggle="list">상품관리</a>
				</div>
			</div>

			<div class="col-md-9 col-lg-10 mt-4 mb-4">
					<div class="tab-content h-100">
      					<div class="tab-pane border-0 h-100 active" id="list-home"><jsp:include page="ad_home.jsp"/></div>
      					<div class="tab-pane border-0 h-100" id="list-user"><jsp:include page="ad_user.jsp"/></div>
      					<div class="tab-pane border-0 h-100" id="list-order"><jsp:include page="ad_order.jsp"/></div>
      					<div class="tab-pane border-0 h-100" id="list-product"><jsp:include page="ad_product.jsp"/></div>
      				</div>
			</div>
		</div> 
	</div> 
</body>
</html>