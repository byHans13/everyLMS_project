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
		<%-- <%@ include file="h2k5every_header.jsp"%><!-- 정적인 방식 --> --%>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
	
	<form id="frm">	
		<div style="background-color: #B7F0B1; height: 80px; ">
			<h2 style="float: left; margin-left: 10px;margin-top: 15px;">시험 응시 or 미응시 관리</h2>
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
	$.ajax({
		type:'post',
		url:'rest/selectIsTestTaker',
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
			console.log(json[0].cl_clname);
			
			$("#selectTable").append("<tr>");
			$("#selectTable").append("<th style='text-align: center;'>강의명</th>");
			$("#selectTable").append("<th style='text-align: center;'>강좌명</th>");
			$("#selectTable").append("<th style='text-align: center;'>회차</th>");
			$("#selectTable").append("<th style='text-align: center;'>강사 아이디</th>");
			$("#selectTable").append("<th style='text-align: center;'>응시확인</th>");
			$("#selectTable").append("</tr>");
			
			for(var i=0; i<json.length; i++){
				
				var cl_clname = json[i].cl_clname.replace(/ /gi,',');
				var co_name = json[i].co_name.replace(/ /gi,',');
				console.log(cl_clname);
				console.log(co_name);
				
				$("#selectTable").append("<tr>");
				$("#selectTable").append("<td>"+json[i].cl_clname+"</td>");
				$("#selectTable").append("<td>"+json[i].co_name+"</td>");
				$("#selectTable").append("<td>"+json[i].co_num+"</td>");
				$("#selectTable").append("<td>"+json[i].cl_id+"</td>");
				$("#selectTable").append("<td><form action='goisTestTakerShowPage' method='post'>"+
						 				 "<input type='hidden' name='cl_clname' value="+cl_clname+">"+
						 				 "<input type='hidden' name='co_name' value="+co_name+">"+
						 				 "<input type='hidden' name='cl_lcnum' value="+json[i].co_num+">"+
						 				 "<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
										 "<button>클릭</button><td></form>");
				$("#selectTable").append("</tr>");
							
			}
			
		},
		error: function (err) {
			console.log(err);
		}
	});


});

function contSelect() {
	
	 $("#selectTable").html("");
	 	$.ajax({
			type:'post',
			url:'rest/selectboxIsTestTaker',
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
				
				$("#selectTable").append("<tr>");
				$("#selectTable").append("<th style='text-align: center;'>강의명</th>");
				$("#selectTable").append("<th style='text-align: center;'>강좌명</th>");
				$("#selectTable").append("<th style='text-align: center;'>회차</th>");
				$("#selectTable").append("<th style='text-align: center;'>강사 아이디</th>");
				$("#selectTable").append("<th style='text-align: center;'>응시확인</th>");
				$("#selectTable").append("</tr>");
				
				for(var i=0; i<json.length; i++){
					
					var cl_clname = json[i].cl_clname.replace(/ /gi,',');
					var co_name = json[i].co_name.replace(/ /gi,',');
					console.log(cl_clname);
					console.log(co_name);
					
					$("#selectTable").append("<tr>");
					$("#selectTable").append("<td>"+json[i].cl_clname+"</td>");
					$("#selectTable").append("<td>"+json[i].co_name+"</td>");
					$("#selectTable").append("<td>"+json[i].co_num+"</td>");
					$("#selectTable").append("<td>"+json[i].cl_id+"</td>");
					$("#selectTable").append("<td><form action='goisTestTakerShowPage' method='post'>"+
											 "<input type='hidden' name='cl_clname' value="+cl_clname+">"+
											 "<input type='hidden' name='co_name' value="+co_name+">"+
											 "<input type='hidden' name='cl_lcnum' value="+json[i].co_num+">"+
											 "<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
											 "<button>클릭</button><td></form>");
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