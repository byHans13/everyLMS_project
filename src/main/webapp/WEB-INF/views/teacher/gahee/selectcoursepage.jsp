<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<meta charset="UTF-8">
<!-- ajax 통신을 위한 meta tag -->
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<title>Insert title here</title>
<style>
video{
width: 500px;
height: 500px;
}
</style>
</head>
<body>
<h1>강의 보여주기</h1>
<h2>회차: </h2><p id="num"></p><br>
<h2>제목: </h2><p id="name">
<h2>동영상 </h2>
<video id="sysname" autoplay="autoplay" controls="controls"></video>
<h2>내용: </h2><p id="cont"></p>

<form method="post" action="deletecourse">
<input type="hidden" id='dnum' name='co_num'>
<input type="hidden" id='dname' name='co_name'>
<input type="hidden" id='dsysname' name = 'fl_sysname'>
<input type="hidden" id='dcont' name='co_cont'>
<input type="hidden" id='didnum' name='co_idnum'>
<input type="hidden" id='dlv' name='co_lv'>
<button type="submit">강의 삭제하기</button>
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
</form>

<form method="post" action="updatecoursepage">
<input type="hidden" id='unum' name='co_num'>
<input type="hidden" id='uname' name='co_name'>
<input type="hidden" id='usysname' name = 'fl_sysname'>
<input type="hidden" id='ucont' name='co_cont'>
<input type="hidden" id='uidnum' name='co_idnum'>
<input type="hidden" id='ulv' name='co_lv'>
<button type="submit">강의 수정하기</button>
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
</form>

<a href="classmain/0"><button>홈으로</button></a>

<script>
var List = ${myCoList};
var myCoList = List[0];
console.dir(myCoList);
if(myCoList !=""){
	$('#num').text(myCoList.co_num);
	$('#name').text(myCoList.co_name);
	$('#cont').html(myCoList.co_cont);
	$('#sysname').attr("src","../video/"+myCoList.fbList[0].fl_sysname);
	
	$('#dnum').attr("value",myCoList.co_num);
	$('#dname').attr("value",myCoList.co_name);
	$('#dcont').attr("value",myCoList.co_cont);
	$('#dsysname').attr("value",myCoList.fbList[0].fl_sysname);
	$('#didnum').attr("value",myCoList.co_idnum);
	$('#dlv').attr("value",myCoList.co_lv);
	
	
	$('#unum').attr("value",myCoList.co_num);
	$('#uname').attr("value",myCoList.co_name);
	$('#ucont').attr("value",myCoList.co_cont);
	$('#usysname').attr("value",myCoList.fbList[0].fl_sysname);
	$('#uidnum').attr("value",myCoList.co_idnum);
	$('#ulv').attr("value",myCoList.co_lv);
}



</script>
</body>

</html>