<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<title>Insert title here</title>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
</head>
<body>
<h1 id="num"></h1>
<form action="updatecourse?${_csrf.parameterName }=${_csrf.token}"  method="post" enctype="multipart/form-data" id="frm">
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
<h3>제목</h3>
<input type="text" name="co_name" required="required" id='uname'><br>
<h3>강의 등록</h3>
<input type="file" name="fileName" id="files" ><br>
<h3>내용</h3>
<textarea cols="20" rows="30" id='ucont' name="co_cont" style="width: 300px; height: 100px; overflow: auto;" required="required" wrap="hard"></textarea><br>
<input type="hidden" id='uidnum' name=co_idnum>
<input type="hidden" id='ulv' name='co_lv'>
<input type="hidden" id='unum' name='co_num'>
<button type="button" id="btn">강의 수정하기</button>
</form> 
<button type="reset">취소</button>



<script>

var cb =${cb};
console.dir(cb);
var cfb = ${cfb};
console.dir(cfb);

$('#num').text(cb.co_num+"강입니다.");
$('#uname').val(cb.co_name);
$('#ucont').val(cb.co_cont);





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
		var con = $('#ucont').val();
		var cont = con.replace(/\n/g, '<br>');
		$('#ucont').val(cont);
		$('#uidnum').val(cb.co_idnum);
		$('#ulv').val(cb.co_lv);
		$('#unum').val(cb.co_num);
		$(this).attr("type","submit");
		$(this).submit();
	}else{
		alert("동영상을 선택해 주세요.");
	}
});




</script>


</body>
</html>