<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../resources/js/jquery.serializeObject.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>

<style>
.finalTest {
	width: 600px;
	height: 500px;
	border: 1px solid black;
	margin: auto;
	margin-top: 25px;
	overflow: auto;
}

.head {
	text-align: center;
	margin:auto;
	width:500px;
	height:200px;
}
</style>
<body>
	<h2 class='head' id='secondTitle'></h2>
	<div class='finalTest' name='finalTest' id='finalTest'>
		<div id='ftHead'></div>
		<div id='ftBody' style='float:left'></div>
	</div>
	<input type='hidden' id='token' data-token-name='${_csrf.headerName}'
		name='${_csrf.parameterName}' value='${_csrf.token}'>
</body>
<script>
	var ft = ${finalTest};
	console.log(ft);
	quizStart();
	function quizStart() {
		var head = $('#ftHead');
		head.html("");
		$('#ftBody').html("");
		$('#secondTitle').html("final Test");
		head.append("<div id='headDiv'></div>");
		head.append("<input type='hidden' id='pbnum' name='pb_pbnum' value=''>");
		$('#headDiv').append("<input type='hidden' id='pbnum' name='pb_pbnum' value=''>");
		$('#headDiv').append("<table><tr><td>남은시간: </td><td id='timer'></td></tr></table>");
		$('#headDiv').append("<input type='button' value='제출하기' onclick='lastTestInsert(1)'>");
		
		for (var i = 0; i < ft.length; i++) {
			var str = "";
			str += "<div id='quizDiv"+ ft[i].pb_pbnum
					+ "' style='text-align:center; padding:10px; width:20px; height:20px; margin:15px;";
			str += "float:left; border:1px solid black;' onclick=\"insertTest("
					+ ft[i].pb_pbnum + ")\">" + ft[i].pb_pbnum + "</div>";

			head.append(str);
		}//for i
		selectTest(ft[0].pb_pbnum);
		testTimer();
	}//function quizStart() END
	
	function testTimer(){
		var time=600;
		var min="";
		var sec="";
		var setInter = setInterval(function(){
			min = parseInt(time/60);
			sec = time%60;
			$('#timer').html(min+":"+sec);
			time--;
			if(time <0){
				clearInterval(setInter);
				lastTestInsert(0);
			}
		}, 1000);
	};//QuizTimer() END
	function selectTest(pbnum){		
		console.log(pbnum);
		console.log(ft[0].pb_idnum);
		var obj = {
			"pb_idnum":ft[0].pb_idnum,
			"pb_lv":ft[0].pb_lv,
			"pb_num":ft[0].pb_num,
			"pb_pbnum":pbnum
		}; 
		$('#pbnum').val(pbnum);
		$.ajax({
			type:'post',
			url:'rest/selectCourseQuizWithPbnum',
			data:obj,
			dataType:'json',
			beforeSend : function(xhr){
    			var $token = $("#token");
    			xhr.setRequestHeader($token.data("token-name"), $token.val());
    		},success: function(json){
    			if(json.length != 0){
	    			console.log(json);
	    			var body = $('#ftBody');
	    			body.html("");
	    			body.append("<br/><br/>");
	    			body.append(pbnum+"번) "+json[0].pb_pbname + "<br/>");
	    			for(var i in json){
	    				if(json[i].pb_id =='${id}'){
	    					var str="";
		    				if (json[i].dp_pbexmnum != 0) { // 객관식
		    					if(json[i].dp_pbexmnum != json[i].pb_pbstudent){
		    						str +="<input type='radio' id='MultiQuiz' name='MultiQuiz' value='"+json[i].dp_pbexmnum+"'>";
		    						str += json[i].dp_pbexm+"<br/>";	
		    					}else{
		    						str +="<input type='radio' id='MultiQuiz' name='MultiQuiz' value='"+json[i].dp_pbexmnum+"' checked>";
			    					str += json[i].dp_pbexm+"<br/>";
		    					}
		    				} else {//주관식
		    					str +="<textarea id='SubjectQuiz' name='SubjectQuiz' cols='50' rows='10'>"+json[i].pb_pbstudent+"</textarea><br/>";
		    				}
			    			body.append(str);
	    				}else{
							var str="";
		    				if (json[i].dp_pbexmnum != 0) { // 객관식 				
		    					str +="<input type='radio' id='MultiQuiz' name='MultiQuiz' value='"+json[i].dp_pbexmnum+"'>";
		    					str += json[i].dp_pbexm+"<br/>";
		    				} else {//주관식
		    					str +="<textarea id='SubjectQuiz' name='SubjectQuiz' cols='50' rows='10'></textarea><br/>";
		    				}
			    			body.append(str);
		    			}
	    				    					
	    			}
		   	 			body.append("<input type='button' value='다음문제풀기' onclick=\"insertTest("+(pbnum+1)+")\"><br/>");

    			}else{
    				alert("문제를 출력하지 못했습니다. 승호형에게 문의해주세요.");
    				window.close();
    			}
    		},error: function(err){
    			console.log(err);
    		}
		});//ajax END
	}//function selectQuiz() END

	function insertTest(pbNum){
		var prevNum = $('#pbnum').val();
		var testLength = ft.length;
		if(pbNum > testLength){
			var nextNum = 1;
		}else{
			var nextNum = pbNum;		
		}
		var multiBoolean =$('input:radio[id=MultiQuiz]').is(':checked');//checked확인
		var multiAnswer = $("input:radio[id=MultiQuiz]:checked").val(); // 객관식 답;
		var subjectAnswer = $('#SubjectQuiz').val(); // 주관식 답 
		
		if(multiBoolean == true || subjectAnswer != undefined && subjectAnswer != ""){
			if(multiBoolean == true){
				var obj={
					"pb_idnum":ft[0].pb_idnum,
					"pb_lv":ft[0].pb_lv,
					"pb_num":ft[0].pb_num,
				 	"pb_pbnum":prevNum,
				 	"pb_pbstudent":multiAnswer
				}
			}else{				
				var obj={
					"pb_idnum":ft[0].pb_idnum,
					"pb_lv":ft[0].pb_lv,
					"pb_num":ft[0].pb_num,
				 	"pb_pbnum":prevNum,
				 	"pb_pbstudent":subjectAnswer
				}
		  	}
				$.ajax({
					type:'post',
					url:'rest/insertCourseQuiz',
					data:obj,
					dataType:'json',
					beforeSend : function(xhr){
	    				var $token = $("#token");
	    				xhr.setRequestHeader($token.data("token-name"), $token.val());
	    			},
	    			success: function(json){
	    				$('#quizDiv'+json).css('background-color','red');
	    				selectTest(nextNum);
	    			},error: function(err){
	    				selectTest(nextNum);	
	    			}
				});
			
		}else{
			selectTest(nextNum);
		}
	}// function insertTest() END 
	
	function lastTestInsert(chk){
		var check = chk;
		if(check == 1){
			if(confirm("확인을 누르면 최종 제출됩니다. 제출하시겠습니까?")){
			}else{
				return;
			}		
		}
		var lastNum = $('#pbnum').val(); 
		var multiBoolean =$('input:radio[id=MultiQuiz]').is(':checked');//checked확인
		var multiAnswer = $("input:radio[id=MultiQuiz]:checked").val(); // 객관식 답;
		var subjectAnswer = $('#SubjectQuiz').val(); // 주관식 답 
		if(multiBoolean == true || subjectAnswer != undefined && subjectAnswer != ""){
			if(multiBoolean == true){
				var obj={
					"pb_idnum":ft[0].pb_idnum,
					"pb_lv":ft[0].pb_lv,
					"pb_num":ft[0].pb_num,
				 	"pb_pbnum":lastNum,
				 	"pb_pbstudent":multiAnswer};
			}else{				
				var obj={
					"pb_idnum":ft[0].pb_idnum,
					"pb_lv":ft[0].pb_lv,
					"pb_num":ft[0].pb_num,
				 	"pb_pbnum":lastNum,
				 	"pb_pbstudent":subjectAnswer};
			}
		}else{
			var obj={
					"pb_idnum":ft[0].pb_idnum,
					"pb_lv":ft[0].pb_lv,
					"pb_num":ft[0].pb_num,
				 	"pb_pbnum":lastNum};
		}
		console.log(obj);
		$.ajax({
			type:'post',
			url:'rest/lastQuizInsert',
			data:obj,
			dataType:'json',
			beforeSend : function(xhr){
    			var $token = $("#token");
    			xhr.setRequestHeader($token.data("token-name"), $token.val());
    		},success: function(json){
    			console.log(json);
				if(json!=0){
					if(check==1){						
						alert("제출이 완료되었습니다. 페이지를 종료하겠습니다.");
						window.close();
					}else{
						alert("제한시간이 끝났습니다. 페이지를 종료하겠습니다.");
						window.close();
					}
				}else{
					alert("error : 시험 내역을 확인 후 이상이 있으시면 문의해주세요.");
					window.close();
				}    			
    		},error: function(err){
    			console.log(err);
    		}
		});//ajax END
	}; //function lastTestInsert() END

</script>

</html>