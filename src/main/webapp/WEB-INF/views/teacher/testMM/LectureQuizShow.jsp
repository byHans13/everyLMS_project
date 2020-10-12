<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	/* width: 1000px; */ 
	float: left;
}
.menu{
    margin-left: 20px;
    text-align:center;
    width: 200px;
    border: 1px black solid;
    float: left;
}
table{
	width: 1100px;
	margin:auto;
/* 	border: 1px solid black; */
	border-collapse: collapse;
	text-align: center;
}
th, td {
	font-size: 30px;
	/* border: 1px solid black; */
}
td{
	/* border: 1px solid black; */
}
</style>
</head>

<body>
	<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<header>
		<%-- <%@ include file="h2k5every_header.jsp"%><!-- 정적인 방식 --> --%>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	
	<div style="height: 50px;"></div>
	<section id="section" style="margin-left: 20px; background-color: #B7F0B1; height: 80px;">
		<h1>${clname} -상세보기</h1>
		<div style="height: 100px;"></div>
		<div>
			<table id="infoTable">
			</table>
		</div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
</body>
<script>
	
	$(document).ready
	(function() {
		var qlist= ${qlist};
		console.log(qlist);
		
		if(qlist=="0"){
			alert("가져올 내용이 없습니다.");
		}else{
			
			$("#infoTable").append("<tr>");
			$("#infoTable").append("<th style='text-align: center;'>강좌명</th>");
			$("#infoTable").append("<th style='text-align: center;'>강좌 레벨</th>");
			$("#infoTable").append("<th style='text-align: center;'>회차</th>");
			$("#infoTable").append("<th style='text-align: center;'>학생 아이디</th>");
			$("#infoTable").append("<th style='text-align: center;'>학생 점수</th>");
			$("#infoTable").append("</tr>");
			
			for(var i=0; i<qlist.length; i++){
				$("#infoTable").append("<tr>");
				$("#infoTable").append("<td>"+qlist[i].co_name+"</td>");
				$("#infoTable").append("<td>"+qlist[i].co_lv+"</td>");
				$("#infoTable").append("<td>"+qlist[i].co_num+"</td>");
				$("#infoTable").append("<td>"+qlist[i].gr_id1+"</td>");
				$("#infoTable").append("<td>"+qlist[i].gr_score+"</td>");
				$("#infoTable").append("</tr>");
			}
		}
	});
	
</script>
</html>