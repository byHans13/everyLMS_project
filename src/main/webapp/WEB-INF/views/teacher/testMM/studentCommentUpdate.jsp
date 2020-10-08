<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		<h1 id="cmt"></h1>
		<div style="height: 100px;"></div>
		<div>
			<form action='studentCommentUpdate' method="post">
			<table id="infoTable">

			</table>
			</form>
		</div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>

<script>
$(document).ready
(function() {
	var lq= ${lq};
	console.log(lq);
	console.log(lq.co_name);
	
	if(lq=="0"){
		alert("가져올 내용이 없습니다.");
	}else{
		$("#cmt").html(lq.co_name+" -코멘트 쓰기");
		$("#infoTable").append("<tr>");
		$("#infoTable").append("<th style='text-align: center;'>강좌명 : "+lq.co_name+"</th>");
		$("#infoTable").append("<th style='text-align: center;'>강좌 레벨 : "+lq.co_lv+"</th>");
		$("#infoTable").append("<th style='text-align: center;'>회차 : "+lq.cl_lcnum+"</th>");
		$("#infoTable").append("<th style='text-align: center;'>아이디 : "+lq.gr_id1+"</th>");
		$("#infoTable").append("<th style='text-align: center;'>점수 : "+lq.gr_score+"</th>");
		$("#infoTable").append("</tr>");
		$("#infoTable").append("<tr><td colspan='5'>코멘트 작성</td></tr>");
		var test = lq.tfb_feedback;
		var	tfb_feedback = test.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
		$("#infoTable").append("<tr><td colspan='5'><textarea name='tfb_feedback' cols='30' rows='10'>"+tfb_feedback+"</textarea></td></tr>");
		$("#infoTable").append("<tr><td colspan='5'>"+
							   "<input type='hidden' name='cl_idnum' value="+lq.cl_idnum+">"+
							   "<input type='hidden' name='co_lv' value="+lq.co_lv+">"+
							   "<input type='hidden' name='cl_lcnum' value="+lq.cl_lcnum+">"+
							   "<input type='hidden' name='gr_id1' value="+lq.gr_id1+">"+
							   "<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
							   "<button>작성</button></td></tr>");
	}
	
});
</script>
</body>
</html>