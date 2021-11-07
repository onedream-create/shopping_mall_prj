$(function() {
	$("#home_datepicker1,#home_datepicker2,#order_datepicker1,#order_datepicker2").datepicker({
		dateFormat: 'yy-mm-dd' //달력 날짜 형태
		, showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		, showMonthAfterYear: true // 월- 년 순서가아닌 년도 - 월 순서
		, changeYear: true //option값 년 선택 가능
		, changeMonth: true //option값  월 선택 가능                
		, showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
		, buttonImage: "http://localhost/shopping_mall_prj/common/image/calendar.png" //버튼 이미지 경로
		, buttonImageOnly: false //버튼 이미지만 깔끔하게 보이게함
		, buttonText: "선택" //버튼 호버 텍스트              
		, yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
		, monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 텍스트
		, monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip
		, dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 텍스트
		, dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 Tooltip
		, minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		, maxDate: "+0D" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)  
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

	//비밀번호변경폼 새비밀번호 일치 확인
	$('#newPassCheck').keyup(function() {
		if ($('#newPassCheck').val() != $('#newPass').val()) {
			$('font[name=passCheck]').text('');
			$('font[name=passCheck]').attr('color','red');
			$('font[name=passCheck]').html("새로운 비밀번호가 일치하지 않습니다");
		} else {
			$('font[name=passCheck]').text('');
			$('font[name=passCheck]').attr('color','blue');
			$('font[name=passCheck]').html("새로운 비밀번호가 일치합니다");
		}
	});
}); //ready

function fileUpload(fis) {
	var reader = new FileReader();
	reader.onload = function(e) {
		$('#loadImg').attr('src', e.target.result);
	}
	reader.readAsDataURL(fis.files[0]);
}