<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
</head>
<style>
        aside {
	width: 300px;
	float: left;
}
section {
	width: 1000px;
	float: left;
		position: absolute;
	transform:translate(320px,20px);
}
table.type07 {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    border: 1px solid #ccc;
    margin: 20px 10px;
}
table.type07 thead {
    border-right: 1px solid #ccc;
    border-left: 1px solid #ccc;
    background: #e7708d;
}
table.type07 thead th {
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
}
table.type07 tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #fcf1f4;
}
table.type07 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
</style>
<body>
<header>
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
<h1>과제 업로드</h1>
<form enctype="multipart/form-data" method="post" action="inserthomework?${_csrf.parameterName }=${_csrf.token}">

        <table class="type07">
    <thead>
    <tr>
        <th>과제 업로드</th>
        <th>내용</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th>강좌회차</th>
        <td><input type="text" disabled="disabled" id='hw_num' style="border: solid 1px #fff;" required="required">회차</td>
    </tr>
    <tr>
        <th>강의난이도</th>
        <td><input type="text" id='hw_lv' disabled="disabled" style="border: solid 1px #fff;" required="required">LV</td>
    </tr>
    <tr>
        <th>제목</th>
        <td><input type="text" placeholder="제목을 입력하세요" name="hw_hwname"  id='hw_hwname' style="border: solid 1px #fff;" required="required"></td>
    </tr>
    <tr>
        <th>파일첨부</th>
        <td><input type='file' name="fileName" id="files" required="required" style="border: solid 1px #fff;"></td>
    </tr>
    <tr>
        <th>제줄날짜</th>
        <td><input  type="date" name="hw_date" required="required" id='hw_date' style="border: solid 1px #fff;"></td>
    </tr>
    <tr>
        <th>과제등록</th>
        <td><button type="button" id="btn">과제 업로드</button></td>
    </tr>
    </tbody>
</table> 
 		<input type="hidden" name="hw_idnum" id='hw_idnum'>
 		<input type="hidden" name="hw_num" id='num'>
 		<input type="hidden" name="hw_lv" id='lv'>
        <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
</form>
<button type="reset">취소</button>
 </section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>



<script>
var hb = ${hb};
console.dir(hb);
if(hb!=""){
	$('#hw_num').val(hb.hw_num);
	$('#hw_lv').val(hb.hw_lv);
	$('#num').val(hb.hw_num);
	$('#lv').val(hb.hw_lv);
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