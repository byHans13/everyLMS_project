<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
</head>
<body>
<h1 id="n"></h1>
<form action="insertCourse?${_csrf.parameterName }=${_csrf.token}"  method="post" enctype="multipart/form-data" id="frm">
<h3>제목</h3>
<input type="text" placeholder="제목을 입력하세요" name="co_name" required="required"><br>
<h3>강의 등록</h3>
<input type="file" name="fileName" id="files"><br>
<h3>내용</h3>
<textarea cols="20" rows="30" name="co_cont" placeholder="내용을 입력하세요" style="width: 300px; height: 100px; overflow: auto;" required="required" wrap="hard"></textarea><br>
<input type="hidden" name="co_idnum" id="a">
<input type="hidden" name="co_num" id="b">
<input type="hidden" name="fl_num" id="c">
<button type="button" id="btn">강의 등록하기</button>
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
</form>
<button type="reset">취소</button>



<script>

var idnum = "${co_idnum}";
var num = "${co_num}";
console.log("idnum:  "+idnum);
console.log("num:  "+num);


if(idnum != "" && num !=""){
	$('#n').text(num+"강 업로드");
	$('#a').attr("value",idnum);
	$('#b').attr("value",num);
	$('#c').attr("value",num);
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
		$(this).submit();
	}else{
		alert("동영상을 선택해 주세요.");
	}
});


</script>
</body>
</html>