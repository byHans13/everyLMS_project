<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
 	/* border: 1px solid black;  */
	border-collapse: collapse;
	text-align: center;
}
th, td {
	font-size: 30px;
	/* border: 1px solid black; */
}
td{
	/*  border: 1px solid black;  */
	height: 60px;
}
.Tbtn {
	width: 150px;
	height: 50px;
}
</style>
</head>
<body>
	<input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
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
		
		<table>
			<tr>
				<td><button class="Tbtn" type="button" onclick="isTestTaker(1)" id="isTestTaker">All</button></td>
				<td rowspan="4">
					<div>
						<p>응시자: <b id="text1"></b></p>
						<p>미 응시자: <b id="text2"></b></p>
					</div>
				</td>
			</tr>
			<tr>
				<td><button class="Tbtn" type="button" onclick="isTestTaker(2)" id=testTaker>응시</button></td>
			</tr>
			<tr>
				<td><button class="Tbtn" type="button" onclick="isTestTaker(3)" id="nonTestTaker">미응시</button></td>
			</tr>
		</table>			
		<hr>
		<div style="height: 10px;"></div>
		<div style="overflow: auto; height: 400px;">
			
			<table id="infoTable">

			</table>
			
		</div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
	
<script>
	var it=${it};

$(document).ready
(function() {
	console.log(it);
	
	$("#cmt").html(it.cl_clname+" 응시 or 미응시 확인");
	
});

function isTestTaker(cnt) {
	$("#infoTable").html("");
	console.log(it);
	console.log("All");
 	$.ajax({
		type:'post',
		url:'rest/isTestTakerSelect?co_name='+it.co_name+'&gr_num='+it.gr_num,
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
			var testTakercnt=0;
			var nonTestTakercnt=0;

			$("#infoTable").append("<tr>");
			$("#infoTable").append("<th style='text-align: center;'>강좌명</th>");
			$("#infoTable").append("<th style='text-align: center;'>회차</th>");
			$("#infoTable").append("<th style='text-align: center;'>학생</th>");
			$("#infoTable").append("<th style='text-align: center;'>응시여부</th>");
			$("#infoTable").append("</tr>");
			
			switch (cnt) {
			case 1:
				for(var i=0; i<json.length; i++){
					
					$("#infoTable").append("<tr>");
					$("#infoTable").append("<td>"+json[i].co_name+"</td>");
					$("#infoTable").append("<td>"+json[i].gr_num+"</td>");
					$("#infoTable").append("<td>"+json[i].gr_id+"</td>");
					if(Object.keys(json[i]).length==5){
						testTakercnt++
						$("#infoTable").append("<td>응시</td>");
					}else{
						nonTestTakercnt++
						$("#infoTable").append("<td>미응시</td>");
					}
					$("#infoTable").append("</tr>");
				}
				$("#text1").html(testTakercnt);
				$("#text2").html(nonTestTakercnt);	
				break;
			case 2:
				for(var i=0; i<json.length; i++){
					if(Object.keys(json[i]).length==5){
						testTakercnt++
						$("#infoTable").append("<tr>");
						$("#infoTable").append("<td>"+json[i].co_name+"</td>");
						$("#infoTable").append("<td>"+json[i].gr_num+"</td>");
						$("#infoTable").append("<td>"+json[i].gr_id+"</td>");
						$("#infoTable").append("<td>응시</td>");
					}
					$("#infoTable").append("</tr>");
				}
				$("#text1").html(testTakercnt);
				$("#text2").html(nonTestTakercnt);
				break;
			case 3:
				for(var i=0; i<json.length; i++){
					if(Object.keys(json[i]).length!=5){
						nonTestTakercnt++
						$("#infoTable").append("<tr>");
						$("#infoTable").append("<td>"+json[i].co_name+"</td>");
						$("#infoTable").append("<td>"+json[i].gr_num+"</td>");
						$("#infoTable").append("<td>"+json[i].gr_id+"</td>");
						$("#infoTable").append("<td>미응시</td>");
					}
					$("#infoTable").append("</tr>");
				}
				$("#text1").html(testTakercnt);
				$("#text2").html(nonTestTakercnt);
				break;
			default:
				alert("다시 클릭해주세요.");
				break;
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




