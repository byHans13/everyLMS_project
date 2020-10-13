<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
	width: 1000px;
	float: left;
}
</style>
</head>
<body>
	<script>
		$(document).ready(function() {
			//var aut =JSON.parse("${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}");
			var aut = "${aut}";
			var n = aut.indexOf("ROLE_PROF");
			var id = "${id}";
			if (n == 1) {
				$("#goTeacherPage").append("<p style='margin-top: auto;'><b><a href='/h2k5every/prof/goTeacherLoginFrm' style='color: white; '>강사페이지이동</a></b></p>");
			}
			testtest(id);
			});
	</script>
	<header>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_aside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
		<input type='hidden' id='token' data-token-name='${_csrf.headerName}' 
		name = '${_csrf.parameterName}' value='${_csrf.token}' >
		<div id='showQuiz' style='margin:auto; border:1px solid black; width:600px; height:500px; overflow:auto;'>
		</div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>					
</body>
<script>
var concern = ${concern};
var currentCC="";
let QuizList=[];
var problemLv = 1;
var x=0;
function testtest(id) {
	$.ajax({
		type:'get',
		url:'rest/selectConcern',
		datatype:'json',
		beforeSend : function(xhr){
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
		success: function (json) {
			for(var i=0; i<json.length; i++){
				$('#menu').append("<div class='menu'><p>"+json[i]+"</p></div>");
			}
			startSelectQuiz();
		},
		error: function (err) {
			alert("eeeeee");
		}
	});//ajax
}; //functiont testtest END

function startSelectQuiz(){
	var showQuiz = $('#showQuiz');
	var str="";
	showQuiz.append("<h4>LevelCheck</h4>");
	str += "<select id='cc' onchange='concernChange()'><option value=''>관심사를 선택해주세요.</option>";
	for(var i in concern){
		str += "<option value='"+concern[i].cc_cc+"'>"+concern[i].cc_cc+"</option>";
	}
	str += "</select>";
	showQuiz.append(str);
};//function startSelectQuiz() END

function concernChange(){
	var showQuiz = $('#showQuiz');
	var ccValue = $('#cc').val();
	if(ccValue !=""){
		$('#btn').html("");
		var str="";
		str +="<div id='btn'><input type='button' value='"+ccValue+" 문제 풀기' onclick='selectLevelCheckQuiz()'></div>";
		showQuiz.append(str);
		currentCC = ccValue;
	}else{
		$('#btn').html("");

	}
};// function concernChange() END

function selectLevelCheckQuiz(){
	var showQuiz = $('#showQuiz');
	var str = ""; 
	console.log("problemLV="+problemLv);
	console.log("currentCC="+currentCC);
	var obj = {"pb_lv":problemLv, "cl_cc":currentCC };
	$.ajax({
		type:'get',
		url:'rest/selectLevelCheckQuiz',
		data:obj,
		dataType:'json',
		success: function(json){
			console.log(json);
			var checkQuizStyle="";
			var problemListObj ={};
			if(Object.keys(json).length !=0){
				showQuiz.html("");
				showQuiz.append("<h4>LevelCheck</h4><br/>");
				for(var i=0; i<Object.keys(json).length; i++){
					var problemList = {};
					str += "<div>"+(i+1)+". "+json["Quiz"+i][i].pb_pbname+"</div><br/>";
					for(var j=0; j<json["Quiz"+i].length; j++){
						if(json["Quiz"+i][i].dp_pbexmnum != 0){
							checkQuizStyle="m";
							str +="<input type='radio' id='levelCheckMulti"+i+"'name='levelCheckMulti"+i+"' value='"+json["Quiz"+i][j].dp_pbexmnum+"'>"+json["Quiz"+i][j].dp_pbexm+"<br/>";
						}else{
							checkQuizStyle="s";
							str +="<textarea id='levelCheckSubject"+i+"' cols='50' rows='10'></textarea><br/>";
						}	
						 var detailObj= {
								"pb_pbnum":(i+1),
								"pb_pbname":json["Quiz"+i][j].pb_pbname,
								"pb_pbanswer":json["Quiz"+i][j].pb_pbanswer,
								"pb_pbexplain":json["Quiz"+i][j].pb_pbexplain,
								"dp_pbexmnum":json["Quiz"+i][j].dp_pbexmnum,
								"dp_pbexm":json["Quiz"+i][j].dp_pbexm,
								"checkQuizStyle":checkQuizStyle
						}
						 problemList[j]=detailObj;
					}//for j
					problemListObj["Quiz"+i]=problemList;
					//console.log(problemList);
					//console.log(problemList[0]);
					str += "<hr/>";
				}//for i
				//console.log(problemListObj);
				//console.log(problemListObj["Quiz0"]);
				str +="<input type='button' value='다음 문제 풀기' onclick='checkQuizAnswer()'>";
				showQuiz.append(str);
				QuizList[x]=problemListObj;
			}else{
				alert("문제를 불러오지 못했습니다.");
				LevelChkQuizQuizEnd();
			}
		},error: function(err){
			console.log(err);
		}
	});//ajax END
}// function selectLevelCheckQuiz END

function checkQuizAnswer(){
	var cnt=0;
	for(var i=0; i<Object.keys(QuizList[x]).length; i++){
		if(QuizList[x]["Quiz"+i][0].checkQuizStyle==="m"){
			var result = $("input:radio[id=levelCheckMulti"+i+"]").is(":checked");
			if(result==false){
				alert("모든 문제를 풀고 넘어가주세요.");
				return;
			}
		}else{
			if($('#levelCheckSubject'+i)!=undefined && $('#levelCheckSubject'+i)!= ""){
				alert("모드 문제를 풀고 넘어가주세요.");
				return;
			}
		}
	}//for
	for(var j=0; j<Object.keys(QuizList[x]).length; j++){
		if(QuizList[x]["Quiz"+j][0].checkQuizStyle==="m"){
			var answer = $("input:radio[id=levelCheckMulti"+j+"]:checked").val();
			for(var t=0; t<Object.keys(QuizList[x]["Quiz"+j]).length; t++){
				QuizList[x]["Quiz"+j][t].pb_studans = answer;
			}
			if(answer == QuizList[x]["Quiz"+j][0].pb_pbexplain){
				cnt=cnt+1;
			}	
		}else{
			var answer = $("#levelCheckSubject"+j).val();
			for(var t=0; t<Object.keys(QuizList[x]["Quiz"+j]).length; t++){
				QuizList[x]["Quiz"+j][t].pb_studans = answer;
			}
			if(answer == QuizList[x]["Quiz"+j][0].pb_pbexplain){
				cnt=cnt+1;
			}
		}
	}
	if(cnt>1){
		problemLv = problemLv+1;
		x = x+1;
		console.log("x="+x);
		selectLevelCheckQuiz();
	}else{
		LevelChkQuizQuizEnd();
	}
}; // function checkQuizANswer END

function LevelChkQuizQuizEnd(){
	var showQuiz=$('#showQuiz');
	var str ="";
	var quiz=1;
	showQuiz.html("");
	showQuiz.append("<h4>오답풀이</h4><br/>");
	showQuiz.append("<p>관심사: "+currentCC+"</p>");
	showQuiz.append("<p>수준: "+problemLv+"</p>"); 
	showQuiz.append("<p><b>levelCheck는 참고용입니다. 과목의 오리엔테이션을 꼭 보고 수강해주세요.</b></p><br/>");
	for(var i=0; i<Object.keys(QuizList).length; i++){// lv 올라간 개수 
		for(var j=0; j<Object.keys(QuizList[i]).length; j++){// lv에서 문제 개수
			if(QuizList[i]["Quiz"+j][0].pb_studans == QuizList[i]["Quiz"+j][0].pb_pbexplain){
				str += "<div style='color:blue;'><b>"+(quiz++)+". "+QuizList[i]["Quiz"+j][0].pb_pbname+"</b></div><br/>";			
			}else{
				str += "<div style='color:red;'><b>"+(quiz++)+". "+QuizList[i]["Quiz"+j][0].pb_pbname+"</b></div><br/>";							
			}
			for(var n=0; n<Object.keys(QuizList[i]["Quiz"+j]).length; n++){//문제의 행 개수 
				if(QuizList[i]["Quiz"+j][j].dp_pbexmnum !=0){
					if((n+1) == QuizList[i]["Quiz"+j][n].pb_pbexplain){
						str +="<p style='color:blue;'>("+QuizList[i]["Quiz"+j][n].dp_pbexmnum+") "+QuizList[i]["Quiz"+j][n].dp_pbexm+"</p>";				
					}else if((n+1) == QuizList[i]["Quiz"+j][n].pb_studans){
						str +="<p style='color:red;'>("+QuizList[i]["Quiz"+j][n].dp_pbexmnum+") "+QuizList[i]["Quiz"+j][n].dp_pbexm+"</p>";					
					}else{
						str +="<p>("+QuizList[i]["Quiz"+j][n].dp_pbexmnum+") "+QuizList[i]["Quiz"+j][n].dp_pbexm+"</p>";					
					}					
				}else{
					str +="<br/><p>나의 답: "+QuizList[i]["Quiz"+j][n].pb_studans+"</p>";
				}
			}//for n
			str +="<p><b>해설</b></p>";
			str +="<p>나의 답: "+QuizList[i]["Quiz"+j][j].pb_studans+"</p>";
			str +="<p>문제 답: "+QuizList[i]["Quiz"+j][j].pb_pbexplain+"</p><br/>";
			str +="<p>"+QuizList[i]["Quiz"+j][0].pb_pbanswer+"</p>";
			str += "<hr/>";
		}// for j
	}// for i
	showQuiz.append(str);
	alert("회원님의 관심사:"+currentCC+"의 LV은 "+problemLv+" 입니다.");
}// function LectureQuizEnd() END
</script>
</html>