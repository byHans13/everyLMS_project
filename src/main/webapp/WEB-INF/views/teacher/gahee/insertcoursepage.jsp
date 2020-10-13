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
<style>
html, body {
   height: 100%;
   margin: 0
}
aside {
	width: 300px;
	float: left;
}
section {
	width: 1000px;
	float: left;
}
.menu{
    margin-left: 20px;
    text-align:center;
    width: 200px;
    border: 1px black solid;
    float: left;
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
.button3 {
  background-color: white; 
  color: black; 
  border: 2px solid #f44336;
  margin-top: 8px;
}
.button3:hover {
  background-color: #f44336;
  color: white;
}
</style>
</head>
<body>
<header style="width: 1500px;">
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
<form action="insertCourse?${_csrf.parameterName }=${_csrf.token}"  method="post" enctype="multipart/form-data" id="frm">

<table class="type07">
    <thead>
    <tr>
        <th id="n"></th>
        <th>내용</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th>제목</th>
        <td><input type="text" placeholder="제목을 입력하세요" name="co_name"style="border: solid 1px #fff;" required="required"></td>
    </tr>
    <tr>
        <th>강좌 등록<br>(비디오등록)</th>
        <td><input type="file" name="fileName" id="files" style="border: solid 1px #fff;" required="required"></td>
    </tr>
    <tr>
        <th>내용</th>
        <td><input type="text"  name="co_cont" placeholder="내용을 입력하세요" style="border: solid 1px #fff;" required="required"></td>
    </tr>
    </tbody>
</table>
<input type="hidden" name="co_idnum" id="a">
<input type="hidden" name="co_num" id="b">
<input type="hidden" name="fl_num" id="c">
<button type="button" id="btn" class='button3'>강의 등록하기</button>
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
<button type="reset" class='button3'>취소</button>
</form>

</section>
<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>



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