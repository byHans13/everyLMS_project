<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
  <input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<header>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
	
	<form id="frm">	
		<div style="background-color: #B7F0B1; height: 80px; ">
			<h2 id="cmthtml" style="float: left; margin-left: 10px;margin-top: 15px;"></h2>
		</div>
	</form>	
		
		<div style="height: 100px;"></div>
		
		<div id="selectbox">
			
			<table id="selectTable">
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
		$("#cmthtml").html(clname+" 시험 성적관리");
		kind=0;
	}else{
		$("#cmthtml").html(clname+" 퀴즈 성적관리");
		kind=1;
	}
	
	$("#selectTable").append("<tr>");
	$("#selectTable").append("<th style='text-align: center;'>강좌명</th>");
	$("#selectTable").append("<th style='text-align: center;'>회차</th>");
	$("#selectTable").append("<th style='text-align: center;'>학생</th>");
	$("#selectTable").append("<th style='text-align: center;'>점수</th>");
	$("#selectTable").append("<th style='text-align: center;'>문제보기</th>");
	$("#selectTable").append("</tr>");
	
	for(var i=0;i<list.length;i++){
		var clname = clname.replace(/ /gi,',');
		var test2 = list[i].co_name;
		var co_name = test2.replace(/ /gi,',');
		
		$("#selectTable").append("<tr>");
		$("#selectTable").append("<td>"+list[i].co_name+"</td>");
		$("#selectTable").append("<td>"+list[i].gr_num+"</td>");
		$("#selectTable").append("<td>"+list[i].gr_id1+"</td>");
		$("#selectTable").append("<td>"+list[i].gr_score+"</td>");
		$("#selectTable").append("<td> <form action='goLectureResultUpdatePage' method='post'>"+
				"<input type='hidden' name='cl_clname' value="+clname+">"+
				"<input type='hidden' name='co_name' value="+co_name+">"+
				"<input type='hidden' name='cl_lcnum' value="+list[i].gr_num+">"+
				"<input type='hidden' name='cl_idnum' value="+list[i].gr_idnum+">"+
				"<input type='hidden' name='gr_id1' value="+list[i].gr_id1+">"+
				"<input type='hidden' name='pb_pbchkqz' value="+kind+">"+
				"<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
				"<button>클릭</button></form></td>");
		$("#selectTable").append("</tr>");
	}
	
</script>
</body>
</html>