<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CourseQuiz</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../resources/js/jquery.serializeObject.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<style>
.courseQuiz {
	width: 600px;
	height: 500px;
	border: 1px solid black;
	margin: auto;
	margin-top: 25px;
	overflow:auto;
}

.head {
	text-align: center;
}
</style>
</head>
<body>
	<h2 class='head' id='secondTitle'></h2>
	<div class='courseQuiz' name='courseQuiz' id='courseQuiz'>
		<div id='courseHead'></div>
		<div id='courseBody'></div>
	</div>
	<input type='hidden' id='token' data-token-name='${_csrf.headerName}'
		name='${_csrf.parameterName}' value='${_csrf.token}'>
	<form name='#' id='#'></form>
</body>
<script>
	var ef = ${evaluation};	
	var ak = ${answerKind};
	var quizLength =0;
	evaluationCntChk();
	function evaluationCntChk(){
		window.opener.close();
		var obj ={
			"ef_idnum":ef["evaluation"+0][0].ef_idnum,
			"ef_lv":ef["evaluation"+0][0].ef_lv,
			"ef_num":ef["evaluation"+0][0].ef_num
		}
		$.ajax({
			type:'post',
			url:'rest/selectEvaluationCntChkAjax',
			data:obj,
			dataType:'json',
			beforeSend : function(xhr){
    			var $token = $("#token");
    			xhr.setRequestHeader($token.data("token-name"), $token.val());
    		},
			success: function(json){
				console.log(json);
				quizLength = json;
				if(json!=0){
					quizStart();
				}else{
					evaluationStart();
				}
			},error: function(err){
				evaluationStart();
			}
		});//ajax END
	}// function evaluationCntChkEnd
	
	function quizStart(){
		$('#courseHead').html("");
		$('#courseBody').html("");
		$('#secondTitle').html(ef["evaluation"+0][0].ef_num+"강 퀴즈");
		var obj = {
			"pb_idnum":ef["evaluation"+0][0].ef_idnum,
			"pb_lv":ef["evaluation"+0][0].ef_lv,
			"pb_num":ef["evaluation"+0][0].ef_num
			}
		$.ajax({
			type:'post',
			url:'rest/selectCoursePbnumAjax',
			data:obj,
			dataType:'json',
			beforeSend : function(xhr){
    			var $token = $("#token");
    			xhr.setRequestHeader($token.data("token-name"), $token.val());
    		},
			success: function(json){
				var head = $('#courseHead');
				for(var i=0; i<json.length; i++){
					var str="";
					str +="<div id='quizDiv"+json[i].pb_pbnum+"' style='text-align:center; padding:10px; width:20px; height:20px; margin:15px;";
					str +="float:left; border:1px solid black;' onclick=\"insertQuiz("+json[i].pb_pbnum+")\">"+json[i].pb_pbnum+"</div>";
					
					head.append(str);
				}
				head.append("<input type='hidden' id='pbnum' name='pb_pbnum' value=''>");
				head.append("<table><tr><td>남은시간</td></tr><tr><td id='timer'></td></tr></table>");
				head.append("<input type='button' value='제출하기' onclick='lastQuizInsert(1)'>");
				selectQuiz(json[0].pb_pbnum);
				QuizTimer();
			},error: function(err){
				console.log(err);
				alert("유감");
			}
		});
		
	}//function quizStart() END
	function QuizTimer(){
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
				lastQuizInsert(0);
			}
		}, 1000);
	};//QuizTimer() END 
	
	function lastQuizInsert(chk){
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
					"pb_idnum":ef["evaluation"+0][0].ef_idnum,
					"pb_lv":ef["evaluation"+0][0].ef_lv,
					"pb_num":ef["evaluation"+0][0].ef_num,
				 	"pb_pbnum":lastNum,
				 	"pb_pbstudent":multiAnswer};
			}else{				
				var obj={
					"pb_idnum":ef["evaluation"+0][0].ef_idnum,
					"pb_lv":ef["evaluation"+0][0].ef_lv,
					"pb_num":ef["evaluation"+0][0].ef_num,
				 	"pb_pbnum":lastNum,
				 	"pb_pbstudent":subjectAnswer};
			}
		}else{
			var obj={
					"pb_idnum":ef["evaluation"+0][0].ef_idnum,
					"pb_lv":ef["evaluation"+0][0].ef_lv,
					"pb_num":ef["evaluation"+0][0].ef_num,
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
					alert("error : 퀴즈 내역을 확인 후 이상이 있으시면 문의해주세요.");
					window.close();
				}    			
    		},error: function(err){
    			console.log(err);
    		}
		});//ajax END
	}; //function lastQuizInsert() END
	function selectQuiz(pbnum){		
		var obj = {
			"pb_idnum":ef["evaluation"+0][0].ef_idnum,
			"pb_lv":ef["evaluation"+0][0].ef_lv,
			"pb_num":ef["evaluation"+0][0].ef_num,
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
    			var body = $('#courseBody');
    			body.html("");
    			body.append("<br/><br/>");
    			body.append(pbnum+"번) "+json[0].pb_pbname + "<br/>");
    			for(var i in json){
    				if(json[i].pb_id =='${id}'){
    					var str="";
	    				if (json[i].dp_pbexmnum != 0) { // 객관식
	    					console.log(json[i].dp_pbexmnum);
	    					console.log(json[i].pb_pbstudent);
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
	   	 			body.append("<input type='button' value='다음문제풀기' onclick=\"insertQuiz("+(pbnum+1)+")\"><br/>");

    		},error: function(err){
    			console.log(err);
    		}
		});//ajax END
	}//function selectQuiz() END
	
	function insertQuiz(pbNum){
		var prevNum = $('#pbnum').val();
		if(pbNum > quizLength){
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
					"pb_idnum":ef["evaluation"+0][0].ef_idnum,
					"pb_lv":ef["evaluation"+0][0].ef_lv,
					"pb_num":ef["evaluation"+0][0].ef_num,
				 	"pb_pbnum":prevNum,
				 	"pb_pbstudent":multiAnswer
				}
			}else{				
				var obj={
					"pb_idnum":ef["evaluation"+0][0].ef_idnum,
					"pb_lv":ef["evaluation"+0][0].ef_lv,
					"pb_num":ef["evaluation"+0][0].ef_num,
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
	    				selectQuiz(nextNum);
	    			},error: function(err){
	    				selectQuiz(nextNum);	
	    			}
				});
			
		}else{
			selectQuiz(nextNum);
		}
		
	}//function insertQuiz() END
	function evaluationStart() {
		$('#secondTitle').html("강의평가");
		var map=[];
		var mapNum=0;
		for(var i=0; i<Object.keys(ef).length; i++){
			var str="";
			str +="<div>"+(i+1)+". "+ef["evaluation"+i][i].ef_item+"</div>";
				for(var j=0; j<ef["evaluation"+i].length; j++){
					str+="<br/><div>"+(j+1)+") "+ef["evaluation"+i][j].ef_question+"</div>";
					var table="<table style='width:500px;'><tr id='scName'>";
					for(var e in ak){
						table+="<td >"+ak[e].ak_scName+"</td>";
					}
					table+="</tr><tr id='score'>";
					for(var e in ak){
						table+="<td><input type='radio' id='ak_score"+mapNum+"' name='ak_score"+mapNum+"' value='"+ak[e].ak_score+"'></td>";
					}
					mapNum= mapNum+1;
					table+="</tr></table><br/>";
					str+=table;
					var obj = {
							"ef_num":ef["evaluation"+i][j].ef_num,
							"ef_lv": ef["evaluation"+i][j].ef_lv,
							"ef_item":ef["evaluation"+i][j].ef_item,
							"ef_idnum":ef["evaluation"+i][j].ef_idnum,
							"ef_question":ef["evaluation"+i][j].ef_question
					} 	
					map.push(obj);
			}
			$('#courseHead').append(str); 
		}
		map=JSON.stringify(map);
		$('#courseBody').append("<input type='hidden' id='map' value='"+map+"'>");
		$('#courseHead').append("<input type='button' value='작성하기' onclick='insertEvaluation()'>");
	}//function evaluationStart END
	
	function insertEvaluation(){
		var map=$('#map').val(); 
		map=JSON.parse(map);
		for(var i=0; i<map.length; i++){
			if($("input:radio[id=ak_score"+i+"]").is(':checked')==true){
				map[i].ak_score=$("input:radio[id=ak_score"+i+"]:checked").val();
			}else{
				alert("모든 문항을 체크해주세요.");
				break;
			}
		}//forEND
		if(map[map.length-1].ak_score != undefined){
			console.log(map);
			 $.ajax({
				type:'post',
				url:"rest/insertCourseEvaluationAjax",
				data:JSON.stringify(map),
				datatype:'json',
				contentType:"application/json",
				beforeSend : function(xhr){
	    			var $token = $("#token");
	    			xhr.setRequestHeader($token.data("token-name"), $token.val());
	    		},success:function(json){
					if(json !=0){
						quizStart();
					}else{
						alert("준비된 퀴즈가 없습니다.");
					}
				},error: function(err){
					console.log(err);
				}
			}); 
		}else{
			console.log("실패");
		}
	}//function insertEvaluation() END
</script>
</html>