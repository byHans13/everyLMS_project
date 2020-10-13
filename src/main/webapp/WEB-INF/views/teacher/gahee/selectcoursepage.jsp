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
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<title>Insert title here</title>
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
video{
width: 500px;
height: 500px;
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
	<section id="section" style="margin-left: 50px;">

<table class="type07">
    <thead>
    <tr>
        <th>MY강좌</th>
        <th>내용</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th>회차</th>
        <td id="num"></td>
    </tr>
    <tr>
        <th>제목</th>
        <td id='name'></td>
    </tr>
    <tr>
        <th>강좌동영상</th>
        <td><video id="sysname" autoplay="autoplay" controls="controls"></video></td>
    </tr>
    <tr>
        <th>내용</th>
        <td id="cont"></td>
    </tr>
    </tbody>
</table>

<form method="post" action="deletecourse">
<input type="hidden" id='dnum' name='co_num'>
<input type="hidden" id='dname' name='co_name'>
<input type="hidden" id='dsysname' name = 'fl_sysname'>
<input type="hidden" id='dcont' name='co_cont'>
<input type="hidden" id='didnum' name='co_idnum'>
<input type="hidden" id='dlv' name='co_lv'>
<button type="submit" class='button3'>강의 삭제하기</button>
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
<button type="submit" class='button3'>강의 수정하기</button>
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>

</form>
<a href="classmain/0"><button class='button3'>홈으로</button></a>

</section>
<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>

<script>
var List = ${myCoList};
var myCoList = List[0];
console.dir(myCoList);
if(myCoList !=""){
	$('#num').text(myCoList.co_num+"회차");
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