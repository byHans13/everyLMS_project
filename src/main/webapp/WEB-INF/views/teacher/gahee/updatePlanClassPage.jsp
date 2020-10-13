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
</head>
<body>
<h1>업데이트 강의계획서</h1>
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
<button type="button" id='upbtn'>수정하기</button>
</form>


<button type="reset">취소</button>
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