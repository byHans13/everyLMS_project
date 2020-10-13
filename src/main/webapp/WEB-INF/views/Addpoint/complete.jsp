<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
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

table{
  border-collapse: separate;
  border-spacing: 0 10px;
  border-bottom: 1px solid white;
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
			<table
				style="height: 100%; width: 70%; margin-left: 20%; margin-top: 20%;">
				<tr>
					<td colspan="2" style="text-align: center;border-bottom: none;"><h2>감사합니다!</h2></td>
				</tr>
				<tr>
					<td colspan="2"><img src="../upload/h2k5_mainLogo.PNG" id="resultimg" style="text-align: center; margin-left: 80px;"/></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;"><h2>${resultpt}원</h2></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;"><h2>충전이 완료되었습니다.</h2></td>
				</tr>
			</table>
			<a href="../stud/goLoginFrm"><button class="btn btn-dangger" style="margin-left: 50%">홈으로</button></a>
	</section>
</body>
</html>