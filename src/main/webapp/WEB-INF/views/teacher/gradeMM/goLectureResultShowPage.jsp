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
  <input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<header>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
	
	<form id="frm">	
		<div style="background-color: #409cff; height: 80px; color: white; font-size: 35px;">
			<h2 id="cmthtml" style="float: left; margin-left: 10px;margin-top: 15px;"></h2>
		</div>
	</form>	
		
		<div style="height: 100px;"></div>
		
		<div id="selectbox" style="height: 500px; overflow: auto;">
			
			<table id="selectTable" class="tg" style="width: 1200px;">
			</table>
		</div>
		
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
<script>
var list=${list};
var clname='${clname}';
var kind=0; 
	console.log(list);
	console.log(clname);
	
	if(list[0].gr_kind=='T'){
		$("#cmthtml").html("<b>"+clname+" 시험 성적관리</b>");
		kind=0;
	}else{
		$("#cmthtml").html("<b>"+clname+" 퀴즈 성적관리</b>");
		kind=1;
	}
	
	$("#selectTable").append("<tr>");
	$("#selectTable").append("<th class='tg-tns0'>강좌명</th>");
	$("#selectTable").append("<th class='tg-tns0'>회차</th>");
	$("#selectTable").append("<th class='tg-tns0'>학생</th>");
	$("#selectTable").append("<th class='tg-tns0'>점수</th>");
	$("#selectTable").append("<th class='tg-tns0'>문제보기</th>");
	$("#selectTable").append("</tr>");
	
	for(var i=0;i<list.length;i++){
		var clname = clname.replace(/ /gi,',');
		var test2 = list[i].co_name;
		var co_name = test2.replace(/ /gi,',');
		
		$("#selectTable").append("<tr>");
		$("#selectTable").append("<td class='tg-g9xd'>"+list[i].co_name+"</td>");
		$("#selectTable").append("<td class='tg-dlxr'>"+list[i].gr_num+"</td>");
		$("#selectTable").append("<td class='tg-dlxr'>"+list[i].gr_id1+"</td>");
		$("#selectTable").append("<td class='tg-dlxr'>"+list[i].gr_score+"</td>");
		$("#selectTable").append("<td class='tg-dlxr'> <form action='goLectureResultUpdatePage' method='post'>"+
				"<input type='hidden' name='cl_clname' value="+clname+">"+
				"<input type='hidden' name='co_name' value="+co_name+">"+
				"<input type='hidden' name='cl_lcnum' value="+list[i].gr_num+">"+
				"<input type='hidden' name='cl_idnum' value="+list[i].gr_idnum+">"+
				"<input type='hidden' name='gr_id1' value="+list[i].gr_id1+">"+
				"<input type='hidden' name='pb_pbchkqz' value="+kind+">"+
				"<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
				"<button class='btn btn-primary'>클릭</button></form></td>");
		$("#selectTable").append("</tr>");
	}
	
</script>
</body>
</html>