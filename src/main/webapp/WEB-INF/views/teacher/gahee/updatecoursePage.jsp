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
<form action="updatecourse?${_csrf.parameterName }=${_csrf.token}"  method="post" enctype="multipart/form-data" id="frm">
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
<table class="type07">
    <thead>
    <tr>
        <th id="num"></th>
        <th>내용</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th>제목</th>
        <td><input type="text" name="co_name" required="required" id='uname' style="border: solid 1px #fff;"></td>
    </tr>
    <tr>
        <th>강의등록<br>(비디오 등록)</th>
        <td><input type="file" name="fileName" id="files" required="required" style="border: solid 1px #fff;"></td>
    </tr>
    <tr>
        <th>내용</th>
        <td><input type="text" name="co_cont" required="required" id='ucont' style="border: solid 1px #fff;"></td>
    </tr>
    </tbody>
</table>
<input type="hidden" id='uidnum' name=co_idnum>
<input type="hidden" id='ulv' name='co_lv'>
<input type="hidden" id='unum' name='co_num'>
<button type="button" id="btn" class='button3'>강의 수정하기</button>
<button type="reset" class='button3'>취소</button>
</form> 

</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>



<script>

var cb =${cb};
console.dir(cb);
var cfb = ${cfb};
console.dir(cfb);

$('#num').text(cb.co_num+"회차 강좌 수정");
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