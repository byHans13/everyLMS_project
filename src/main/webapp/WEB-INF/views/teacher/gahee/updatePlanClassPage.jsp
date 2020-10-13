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
		position: absolute;
	transform:translate(320px,20px);
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
}
.button3:hover {
  background-color: #f44336;
  color: white;
}

</style>
</head>
<body>
<header>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
<form method="post" id='upfrm' >
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
<table class="type07">
    <thead>
    <tr>
        <th>강의계획서 수정</th>
        <th>내용</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th>강의명</th>
        <td><input type="text" disabled="disabled" id='clname' style="border: solid 1px #fff;" required="required"></td>
    </tr>
    <tr>
        <th>총회차</th>
        <td><input type="text" id='lcnum' disabled="disabled" style="border: solid 1px #fff;" required="required">회차</td>
    </tr>
    <tr>
        <th>난이도</th>
        <td><input type="number" disabled="disabled" id='lv' name='pc_lv' style="border: solid 1px #fff;" required="required">LV</td>
    </tr>
    <tr>
        <th>개요</th>
        <td><input type="text" id='title' name='pc_title' required="required" style="border: solid 1px #fff;"></td>
    </tr>
    <tr>
        <th>내용</th>
        <td><input type="text" id='cont' name='pc_cont' required="required" style="border: solid 1px #fff;"></td>
    </tr>
    </tbody>
</table>
<input type="hidden" id='idnum' name='pc_idnum' required="required" >
<button type="button" id='upbtn' class='button3'>수정하기</button>
<button type="reset" class='button3'>취소</button>
</form>



</section>
<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
<script>
var update = ${upPlanClass};
console.dir(update);
if(update != ""){
	var con = update.cont;
	var pc_con = con.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');

	$('#clname').val(update.clname);
	$('#lcnum').val(update.lcnum);
	$('#lv').val(update.lv);
	$('#title').val(update.title);
	$('#cont').val(update.cont);
	$('#idnum').val(update.idnum);
}

$('#upbtn').click(function() {
	var cont = $('#cont').val();
	var pc_cont = cont.replace(/\n/g, '<br>');
	$('#cont').val(pc_cont);
	var lv = $('#lv').val();
	$(this).attr("type","submit");
	console.log($('#cont').val());
	$('#upfrm').attr("action","updateplanclass?lv="+lv);
	//console.log("gn: "+$('#lv').val());
	$('#upfrm').submit();

}); 


$(function() {
	var msg= "${msg}";
	console.log("msg: "+msg);
	if(msg!=""){
		alert(msg);
		msg="";
	}
});

</script>

</body>
</html>