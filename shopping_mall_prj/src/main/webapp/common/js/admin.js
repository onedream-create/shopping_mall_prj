$(function() {
	//페이지정보 초기화
	proDashCount();

	//==========================================================================================================================
	//datepicker	
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

	//==========================================================================================================================
	//썸머노트 세팅
	$('#summernote').summernote({
		height: 450,                 // 에디터 높이
		minHeight: null,             // 최소 높이
		maxHeight: null,             // 최대 높이
		focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
		lang: "ko-KR",					// 한글 설정
		placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
		toolbar: [
			// [groupName, [list of button]]
			['fontname', ['fontname']],
			['fontsize', ['fontsize']],
			['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
			['color', ['forecolor', 'color']],
			['table', ['table']],
			['para', ['ul', 'ol', 'paragraph']],
			['height', ['height']],
			['insert', ['picture', 'link', 'video']],
			['view', ['fullscreen', 'help']]
		],
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋움체', '바탕체'],
		fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72'],
		callbacks: {
			onImageUpload: function(files, editor, welEditable) {
				uploadSummernoteImageFile(files[0], this);
			},
			onMediaDelete: function(target) {
				let answer = confirm("이미지를 삭제하시겠습니까?");
				if (answer) {
					deleteSummernoteImageFile(target[0].src);
				}
			}
		}
	});

	//==========================================================================================================================
	//비밀번호변경폼 새비밀번호 일치 확인
	$("#newPassCheck,#newPass").keyup(function() {
		if ($('#newPassCheck').val() != $('#newPass').val()) {
			$('font[name=passCheck]').text('');
			$('font[name=passCheck]').attr('color', 'red');
			$('font[name=passCheck]').html("새로운 비밀번호가 일치하지 않습니다");
			$('#adPassUpdateBtn').attr("disabled", "disabled");
		} else {
			$('font[name=passCheck]').text('');
			$('font[name=passCheck]').attr('color', 'blue');
			$('font[name=passCheck]').html("새로운 비밀번호가 일치합니다");
			$('#adPassUpdateBtn').removeAttr("disabled");
		}
	});

	//==========================================================================================================================
	//상품등록중 상품이미지 첨부파일 미리보기 처리
	$("input[name='pro_img']").on("change", function() {

		let fileInput = $("input[name='pro_img']");
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];

		if (!imgFileCheck(fileObj.name, fileObj.size)) {
			$("input[name='pro_img']").val("");
			return false;
		} else {
			imgPreview(this);
		}
	});
}); //ready


//==========================================================================================================================
//상품등록중 상품이미지 첨부파일 유효성체크
function imgFileCheck(fileName, fileSize) {
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 1048576; //1MB

	if (fileSize >= maxSize) {
		alert("[1MB]이하의 파일만 선택해주세요");
		return false;
	}
	if (!regex.test(fileName)) {
		alert(".jpg 또는 .png 형식의 이미지 파일만 선택해주세요");
		return false;
	}
	return true;
}

//==========================================================================================================================
//상품등록중 등록된 상품이미지 첨부파일 미리보기
function imgPreview(fis) {
	let reader = new FileReader();
	reader.onload = function(e) {
		$('#loadImg').attr('src', e.target.result);
	}
	reader.readAsDataURL(fis.files[0]);
}

//==========================================================================================================================
//썸머노트 이미지 파일 업로드
function uploadSummernoteImageFile(file, el) {
	let data = new FormData();
	data.append("file", file);
	$.ajax({
		data: data,
		type: "POST",
		url: "proc/product/uploadSummernoteImageFile.jsp",
		contentType: false,
		enctype: 'multipart/form-data',
		processData: false,
		success: function(url) {
			$(el).summernote('editor.insertImage', url); //url = 완전한 url이어야함 ../ 또는 c:// 안됨
		}
	});
}

