<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>강의별 과정 시험관리</title>
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
	<input type="hidden" id="token" data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<header>
		<%-- <%@ include file="h2k5every_header.jsp"%><!-- 정적인 방식 --> --%>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
	
	<form id="frm">	
		<div style="background-color: #B7F0B1; height: 80px; ">
			<h2 style="float: left; margin-left: 10px;margin-top: 15px;">강의별 과정 시험관리</h2>
			<button style="float: right; margin-right: 20px; margin-top: 30px; height: 30px;" 
					type="button" onclick="contSelect()">검색</button>
			<input style="float: right; height: 30px; margin-top: 30px;" type="text" name="cont"/> 
			<select style="float: right; height: 30px; margin-top: 30px;" name="box">
				<option value="0">전체검색</option>
				<option value="1">강의명</option>
				<option value="2">강좌명</option>
			</select>
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
$(document).ready
(function() {

	var	msg= '${msg}';
	if(msg!=''){
		console.log(msg);
		alert(msg);
	}
	
	$.ajax({
		type:'post',
		url:'rest/selectLectureTest',
		datatype:'json',
		beforeSend : function(xhr)
		{
			//이거 안하면 403 error
			//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
		success: function (json) {
			console.log(json);
			$("#selectTable").append("<tr>");
			$("#selectTable").append("<th style='text-align: center;'>강의명</th>");
			$("#selectTable").append("<th style='text-align: center;'>강좌명</th>");
			$("#selectTable").append("<th style='text-align: center;'>회차</th>");
			$("#selectTable").append("<th style='text-align: center;'>학생수</th>");
			$("#selectTable").append("<th style='text-align: center;'>반평균</th>");
			$("#selectTable").append("<th style='text-align: center;'>강사명</th>");
			$("#selectTable").append("<th style='text-align: center;'>상세보기</th>");
			$("#selectTable").append("</tr>");
			
			for(var i=0;i<json.length; i++){
				$("#selectTable").append("<tr>");
				var test = json[i].cl_clname;
					console.log(test);
				var clname = test.replace(/ /gi,',');
					console.log(clname);
				var test2 = json[i].co_name;
					console.log(test);
				var co_name = test2.replace(/ /gi,',');
					console.log(co_name);
					
				$("#selectTable").append("<td>"+json[i].cl_clname+"</td>");
				$("#selectTable").append("<td>"+json[i].co_name+"</td>");
				$("#selectTable").append("<td>"+json[i].co_num+"</td>");
				$("#selectTable").append("<td>"+json[i].gr_id+"</td>");
				$("#selectTable").append("<td>"+json[i].gr_score+"</td>");
				$("#selectTable").append("<td>"+json[i].cl_id+"</td>");
				$("#selectTable").append("<td> <form action='goLectureTestShowPage' method='post'>"+
										"<input type='hidden' name='cl_clname' value="+clname+">"+
										"<input type='hidden' name='co_name' value="+co_name+">"+
										"<input type='hidden' name='cl_lcnum' value="+json[i].co_num+">"+
										"<input type='hidden' name='cl_idnum' value="+json[i].cl_idnum+">"+
										"<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
										"<button>클릭</button></form></td>");
				$("#selectTable").append("</tr>");
				
			}
		},
		error: function (err) {
			console.log(err);
		}
		
	});//ajax

});//ready

function contSelect() {
	
	$.ajax({
		type:'post',
		url:'rest/selectboxLectureTest',
		data:$('#frm').serialize(),
		datatype:'json',
		beforeSend : function(xhr)
		{
			//이거 안하면 403 error
			//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
		success: function (json) {
			console.log(json);
			$("#selectTable").html("");
			$("#selectTable").append("<tr>");
			$("#selectTable").append("<th style='text-align: center;'>강의명</th>");
			$("#selectTable").append("<th style='text-align: center;'>강좌명</th>");
			$("#selectTable").append("<th style='text-align: center;'>회차</th>");
			$("#selectTable").append("<th style='text-align: center;'>학생수</th>");
			$("#selectTable").append("<th style='text-align: center;'>반평균</th>");
			$("#selectTable").append("<th style='text-align: center;'>강사명</th>");
			$("#selectTable").append("<th style='text-align: center;'>상세보기</th>");
			$("#selectTable").append("</tr>");
			
			for(var i=0;i<json.length; i++){
				$("#selectTable").append("<tr>");
				var test = json[i].cl_clname;
					console.log(test);
				var clname = test.replace(/ /gi,',');
					console.log(clname);
				var test2 = json[i].co_name;
					console.log(test);
				var co_name = test2.replace(/ /gi,',');
					console.log(co_name);
					
				$("#selectTable").append("<td>"+json[i].cl_clname+"</td>");
				$("#selectTable").append("<td>"+json[i].co_name+"</td>");
				$("#selectTable").append("<td>"+json[i].co_num+"</td>");
				$("#selectTable").append("<td>"+json[i].gr_id+"</td>");
				$("#selectTable").append("<td>"+json[i].gr_score+"</td>");
				$("#selectTable").append("<td>"+json[i].cl_id+"</td>");
				$("#selectTable").append("<td> <form action='goLectureTestShowPage' method='post'>"+
										"<input type='hidden' name='cl_clname' value="+clname+">"+
										"<input type='hidden' name='co_name' value="+co_name+">"+
										"<input type='hidden' name='cl_lcnum' value="+json[i].co_num+">"+
										"<input type='hidden' name='cl_idnum' value="+json[i].cl_idnum+">"+
										"<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
										"<button>클릭</button></form></td>");
				$("#selectTable").append("</tr>");
				
			}
			
		},
		error: function (err) {
			console.log(err);
		}
	});	
}
</script>
</body>
</html>