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
		placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
		toolbar: [
			    // [groupName, [list of button]]
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['table', ['table']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert',['picture','link','video']],
			    ['view', ['fullscreen', 'help']]
			  ],
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
		callbacks : { 
            onImageUpload : function(files, editor, welEditable) {
           	 		uploadSummernoteImageFile(files[0], this);
            },
			onMediaDelete : function(target){
				let answer = confirm("이미지를 삭제하시겠습니까?");
				if(answer){
					deleteSummernoteImageFile(target[0].src);
				}
			}
        }
	});

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
	
	$("input[name='pro_img']").on("change", function() {
	
		let fileInput = $("input[name='pro_img']");
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];
	
		if(!imgFileCheck(fileObj.name, fileObj.size)){
			$("input[name='pro_img']").val("");
			return false;
		} else {
			imgPreview(this);
		}
	});
}); //ready

//썸머노트 이미지 파일 업로드
function uploadSummernoteImageFile(file,el) {
	let data = new FormData();
	data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "proc/ad_uploadSummernoteImageFile.jsp",
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(url) {
					$(el).summernote('editor.insertImage', url); //url = 완전한 url이어야함 ../ 또는 c:// 안됨
				}
			});
}

//썸머노트 이미지 파일 삭제
function deleteSummernoteImageFile(src){
	let splitSrc = src.split("/");
	let fileName = splitSrc[splitSrc.length-1];
	
	let fileData = {fileName:fileName};
	
	$.ajax({
		url : "proc/ad_deleteSummernoteImageFile.jsp",
		data : fileData,
		type : "post",
	});
}

function imgFileCheck(fileName, fileSize){
	let regex = new RegExp("(.*?)\.(jpg|png)$");
	let maxSize = 1048576; //1MB
		
	if(fileSize >= maxSize){
		alert("[1MB]이하의 파일만 선택해주세요");
		return false;
	}	  
	if(!regex.test(fileName)){
		alert(".jpg 또는 .png 형식의 이미지 파일만 선택해주세요");
		return false;
	}
	return true;		
}

function imgPreview(fis) {
	let reader = new FileReader();
	reader.onload = function(e) {
		$('#loadImg').attr('src', e.target.result);
	}
	reader.readAsDataURL(fis.files[0]);
}

function addProduct() {
	if($("input[name='pro_name']").val()==""){
		alert("상품명을 입력하세요");
		$("input[name='pro_name']").focus();
		return false;
	}
	if($("input[name='pro_price']").val()==""){
		alert("상품가격을 입력하세요");
		$("input[name='pro_price']").focus();
		return false;
	}
	if($("input[name='pro_img']").val()==""){
		alert("상품이미지를 등록하세요");
		$("input[name='pro_img']").focus();
		return false;
	}
	if($("input[name='category_cd']:radio:checked").length < 1){
		alert("상품분류를 선택하세요");
		$("input[name='category_cd']").focus();
		return false;
	}
	if($("#summernote").val()==""){
		alert("상품설명을 입력하세요");
		$("#summernote").focus();
		return false;
	}
	
	let formData = new FormData($("#addProductForm")[0]);
	
	let answer = confirm("상품을 등록하시겠습니까?\n"+
							"\n상품명 : "+formData.get("pro_name")+
							"\n상품가격 : "+formData.get("pro_price")+
							"\n상품분류코드 : "+formData.get("category_cd")	
							);
	if(!answer){
		return false;
	}
	
	$.ajax({
		cache: false,
		url: "proc/ad_addProductProc.jsp",
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