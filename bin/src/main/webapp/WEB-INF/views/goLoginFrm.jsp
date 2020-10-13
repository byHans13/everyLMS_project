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
<style>
header {
	/* background-color: gray; */
}

aside {
	/* background-color: blue; */
	width: 300px;
	float: left;
	position: absolute;
	transform :translate(0px, 230px;)
}

section {
	/* background-color: pink; */
	width: 1000px;
	float: left;
	position: absolute;
	transform:translate(300px,0px); 
}
.menu{
    margin-left: 20px;
    text-align:center;
    width: 200px;
    border: 1px black solid;
    float: left;
}
fieldset{
	border: solid black;

}
</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<body>
  <input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
<script>
 $(document).ready
(function() {
	console.log('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}');
	console.log('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}');
	//var aut =JSON.parse("${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}");
	var aut= "${aut}";
	console.log(aut);
	var n = aut.indexOf("ROLE_PROF");
	console.log("권한체크",n);
	var profCheck ="${profCheck}";
	console.log(profCheck);
	 var id = "${id}";
	 console.log("hansnq3"+id);
/* 	if (n != -1){
		$("#goTeacherPage").append("<p style='margin-top: auto;'><b><a href='/h2k5every/prof/goTeacherLoginFrm' style='color: white; '>강사페이지이동</a></b></p>");
	}
	else if (n == -1 && profCheck < 1){
		$("#goTeacherPage").append("<p style='margin-top: auto;'><b><a href='/h2k5every/stud/registertoprof' style='color: white; '>강사등록하러가기</a></b></p>");
	}else{
		$("#goTeacherPage").append("<p style='margin-top: auto;'><b><a href='#' style='color: white; '>강사 신청중인 상태입니다.</a></b></p>");
		
	} */
	test(id);
}); 
</script>
	<header>
		<%-- <%@ include file="h2k5every_header.jsp"%><!-- 정적인 방식 --> --%>
		<jsp:include page="h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="h2k5every_aside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
			<fieldset>
			<legend id="recomendLecture">
			<h3> 
			<b>추천강의</b>
			</h3>
			</legend>
			<div>
			<table> <thead>
            <tr>
                <th>시작</th>
            </tr>
        </thead></table>
			
			</div>
			</fieldset>
			<div id="menu"><h3><b>관심사</b></h3></div>
			
	</section>
	<footer>
		<jsp:include page="h2k5every_footer.jsp" />
	</footer>
		
<script>
function test(id) {
	$.ajax({
		type:'get',
		url:'rest/selectConcern',
		datatype:'json',
		success: function (json) {
			console.log(json);
			console.log(json.length);
		
			for(var i=0; i<json.length; i++){
				$('#menu').append("<div class='menu'><p>"+json[i]+"</p></div>");
			}
			
		},
		error: function (err) {
			console.log(err);
		}
		
	});
} 
</script>
</body>
</html>