<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- css -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<title>Insert title here</title>
<style>
header {
	/* background-color: gray; */
	 position: absolute; 
	 transform:translate(0px,0px);  
	 width: 1500px; 
}

aside {
	/* background-color: blue; */
	width: 300px;
	float: left;
	 position : absolute;
	 transform:translate(0px,230px);  
}

section {
	/* background-color: pink; */
	width: 1000px;
	float: left;
	position: absolute;
	transform:translate(320px,100px);
}
.menu{
    margin-left: 20px;
    text-align:center;
    width: 200px;
    border: 1px black solid;
    float: left;
}

.sbClassTh, .sbClassTd{
/* 	border-bottom: 1px solid #999; */
/* 	color: #666; */
/* 	border-collapse: collapse; */
/* 	table-layout::fixed; */
/* 	text-align: center; */
/* 	width: 180px; */
/* 	height: 50px; */
text-align: center;
}

.sbClassTh{
	border-top: solid 1px #999;
	border-bottom: solid 1px #b2b2b2;
	background-color: #cce6ff;
	color: #333;
	font-weight: bold;
	line-height: 20px;
	vertical-align: center;
	font-size: 20px;
}

.btn-outline-primary{
	background-color: :#cce6ff;
}

</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<body>
<input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<header id = "header">
		<%-- <%@ include file="h2k5every_header.jsp"%><!-- 정적인 방식 --> --%>
		<jsp:include page="h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
		<div id="aaa">
			<h3>
				<b>추천강의</b>
			</h3>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" id="muListValue" value="${muList}">
		<div id="menu">
			<h3>
				<b>관심사</b>
			</h3>
		</div>
	</section>
	<footer>
		<jsp:include page="h2k5every_footer.jsp" />
	</footer>
		
<script>
	var muList = $("#muListValue").val();
	console.log("muList = "+muList);
	console.log("muList = "+"${muList}");
function test(id) {
	$.ajax({
		type:'get',
		url:'rest/selectConcern',
		datatype:'json',
		beforeSend : function(xhr)
		{
			//이거 안하면 403 error
			//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
		success: function (json) {
			console.log(json);
			console.log(json.length);
			if(muList != null){
			$("#aaa").html("${muList}");
		
				for(var i=0; i<json.length; i++){
					$('#menu').append("<div class='menu'><p>"+json[i]+"</p></div>");
				}
			}
		},
		error: function (err) {
			console.log(err);
		}
		
	});
} 

	
	
	
	$(function() {
		
		var id= "${id}";
		console.log(id);
		test(id);
		
	});
</script>
</body>
</html>