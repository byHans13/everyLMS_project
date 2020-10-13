<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
header {
	/* background-color: gray; */
	
}

aside {
	/* background-color: blue; */
	width: 300px;
	float: left;
}

section {
	/* background-color: pink; */
	width: 1000px;
	float: left;
}

#nomalmypt {
	margin: 50px 100px;
	font-family: Consolas, monospace;
	font-style: italic;
	font-size: 55px;
	width: 150px;
	height: 150px;
	border: 5pt groove #707070;
	font-family: Consolas, monospace;
}

#resultmypt {
	margin: 50px 100px;
	font-family: Consolas, monospace;
	font-style: italic;
	font-size: 55px;
	width: 100px;
	height: 100px;
	border: 5pt groove #707070;
	font-family: Consolas, monospace;
}
#resultview{
margin-top:500px;
	width: 1000px;
}
#resultimg{
	position: absolute;
	margin-left: 250px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../h2k5every_aside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
		<input type='hidden' id='token' data-token-name='${_csrf.headerName}'
			name='${_csrf.parameterName}' value='${_csrf.token}' /> <input
			type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<h2 style="text-align: center;">충전 성공!</h2>
			<img src="../upload/h2k5_payview.png" style = "width:450px;height:450px;" id="resultimg"/>
		<table id="resultview">
		<tr></tr>
	<tr>
			<td><a href="../stud/goLoginFrm"><button class = "btn btn-danger">홈으로</button></a></td>
	</tr>
		</table>
				<h2>${resultpt}</h2>
	</section>
</body>
</html>
