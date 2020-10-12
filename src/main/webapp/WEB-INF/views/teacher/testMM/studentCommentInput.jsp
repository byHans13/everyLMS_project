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
.tg  {border-collapse:collapse;border-color:#9ABAD9;border-spacing:0;}
.tg td{background-color:#EBF5FF;border-color:#9ABAD9;border-style:solid;border-width:0px;color:#444;
  font-family:Arial, sans-serif;font-size:14px;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{background-color:#409cff;border-color:#9ABAD9;border-style:solid;border-width:0px;color:#fff;
  font-family:Arial, sans-serif;font-size:14px;font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-i74k{border-color:#9abad9;font-size:32px;text-align:center;vertical-align:top}
.tg .tg-nejw{border-color:#68a0d7;font-size:32px;text-align:center;vertical-align:top}
.tg .tg-dlxr{background-color:#D2E4FC;font-size:32px;text-align:center;vertical-align:top}
.tg .tg-j32n{font-size:32px;text-align:center;vertical-align:top}
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
	<section id="section" style="margin-left: 20px; background-color: #409cff; height: 80px;">
		<h1 style="color: white; font-size: 35px;" id="cmt"></h1>
		<div style="height: 100px;"></div>
		<div>
			<form action='studentCommentInsert' method="post">
			<table id="infoTable" class="tg" style="width: 1200px;">

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
		$("#cmt").html("<b>"+lq.co_name+" -코멘트 쓰기</b>");
		$("#infoTable").append("<tr>");
		$("#infoTable").append("<th class='tg-nejw'>강좌명 : "+lq.co_name+"</th>");
		$("#infoTable").append("<th class='tg-i74k'>강좌 레벨 : "+lq.co_lv+"</th>");
		$("#infoTable").append("<th class='tg-nejw'>회차 : "+lq.cl_lcnum+"</th>");
		$("#infoTable").append("<th class='tg-i74k'>아이디 : "+lq.gr_id1+"</th>");
		$("#infoTable").append("<th class='tg-nejw'>점수 : "+lq.gr_score+"</th>");
		$("#infoTable").append("</tr>");
		$("#infoTable").append("<tr><td class='tg-dlxr' colspan='5'>코멘트 작성</td></tr>");
		$("#infoTable").append("<tr><td class='tg-j32n' colspan='5'><textarea name='tfb_feedback' cols='73' rows='8'></textarea></td></tr>");
		$("#infoTable").append("<tr><td class='tg-dlxr' colspan='5'>"+
							   "<input type='hidden' name='cl_idnum' value="+lq.cl_idnum+">"+
							   "<input type='hidden' name='co_lv' value="+lq.co_lv+">"+
							   "<input type='hidden' name='cl_lcnum' value="+lq.cl_lcnum+">"+
							   "<input type='hidden' name='gr_id1' value="+lq.gr_id1+">"+
							   "<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
							   "<button class='btn btn-primary'>작성</button></td></tr>");
	}
	
	
});
</script>
</body>
</html>