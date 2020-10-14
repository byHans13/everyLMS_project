<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>class-previewQuiz</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="../resources/js/jquery.serializeObject.js"></script>
  	<script src="../resources/js/jquery.serializeObject.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- LaTest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<style>
.previewQuiz {
	width: 600px;
	height: 500px;
	border: 1px solid black;
	margin: auto;
	margin-top: 25px;

}
#quizBody, #quizHead{
	padding-left: 2%;
	
}
#quizHead{
padding-top:4%;
width:101%;
font-weight: bold;
position: relative;
}
#quizBody{ 
 position: relative;
/*  margin-left: 10%; */
 } 

.head {
	text-align: center;
	
}

</style>
</head>
<body>
	<h2 class='head'>previewQuiz</h2>
	<div class='previewQuiz' name='previewQuiz' id='previewQuiz'>
		<div id='quizHead' class='container'></div>
		<div id='quizBody' class='container'></div>
	</div>
	<input type='hidden' value='' id='quizNum'>
	<input type='hidden' id='token' data-token-name='${_csrf.headerName}' 
						name = '${_csrf.parameterName}' value='${_csrf.token}' >
	<form name='randomNum' id='randomNum'></form>
</body>
<script>
	previewQuizStart();
	function previewQuizStart() {
		var obj = ${previewQuiz};
		console.log(obj);
		console.log(Object.keys(obj).length);
		var QuizNum = 1;
		var str="";
		$('#quizNum').val(QuizNum);
 		str+="<table class='table'>";
		str+="<tr style='width:50%;'><td style='background-color:gray;'>"+QuizNum+"번. "+obj["Quiz" + QuizNum][0].pb_pbname+"</td></tr>";
		for (var i = 0; i < obj["Quiz" + QuizNum].length; i++) {
			if (obj["Quiz" + QuizNum][i].dp_pbexmnum != 0) { // 객관식 				
				str+="<tr><td><input type='radio' style='border-radius: 8px;' id='QuizValMulti' name='QuizValMulti' value='"+obj["Quiz"+QuizNum][i].dp_pbexmnum+"'>&nbsp;";
				str+=obj["Quiz"+ QuizNum][i].dp_pbexm+"</td></tr>";
			} else {
				str+="<tr><td><textarea id='QuizValSubject' name='QuizValSubject' cols='50' rows='10'></textarea></td></tr>";
			}
		}//for 
		$('#quizHead').append(str);
		$('#quizBody').append("<br><input type='button' value='정답확인하기' class='btn btn-primary btn-sm' onclick='QuizCheck()'>");
	}// previewQuizStart() END
	
	function QuizCheck(){
		var i = $('#quizNum').val(); // 저장되어있던 현재 문제 진행 번호 max=5
		var obj = ${previewQuiz}; // GSON으로 보내준 값;
		console.log(Object.keys(obj));
		var myNum = $("input:radio[id=QuizValMulti]:checked").val(); // 객관식 답;
		var mySubject = $('#QuizValSubject').val(); // 주관식 답 
		if($('input:radio[id=QuizValMulti]').is(':checked') == true){
			$('#quizHead').html("");
			$('#quizBody').html("");
			var str="";
			str +="<table class='table'>";
			str +="<tr style='background-color:gray;'><td>나의 답:&nbsp;"+myNum+"</td>";
			str +="<tr style='background-color: lightgray;'><td>문제 답:&nbsp;"+obj["Quiz"+i][0].pb_pbexplain+"</td>";
			str +="<tr style='background-color: lightgray;'><td colspan='2'>해설<br><br>:&nbsp;";
			str +=obj["Quiz"+i][0].pb_pbanswer+"</td></tr>";
			$('#quizHead').append(str);
			if(i == 5){
				$('#quizHead').append("<div style='color:black; font-weight: normal;'>준비된 맛보기 퀴즈를 다 푸셨습니다.</div>");
			}else{
					$('#quizHead').append("<input type='button' value='다음 문제 풀기' class='btn btn-primary btn-sm' onclick='previewQuizNext()'>");						
			}
			
		}else if($('#QuizValSubject').val() != "" && $('#QuizValSubject').val() != undefined){
			$('#quizHead').html("");
			$('#quizBody').html("");
			$('#quizHead').append("<p style='color: red;'>나의 답: "+mySubject+"</p>");
			$('#quizHead').append("<p>문제 답: "+obj["Quiz"+i][0].pb_pbexplain+"</p><br/><p>해설:<br/>");
			$('#quizHead').append(obj["Quiz"+i][0].pb_pbanswer+"</p><br/>");
			if(i == 5){
				$('#quizHead').append("<div>준비된 맛보기 퀴즈를 다 푸셨습니다.</div>");
			}else{
					$('#quizHead').append("<input type='button' value='다음 문제 풀기' class='btn btn-primary btn-sm' onclick='previewQuizNext()'>");
			}
		}else{
			alert("정답을 입력하고 넘어가주세요.");			
		}
	}//QuizCheck END 

	function previewQuizNext(){
		var obj = ${previewQuiz};
		var QuizNum = parseInt($('#quizNum').val()) + 1;
		console.log(QuizNum);
		console.log(obj);
		var str="";
		$('#quizNum').val(QuizNum); 
		$('#quizHead').html("");
		$('#quizBody').html("");
		str+="<table>";
		str+="<tr><td>"+QuizNum+"번 "+obj["Quiz" + QuizNum][0].pb_pbname+"</td></tr>";
		for (var i = 0; i < obj["Quiz" + QuizNum].length; i++) {
			if (obj["Quiz" + QuizNum][i].dp_pbexmnum != 0) { // 객관식 				
				str+="<tr><td><input type='radio' id='QuizValMulti' name='QuizValMulti' value='"+obj["Quiz"+QuizNum][i].dp_pbexmnum+"'></td>";
				str+="<td>"+ obj["Quiz" + QuizNum][i].dp_pbexm+"</td></tr>";
			} else {
				str+="<tr><td><textarea id='QuizValSubject' name='QuizValSubject' cols='50' rows='10'></textarea></td></tr>";
			}
		}//for 
		$('#quizHead').append(str);
		$('#quizBody').append("<input type='button' value='정답확인하기' onclick='QuizCheck()'>");
		
	}//previewQuizNext() END
</script>
</html>