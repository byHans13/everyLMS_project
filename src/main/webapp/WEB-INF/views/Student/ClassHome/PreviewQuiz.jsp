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

.head {
	text-align: center;
}
</style>
</head>
<body>
	<h2 class='head'>previewQuiz</h2>
	<div class='previewQuiz' name='previewQuiz' id='previewQuiz'>
		<div id='quizHead'></div>
		<div id='quizBody'></div>
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
		var QuizNum = 1;
		$('#quizNum').val(QuizNum);
		$('#quizHead').append(QuizNum + "번<br><br>");
		$('#quizHead').append(obj["Quiz" + QuizNum][0].pb_pbname + "<br>");
		for (var i = 0; i < obj["Quiz" + QuizNum].length; i++) {
			if (obj["Quiz" + QuizNum][i].dp_pbexmnum != 0) { // 객관식 				
				$('#quizBody').append("<input type='radio' id='QuizValMulti' name='QuizValMulti' value='"+obj["Quiz"+QuizNum][i].dp_pbexmnum+"'>"
										+ obj["Quiz" + QuizNum][i].dp_pbexm+ "<br>");
			} else {
				$('#quizBody').append("<textarea id='QuizValSubject' name='QuizValSubject' cols='50' rows='10'></textarea><br>");
			}
		}//for 
		$('#quizBody').append("<input type='button' value='정답확인하기' onclick='QuizCheck()'>");
	}// previewQuizStart() END
	
	function QuizCheck(){
		var i = $('#quizNum').val(); // 저장되어있던 현재 문제 진행 번호 max=5
		var obj = ${previewQuiz}; // GSON으로 보내준 값;
		var myNum = $("input:radio[id=QuizValMulti]:checked").val(); // 객관식 답;
		var mySubject = $('#QuizValSubject').val(); // 주관식 답 
		if($('input:radio[id=QuizValMulti]').is(':checked') == true){
			$('#quizHead').html("");
			$('#quizBody').html("");
			$('#quizHead').append("<p>나의 답: "+myNum+"</p>");
			$('#quizHead').append("<p>문제 답: "+obj["Quiz"+i][0].pb_pbexplain+"</p><br/><p>해설:<br/>");
			$('#quizHead').append(obj["Quiz"+i][0].pb_pbanswer+"</p><br/>");
			if(i == 5){
				$('#quizHead').append("<div>준비된 맛보기 퀴즈를 다 푸셨습니다.</div>");
			}else{
				$('#quizHead').append("<input type='button' value='다음 문제 풀기' onclick='previewQuizNext()'>");
			}
		}else if($('#QuizValSubject').val() != "" && $('#QuizValSubject').val() != undefined){
			$('#quizHead').html("");
			$('#quizBody').html("");
			$('#quizHead').append("<p>나의 답: "+mySubject+"</p>");
			$('#quizHead').append("<p>문제 답: "+obj["Quiz"+i][0].pb_pbexplain+"</p><br/><p>해설:<br/>");
			$('#quizHead').append(obj["Quiz"+i][0].pb_pbanswer+"</p><br/>");
			if(i == 5){
				$('#quizHead').append("<div>준비된 맛보기 퀴즈를 다 푸셨습니다.</div>");
			}else{
				$('#quizHead').append("<input type='button' value='다음 문제 풀기' onclick='previewQuizNext()'>");
			}
		}else{
			alert("정답을 입력하고 넘어가주세요.");			
		}
	}//QuizCheck END 

	function previewQuizNext(){
		var obj = ${previewQuiz};
		var QuizNum = parseInt($('#quizNum').val()) + 1;
		$('#quizNum').val(QuizNum); 
		$('#quizHead').html("");
		$('#quizBody').html("");
		$('#quizHead').append(QuizNum + "번<br><br>");
		$('#quizHead').append(obj["Quiz" + QuizNum][0].pb_pbname + "<br>");
		for (var i = 0; i < obj["Quiz" + QuizNum].length; i++) {
			if (obj["Quiz" + QuizNum][i].dp_pbexmnum != 0) { // 객관식 				
				$('#quizBody').append("<input type='radio' id='QuizValMulti' name='QuizValMulti' value='"+obj["Quiz"+QuizNum][i].dp_pbexmnum+"'>"
										+ obj["Quiz" + QuizNum][i].dp_pbexm+ "<br>");
			} else {
				$('#quizBody').append("<textarea id='QuizValSubject' name='QuizValSubject' cols='50' rows='10'></textarea><br>");
			}
		}//for 
		$('#quizBody').append("<input type='button' value='정답확인하기' onclick='QuizCheck()'>");
		
	}//previewQuizNext() END
</script>
</html>