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
			<h2 style="float: left; margin-left: 10px;margin-top: 15px;">시험 및 퀴즈 정답률</h2>
			<button style="float: right; margin-right: 20px; margin-top: 30px; height: 30px;" 
					type="button" onclick="contSelect()">검색</button>
			<input style="float: right; height: 30px; margin-top: 30px;" type="text" name="cont"/> 
			<select style="float: right; height: 30px; margin-top: 30px;" name="box">
				<option value="0">전체검색</option>
				<option value="1">강의명</option>
				<option value="2">강좌명</option>
			</select>
			<select style="float: right; height: 30px; margin-top: 30px;" name="box1">
				<option value="T">시험</option>
				<option value="Q">퀴즈</option>
			</select>
		</div>
	</form>
		<br><br>
		<div>
			<button type="button" onclick="testAnswer()"
					style="border: none; width: 200px; height: 30px; font-size: 20px; background-color: blue; color: white;">
			시험 정답률</button>
			<button type="button" onclick="quizAnswer()"
					style="border: none; width: 200px; height: 30px; font-size: 20px; background-color: blue; color: white;">
			퀴즈 정답률</button>
		</div>
		
		<div style="height: 30px;"></div>
		
		<div>
			<p id="selectbox"></p><br>
			<table id="selectTable">
			</table>
		</div>
		
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>

<script>

