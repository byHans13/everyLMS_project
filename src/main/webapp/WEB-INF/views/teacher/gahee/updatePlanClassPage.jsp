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
<h1>업데이트 강의계획서</h1>
<form method="post" id='upfrm' >
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
<h3>강의명: </h3><input type="text" readonly="readonly" id='clname'>
<h3>총회차: </h3><input type="text" id='lcnum' readonly="readonly">
<h3>난이도: </h3><input type="number" readonly="readonly" id='lv' name='pc_lv'>
<h3>개요: </h3><input type="text" id='title' name='pc_title' required="required">
<h3>내용: </h3><textarea cols="20" rows="30" id='cont' style="width: 300px; height: 100px; overflow: auto;" required="required" wrap="hard" name='pc_cont'></textarea>
<input type="hidden" id='idnum' name='pc_idnum' required="required">
<hr><button type="button" id='upbtn'>수정하기</button>
</form>  
<button type="reset">취소</button>
<script>
var update = ${upPlanClass};
if(update != ""){
	var con = update.cont;
	var pc_con = con.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');

	$('#clname').val(update.clname);
	$('#lcnum').val(update.lcnum);
	$('#lv').val(update.lv);
	$('#title').val(update.title);
	$('#cont').val(pc_con);
	$('#idnum').val(update.idnum);
}

$('#upbtn').click(function() {
	var cont = $('#cont').val();
	var pc_cont = cont.replace(/\n/g, '<br>');
	$('#cont').val(pc_cont);
	$(this).attr("type","submit");
	console.log($('#cont').val());
	$('#upfrm').attr("action","updateplanclass");
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