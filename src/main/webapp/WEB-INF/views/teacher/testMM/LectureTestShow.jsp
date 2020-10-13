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
.tg .tg-tns0{font-size:32px;font-weight:bold;text-align:center;vertical-align:top}
.tg .tg-qncv{font-size:32px;text-align:left;vertical-align:top}
.tg .tg-g9xd{background-color:#D2E4FC;font-size:32px;text-align:left;vertical-align:top}
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
		<h1 style="color: white; font-size: 35px;"><b>${clname} -상세보기</b></h1>
		<div style="height: 100px;"></div>
		<div style="overflow: auto; height: 500px;">
			<table id="infoTable" class="tg" style="width: 1200px;">
			</table>
		</div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
<script>
$(document).ready
(function() {

	var qlist= ${qlist};
	console.log(qlist);
	
	if(qlist=="0"){
		alert("가져올 내용이 없습니다.");
	}else{
		
		$("#infoTable").append("<tr>");
		$("#infoTable").append("<th class='tg-tns0'>강좌명</th>");
		$("#infoTable").append("<th class='tg-tns0'>강좌 레벨</th>");
		$("#infoTable").append("<th class='tg-tns0'>회차</th>");
		$("#infoTable").append("<th class='tg-tns0'>학생 아이디</th>");
		$("#infoTable").append("<th class='tg-tns0'>학생 점수</th>");
		$("#infoTable").append("<th class='tg-tns0'>피드백</th>");
		$("#infoTable").append("</tr>");
		
		
		for(var i=0; i<qlist.length; i++){
			var test = qlist[i].co_name;
			var	co_name= test.replace(/ /gi,',');
			console.log(co_name);
			console.log(Object.keys(qlist[i]).length);
			
			$("#infoTable").append("<tr>");
			$("#infoTable").append("<td class='tg-g9xd'>"+qlist[i].co_name+"</td>");
			$("#infoTable").append("<td class='tg-dlxr'>"+qlist[i].co_lv+"</td>");
			$("#infoTable").append("<td class='tg-dlxr'>"+qlist[i].co_num+"</td>");
			$("#infoTable").append("<td class='tg-dlxr'>"+qlist[i].gr_id1+"</td>");
			$("#infoTable").append("<td class='tg-dlxr'>"+qlist[i].gr_score+"</td>");
			if(Object.keys(qlist[i]).length!=8){
			$("#infoTable").append("<td class='tg-dlxr'><form action='goStudentCommentInputPage' method='post'>"+
								   "<input type='hidden' name='cl_idnum' value="+qlist[i].cl_idnum+">"+
								   "<input type='hidden' name='co_name' value="+co_name+">"+
								   "<input type='hidden' name='co_lv' value="+qlist[i].co_lv+">"+
								   "<input type='hidden' name='cl_lcnum' value="+qlist[i].co_num+">"+
								   "<input type='hidden' name='gr_id1' value="+qlist[i].gr_id1+">"+
								   "<input type='hidden' name='gr_score' value="+qlist[i].gr_score+">"+
								   "<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
								   "<button class='btn btn-primary'>작성</button><td></form>");
			}else{
				$("#infoTable").append("<td class='tg-dlxr'><form action='goStudentCommentSeePage' method='post'>"+
						   "<input type='hidden' name='cl_idnum' value="+qlist[i].cl_idnum+">"+
						   "<input type='hidden' name='co_name' value="+co_name+">"+
						   "<input type='hidden' name='co_lv' value="+qlist[i].co_lv+">"+
						   "<input type='hidden' name='cl_lcnum' value="+qlist[i].co_num+">"+
						   "<input type='hidden' name='gr_id1' value="+qlist[i].gr_id1+">"+
						   "<input type='hidden' name='gr_score' value="+qlist[i].gr_score+">"+
						   "<input type='hidden' name='tfb_feedback' value='"+qlist[i].tfb_feedback+"'>"+
						   "<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
						   "<button class='btn btn-primary'>보기</button><td></form>");
			}
				
			$("#infoTable").append("</tr>");
		}
	  
	}
});
</script>
</body>
</html>