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
</head>
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
</style>
<body>
    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<header>
		<%-- <%@ include file="h2k5every_header.jsp"%><!-- 정적인 방식 --> --%>
		<jsp:include page="h2k5every_loginHeader.jsp" /> <!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="h2k5every_adminAside.jsp" />
	</aside>
	<section id="section">
		<jsp:include page="goAdminLoginPage.jsp" />
	</section>
	<footer>
		<jsp:include page="h2k5every_footer.jsp" />
	</footer>
</body>
<script type="text/javascript">
$(document).ready
(function() {
console.log('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}');
console.log('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}');
//var aut =JSON.parse("${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}");
var aut= '${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}';
console.log(aut);
var n = aut.indexOf("ROLE_PROF");
console.log(n);

 var id = "${id}";
 console.log("hansnq3"+id);
if (n != -1){
	$("#goTeacherPage").append("<p style='margin-top: auto;'><b><a href='/h2k5every/prof/goTeacherLoginFrm' style='color: white; '>강사페이지이동</a></b></p>");
}
});
</script>

</html>