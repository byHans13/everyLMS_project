<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
</head>
<body>
<h1>과제 업로드</h1>
<form enctype="multipart/form-data" method="post" action="inserthomework?${_csrf.parameterName }=${_csrf.token}">
        <table>
        <tr><th>강좌회차</th><td><input type='text' readonly='readonly' name="hw_num" id='hw_num'></td></tr>
        <tr><th>강의난이도</th><td><input type='text' readonly='readonly' name="hw_lv" id='hw_lv'></td></tr>
        <tr><th>제목</th><td><input type="text" placeholder="제목을 입력하세요" required='required' name="hw_hwname"></td></tr>
        <tr><th>파일첨부</th><td><input type='file' name="fileName" id="files"></td></tr>
        <tr><th>제줄날짜</th><td><input type="date" name="hw_date"></td></tr>
        </table>
        <input type="hidden" name="hw_idnum" id='hw_idnum'>
        <button type="button" id="btn">과제 업로드하기</button>
        <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
</form>
<button type="reset">취소</button>




<script>
var hb = ${hb};
console.dir(hb);
if(hb!=""){
	$('#hw_num').val(hb.hw_num);
	$('#hw_lv').val(hb.hw_lv);
	$('#hw_idnum').val(hb.hw_idnum);
}




var isfile = 0;
$('#files').on("change",function(){
	console.dir(this);
	if($(this).val()==""){
		console.log("파일이 없습니다.");
		isfile = 0;
	}else{
		console.log("파일이 있습니다.");
		isfile = 1;
	}
});

$('#btn').click(function() {
	if(isfile == 1){
		$(this).attr("type","submit");
		$('form').submit();
	}else{
		alert("과제를 첨부해 주세요.");
	}
});
</script>
</body>
</html>