//==========================================================================================================================
//썸머노트 이미지 파일 삭제
function deleteSummernoteImageFile(src) {
	let splitSrc = src.split("/");
	let fileName = splitSrc[splitSrc.length - 1];

	let fileData = { fileName: fileName };

	$.ajax({
		url: "proc/product/deleteSummernoteImageFile.jsp",
		data: fileData,
		type: "post",
	});
}

//==========================================================================================================================
//상품등록
function addProduct() {
	if ($("input[name='pro_name']").val() == "") {
		alert("상품명을 입력하세요");
		$("input[name='pro_name']").focus();
		return false;
	}
	if ($("input[name='pro_price']").val() == "") {
		alert("상품가격을 입력하세요");
		$("input[name='pro_price']").focus();
		return false;
	}
	if ($("input[name='pro_img']").val() == "") {
		alert("상품이미지를 등록하세요");
		$("input[name='pro_img']").focus();
		return false;
	}
	if ($("input[name='category_cd']:radio:checked").length < 1) {
		alert("상품분류를 선택하세요");
		$("input[name='category_cd']").focus();
		return false;
	}
	if ($("#summernote").val() == "") {
		alert("상품설명을 입력하세요");
		$("#summernote").focus();
		return false;
	}

	let formData = new FormData($("#addProductForm")[0]);

	let answer = confirm("상품을 등록하시겠습니까?\n" +
		"\n상품명 : " + formData.get("pro_name") +
		"\n상품가격 : " + formData.get("pro_price") +
		"\n상품분류코드 : " + formData.get("category_cd")
	);
	if (!answer) {
		return false;
	}

	$.ajax({
		cache: false,
		url: "proc/product/addProProc.jsp",
		processData: false,
		contentType: false,
		type: 'POST',
		data: formData,
		success: function() {
			alert("등록 성공");
			$('#addProductForm')[0].reset();
			$('#summernote').summernote('reset');
			$('#loadImg').removeAttr("src");
		},
		error: function() {
			alert("등록 실패");
		}
	});
}

//==========================================================================================================================
//검색조건에 따라 상품갯수카운트하고 페이지버튼생성
function allProPagenation() {
	$("#searchValue").val("");
	$("#pro_category4").prop("checked", true);

	proPagenation();
}

function proPagenation() {
	let division = $("#pro_division").val();
	let searchValue = $("#searchValue").val();
	let category_cd = $("input[name='category_cd1']:radio:checked").val();

	let condition = { "division": division, "searchValue": searchValue, "category_cd": category_cd };

	$.ajax({
		cache: false,
		url: "proc/product/pagenation.jsp",
		type: 'get',
		data: condition,
		success: function(pageCount) {
			//페이징버튼 그려줄 태그의 선택자
			let paging = $("#productSearchPageNumber");
			paging.empty();
			//1,2,3 페이지 생성
			for (let i = 1; i <= pageCount; i++) {
				paging.append('<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:void(0)\">' + i + '</a></li>');
			}
			paging.find('li:nth-child(1)').addClass('active');
			productSearch(1); //바로 첫번째 페이지 그려줌

			//상품 페이지 1,2,3...클릭시 active효과주고 검색
			paging.find('li').click(function() {
				paging.find('li').removeClass('active');
				$(this).addClass('active');
				let index = $(this).text();
				productSearch(index);
			});
		},
		error: function() {
			alert("실패");
		}

	});
}

