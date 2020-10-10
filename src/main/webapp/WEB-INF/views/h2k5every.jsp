<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>＜h2＞k5＜h2＞ - Main</title>
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
</head>
<body>
<script>
$(document).ready
(function() {
	var id = "${id}";
	console.log(id);
	/* if (id != ""){
		$("#goTeacherPage").append("<p style='margin-top: auto;'><b><a href='goTeacherLoginFrm' style='color: white; '>강사페이지이동</a></b></p>");
	} */

});</script>
	<header>
		<%-- <%@ include file="h2k5every_header.jsp"%><!-- 정적인 방식 --> --%>
		<jsp:include page="h2k5every_header.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="h2k5every_aside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
		<jsp:include page="h2k5every_section.jsp" />
	</section>

	<footer>
		<jsp:include page="h2k5every_footer.jsp" />
	</footer>
		<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<script>

</script>
</body>
</html>
















