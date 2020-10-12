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
	 position: absolute; 
	 transform:translate(0px,0px);  
	 width: 1500px;  
	 height: 200px;
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
	margin-top: 100px;
}
.menu{
    margin-left: 20px;
    text-align:center;
    width: 200px;
    border: 1px black solid;
    float: left;
}

.sbClassTable{
border: black 1px solid;
}

.sbClassTh,.sbClassTd{
border: black 1px solid;
border-collapse: collapse;
text-align: center;
width: 180px;
height: 50px;
}

.sbClassTh{
background-color: skyblue;
font-size: 20px;
}

</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<body>
<input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<header id ="header">
		<jsp:include page="h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	
	<aside>
		<jsp:include page="h2k5every_teacherAside.jsp" />
	</aside>
	
	<section id="section" style="margin-left: 20px;">
	
			<div id="aaa"><h3><b>추천강의</b></h3></div>
			<div style="border:solid black 1px; overflow:scroll; width: 1100px;height: 600px;">
			${muList}
			</div>
			    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" /></div>
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
		
			for(var i=0; i<json.length; i++){
				$('#menu').append("<div class='menu'><p>"+json[i]+"</p></div>");
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