//==========================================================================================================================
//검색조건에따라 상품테이블 그리기
function productSearch(index) {
	let division = $("#pro_division").val();
	let searchValue = $("#searchValue").val();
	let category_cd = $("input[name='category_cd1']:radio:checked").val();

	let condition = { "index": index, "division": division, "searchValue": searchValue, "category_cd": category_cd };

	$.ajax({
		cache: false,
		url: "proc/product/productSearch.jsp",
		data: condition,
		dataType: 'json',
		success: function(data) {
			$("#ProSearchTbody").empty();
			let html = '';
			for (key in data) {
				html += '<tr class="trow">';
				html += '<td>' + data[key].no + '</td>';
				html += '<td>' + data[key].pro_cd + '</td>';
				html += '<td>' + data[key].pro_name + '</td>';
				html += '<td>' + data[key].pro_price + '</td>';
				html += '<td>' + data[key].input_date + '</td>';
				html += '<td>' + data[key].sell_fl + '</td>';
				html += '<td>' + '<a href=\"ad_product_updateForm.jsp?pro_cd=' + data[key].pro_cd + '\" onclick=\"window.open(this.href,\'_blank\',\'width=1200,height=300,top=200,left=200\'); return false;\">수정</a></td>';
				html += '</tr>';
			}
			$("#ProSearchTbody").append(html);
		},
		error: function() {
			alert("실패");
		}
	});
}

//==========================================================================================================================
//상품대시보드 등록상품,판매중,판매중이지않은상품 개수구하여 나타내기
function proDashCount() {
	$.ajax({
		cache: false,
		url: "proc/product/proDashCount.jsp",
		dataType: 'json',
		success: function(data) {
			$("#proDashCount").empty();
			let proDashCount = '';
			proDashCount += '<tr class="trow">';
			proDashCount += '<td>' + '<a href=\'javascript:void(0)\' onclick=\'proDashPagenation(\"' + data.countAll +',a\");\'>' + data.countAll + '개</a></td>';
			proDashCount += '<td>' + '<a href=\'javascript:void(0)\' onclick=\'proDashPagenation(\"' + data.countSellY +',y\");\'>' + data.countSellY + '개</a></td>';
			proDashCount += '<td>' + '<a href=\'javascript:void(0)\' onclick=\'proDashPagenation(\"' + data.countSellN +',n\");\'>' + data.countSellN + '개</a></td>';
			proDashCount += '</tr>'
			$("#proDashCount").append(proDashCount);
		},
		error: function() {
			alert("실패");
		}
	});
}

//==========================================================================================================================
//상품대시보드 페이지버튼 만들기
function proDashPagenation(cntData, flag) {
	
	let paging = $("#proDashPageNumber");
	let rowsPerPage = 8;
	let pageCount = Math.ceil(cntData / rowsPerPage);

	paging.empty();
	for (let i = 1; i <= pageCount; i++) {
		paging.append('<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:void(0)\">' + i + '</a></li>');
	}
	paging.find('li:nth-child(1)').addClass('active');
	proDashSearch(1);
	
	//상품 페이지 1,2,3...클릭시 active효과주고 검색
	paging.find('li').click(function() {
		paging.find('li').removeClass('active');
		$(this).addClass('active');
		let index = $(this).text();
		proDashSearch(index, flag);
	});
}
//==========================================================================================================================
//상품대시보드 상품테이블 만들기
function proDashSearch(index, flag) {
		
		let condition = {"index": index, "flag": flag};
	
		$.ajax({
		cache: false,
		url: "proc/product/productSearch.jsp",
		data: condition,
		dataType: 'json',
		success: function(data) {
			$("#ProSearchTbody").empty();
			let html = '';
			for (key in data) {
				html += '<tr class="trow">';
				html += '<td>' + data[key].no + '</td>';
				html += '<td>' + data[key].pro_cd + '</td>';
				html += '<td>' + data[key].pro_name + '</td>';
				html += '<td>' + data[key].pro_price + '</td>';
				html += '<td>' + data[key].input_date + '</td>';
				html += '<td>' + data[key].sell_fl + '</td>';
				html += '<td>' + '<a href=\"ad_product_updateForm.jsp?pro_cd=' + data[key].pro_cd + '\" onclick=\"window.open(this.href,\'_blank\',\'width=1200,height=300,top=200,left=200\'); return false;\">수정</a></td>';
				html += '</tr>';
			}
			$("#ProSearchTbody").append(html);
		},
		error: function() {
			alert("실패");
		}
	});
	
}