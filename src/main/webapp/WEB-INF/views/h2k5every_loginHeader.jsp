<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<script type="text/javascript">
$(document).ready
(function() {
	
	console.log('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}');
	console.log('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}');
	//var aut =JSON.parse("${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}");
	var aut= "${aut}";
	console.log(aut);
	var p = aut.indexOf("ROLE_PROF");
	var s = aut.indexOf("ROLE_STUD");
 	var a = aut.indexOf("ROLE_ADMI");
	console.log("권한체크p",p);
	console.log("권한체크s",s);
	console.log("권한체크a",a);
	var profCheck ="${profCheck}";
	console.log(profCheck);
	 var id = "${id}";
	 console.log("hansnq3"+id);
	if (p != -1 && a == -1 ){
		$("#mainlogo").attr("href","/h2k5every/prof/goTeacherLoginFrm");
	}
	else if (p == -1 && s != -1 && a==-1){
		$("#mainlogo").attr("href","/h2k5every/stud/goLoginFrm");
	}else{
		$("#mainlogo").attr("href","/h2k5every/admi/admiLogin");
		
	}
});

</script>

<body>
	<header>
		<a id="mainlogo" href="#"><img src="../upload/h2k5_mainLogo.PNG"
			 width="200"></a>
	</header>
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">＜h2＞k5＜h2＞</a>
			</div>
			<ul class="nav navbar-nav">
				<li class="active"><a href="#">Main</a></li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">강의관리<!-- <span class="caret"></span> --></a>
					<!-- <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">강의관리<span class="caret"></span></a> -->
					<!-- <ul class="dropdown-menu">
						<li><a href="#">세부내역 1-1</a></li>
						<li><a href="#">세부내역 1-2</a></li>
						<li><a href="#">세부내역 1-3</a></li>
					</ul></li> -->
				<li><a href="#">성적 관리</a></li>
				<li><a href="#">FeedBack 관리</a></li>
			</ul>
			<div class="container">
				<!-- <form class="navbar-form navbar-left" action="#">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Search">
					</div>
						<button type="submit" class="btn btn-default">검색</button>
				</form> -->
				<form id='logout' action=<c:url value='/gologout' /> method='post'>
					<ul class="nav navbar-nav navbar-right">
							<input name="${_csrf.parameterName}" type="hidden"
								value="${_csrf.token}" />
						<li><a href="#"
							onclick="document.getElementById('logout').submit();" ><span
								class="glyphicon glyphicon-log-in"></span>로그아웃</a></li>
						</form>
						<li><a href="/h2k5every/stud/myinfopage"><span class="glyphicon glyphicon-user"></span>마이페이지</a></li>
						<li><a href="#"><span></span>고객센터</a></li>
					</ul>
			</div>
		</div>
	</nav>
	<script>
		function logout() {
			$('#logout').submit();
		}
	</script>
</body>
</html>