function testAnswer() {
	
	$.ajax({
		type:'post',
		url:'rest/selectLectureTestAnswer',
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
			
			$("#selectbox").html("<h2>시험 정답률</h2>");
			
			$("#selectTable").html("");
			$("#selectTable").append("<tr>");
			$("#selectTable").append("<th style='text-align: center;'>강의명</th>");
			$("#selectTable").append("<th style='text-align: center;'>강좌명</th>");
			$("#selectTable").append("<th style='text-align: center;'>회차</th>");
			$("#selectTable").append("<th style='text-align: center;'>응시인원</th>");
			$("#selectTable").append("<th style='text-align: center;'>강사 아이디</th>");
			$("#selectTable").append("<th style='text-align: center;'>보러가기</th>");
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
				$("#selectTable").append("<td>"+json[i].gr_id1+"</td>");
				$("#selectTable").append("<td>"+json[i].cl_id+"</td>");
				$("#selectTable").append("<td><form action='golectureTestAnswerShowPage' method='post'>"+
						 				 "<input type='hidden' name='cl_clname' value="+cl_clname+">"+
						 				 "<input type='hidden' name='co_name' value="+co_name+">"+
						 				 "<input type='hidden' name='cl_id' value="+json[i].cl_id+">"+
						 				 "<input type='hidden' name='cl_idnum' value="+json[i].cl_idnum+">"+
						 				 "<input type='hidden' name='cl_lcnum' value="+json[i].co_num+">"+
						 				 "<input type='hidden' name='cl_lcnum' value="+json[i].gr_kind+">"+
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

function quizAnswer() {
	$.ajax({
		type:'post',
		url:'rest/selectLectureQuizAnswer',
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
			
			$("#selectbox").html("<h2>퀴즈 정답률</h2>");
			
			$("#selectTable").html("");
			$("#selectTable").append("<tr>");
			$("#selectTable").append("<th style='text-align: center;'>강의명</th>");
			$("#selectTable").append("<th style='text-align: center;'>강좌명</th>");
			$("#selectTable").append("<th style='text-align: center;'>회차</th>");
			$("#selectTable").append("<th style='text-align: center;'>응시인원</th>");
			$("#selectTable").append("<th style='text-align: center;'>강사 아이디</th>");
			$("#selectTable").append("<th style='text-align: center;'>보러가기</th>");
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
				$("#selectTable").append("<td>"+json[i].gr_id1+"</td>");
				$("#selectTable").append("<td>"+json[i].cl_id+"</td>");
				$("#selectTable").append("<td><form action='golectureTestAnswerShowPage' method='post'>"+
						 				 "<input type='hidden' name='cl_clname' value="+cl_clname+">"+
						 				 "<input type='hidden' name='co_name' value="+co_name+">"+
						 				 "<input type='hidden' name='cl_id' value="+json[i].cl_id+">"+
						 				 "<input type='hidden' name='cl_idnum' value="+json[i].cl_idnum+">"+
						 				 "<input type='hidden' name='cl_lcnum' value="+json[i].co_num+">"+
						 				 "<input type='hidden' name='cl_lcnum' value="+json[i].gr_kind+">"+
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


function contSelect() {
	
	 	$.ajax({
			type:'post',
			url:'rest/selectboxLectureTestAnswer',
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
				
				if(json.length==0){
					$("#selectbox").html("<h2>검색 결과가 없습니다.</h2>");
					$("#selectTable").html("");
					return
				}

				
				else if(json[0].gr_kind=='T'){
				
					$("#selectbox").html("<h2>시험 정답률</h2>");
					
					$("#selectTable").html("");
					$("#selectTable").append("<tr>");
					$("#selectTable").append("<th style='text-align: center;'>강의명</th>");
					$("#selectTable").append("<th style='text-align: center;'>강좌명</th>");
					$("#selectTable").append("<th style='text-align: center;'>회차</th>");
					$("#selectTable").append("<th style='text-align: center;'>응시인원</th>");
					$("#selectTable").append("<th style='text-align: center;'>강사 아이디</th>");
					$("#selectTable").append("<th style='text-align: center;'>보러가기</th>");
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
						$("#selectTable").append("<td>"+json[i].gr_id1+"</td>");
						$("#selectTable").append("<td>"+json[i].cl_id+"</td>");
						$("#selectTable").append("<td><form action='golectureTestAnswerShowPage' method='post'>"+
								 				 "<input type='hidden' name='cl_clname' value="+cl_clname+">"+
								 				 "<input type='hidden' name='co_name' value="+co_name+">"+
								 				 "<input type='hidden' name='cl_id' value="+json[i].cl_id+">"+
								 				 "<input type='hidden' name='cl_idnum' value="+json[i].cl_idnum+">"+
								 				 "<input type='hidden' name='cl_lcnum' value="+json[i].co_num+">"+
								 				 "<input type='hidden' name='cl_lcnum' value="+json[i].gr_kind+">"+
								 				 "<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
												 "<button>클릭</button><td></form>");
						$("#selectTable").append("</tr>");
						}
				}
				else{
					$("#selectbox").html("<h2>퀴즈 정답률</h2>");
					
					$("#selectTable").html("");
					$("#selectTable").append("<tr>");
					$("#selectTable").append("<th style='text-align: center;'>강의명</th>");
					$("#selectTable").append("<th style='text-align: center;'>강좌명</th>");
					$("#selectTable").append("<th style='text-align: center;'>회차</th>");
					$("#selectTable").append("<th style='text-align: center;'>응시인원</th>");
					$("#selectTable").append("<th style='text-align: center;'>강사 아이디</th>");
					$("#selectTable").append("<th style='text-align: center;'>보러가기</th>");
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
						$("#selectTable").append("<td>"+json[i].gr_id1+"</td>");
						$("#selectTable").append("<td>"+json[i].cl_id+"</td>");
						$("#selectTable").append("<td><form action='golectureTestAnswerShowPage' method='post'>"+
								 				 "<input type='hidden' name='cl_clname' value="+cl_clname+">"+
								 				 "<input type='hidden' name='co_name' value="+co_name+">"+
								 				 "<input type='hidden' name='cl_id' value="+json[i].cl_id+">"+
								 				 "<input type='hidden' name='cl_idnum' value="+json[i].cl_idnum+">"+
								 				 "<input type='hidden' name='cl_lcnum' value="+json[i].co_num+">"+
								 				 "<input type='hidden' name='cl_lcnum' value="+json[i].gr_kind+">"+
								 				 "<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
												 "<button>클릭</button><td></form>");
						$("#selectTable").append("</tr>");
					}
					
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




