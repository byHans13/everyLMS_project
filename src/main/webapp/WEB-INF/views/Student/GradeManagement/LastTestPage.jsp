<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	width: 1000px;
	float: left;
}

.menu {
	margin-left: 20px;
	text-align: center;
	width: 200px;
	border: 1px black solid;
	float: left;
}

#modal {
	display: none;
	position: fixed;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%
}

#modal.open {
	display: block;
	color: red;
}

#modal #bg_modal {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #000;
	opacity: .5;
	filter: alpha(opacity = 50);
	z-index: 100
}

#contents_modal {
	position: absolute;
	top: 40%;
	left: 40%;
	width: 600px;
	height: 500px;
	margin: -150px 0 0 -194px;
	padding: 28px 28px 0 28px;
	border: 2px solid #555;
	background: #fff;
	font-size: 12px;
	z-index: 200;
	color: #767676;
	line-height: normal;
	white-space: normal;
	overflow: scroll
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
			test(id);
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
			name='${_csrf.parameterName}' value='${_csrf.token}'>
		<div id='totalDiv'>
			<div id='testTable'></div>
		</div>
		<div id='modal'>
			<div id='bg_modal'></div>
			<div id='contents_modal'>
				<div class='finalTest' name='finalTest' id='finalTest'>
					<div id='ftHead'></div>
					<div id='ftBody' style='float: left'></div>
				</div>
			</div>
		</div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
</body>
<script>
	var modal = $('#modal');
	var ft = ${ft};
	var gr = ${grade};
	var pb_num = 0;// insert 할 
	var testCheckCount = 0; // 1이면 모달 못띄움 
	var tableCount = 0;
	var testLength =0;
	var professorId ="";
	var classIdnum="";
	var classLv ="";
	console.log(ft);
	console.log(gr);
	function test(id) {
		$.ajax({
			type : 'get',
			url : 'rest/selectConcern',
			datatype : 'json',
			success : function(json) {
				for (var i = 0; i < json.length; i++) {
					$('#menu').append(
							"<div class='menu'><p>" + json[i] + "</p></div>");
				}
				startCreateTestTable();
			},
			error : function(err) {
				startCreateTestTable();
			}
		});
	};
	function startCreateTestTable() {
		var str = "";
		var body = $('#testTable');
		body.append("<h3>Final Test List</h3>");
		str += "<table><tr><td>강의명</td><td>LV</td><td>강사명</td><td>강의종료일</td><td>finalTest</td></tr>";
		if (ft != 0) {
			for (var i = 0; i < ft.length; i++) {
				//	if(atmklength == lcnum){
				for (var j = 0; j < gr.length; j++) {
					if (ft[i].cl_idnum == gr[j].aa_idnum
							&& ft[i].cl_lv == gr[j].aa_lv && gr[j].gr_kind == 0) {
						str += "<tr>";
						str += "<td>" + ft[i].cl_clName + "</td>";
						str += "<td>" + ft[i].cl_lv + "</td>";
						str += "<td>" + ft[i].mb_name + "</td>";
						str += "<td>" + ft[i].cl_fnDay.substring(0, 10)
								+ "</td>";
						str += "<td><a href='#' onclick=\"openFinalTest('"
								+ ft[i].cl_idnum + "','" + ft[i].cl_lv + "','"
								+ ft[i].cl_id + "')\">시험보기</a></td>";
						str += "</tr>";
						tableCount += 1;
					} else {
						tableCount += 0;
					}//else
				}//for j	
			}//for i
			if (tableCount != 0) {
				str += "</table>";
			} else {
				str += "<tr><td colspan='5'>조건을 만족하는 시험 일정이 없습니다.</td></tr></table>";
			}
			//}else{ if tableCount 감싸면 됨}
		} else {
			str += "<tr><td colspan='5'>조건을 만족하는 시험 일정이 없습니다.</td></tr></table>";
		}
		body.append(str);

	}// function startCreateTestTable END

	function openFinalTest(idnum, lv, pid) {
		testCheckCount = testCheckCount + 1;
		var pb_idnum = idnum;
		var pb_lv = lv;
		professorId = pid;
		classIdnum = pb_idnum;
		classLv = pb_lv;
		var obj = {
			"pb_idnum" : pb_idnum,
			"pb_lv" : pb_lv,
			"pb_num" : pb_num,
			"pb_id" : professorId
		};
		modal.addClass('open');
		var m_contents = $('#contents_modal');
		$.ajax({
			type : 'get',
			url : 'rest/selectFinalTestPbnum',
			data : obj,
			dataType : 'json',
			success : function(json) {
				console.log(json);
				var head = $('#ftHead');
				head.html("");
				$('#ftBody').html("");
				head.append("<div id='headDiv'></div>");
				head.append("<input type='hidden' id='pbnum' name='pb_pbnum' value=''>");
				$('#headDiv').append("<input type='hidden' id='pbnum' name='pb_pbnum' value=''>");
				$('#headDiv').append("<table><tr><td>남은시간: </td><td id='timer'></td></tr></table>");
				$('#headDiv').append("<input type='button' value='제출하기' onclick=\"lastTestInsert(1, '"+json[0].pb_idnum+"', '"+json[0].pb_lv+"')\">");
				testLength = json.length;
				console.log("testLength="+testLength);
				for (var i = 0; i < json.length; i++) {
					var str = "";
					str += "<div id='quizDiv"+ json[i].pb_pbnum
							+ "' style='text-align:center; padding:10px; width:20px; height:20px; margin:15px;";
					str += "float:left; border:1px solid black;' onclick=\"insertTest('"+json[i].pb_idnum+"','"+json[i].pb_lv+"','"
							+ json[i].pb_pbnum + "')\">" + json[i].pb_pbnum + "</div>";

					head.append(str);
				}//for i
				selectTest(json[0].pb_idnum, json[0].pb_lv, json[0].pb_pbnum);
				testTimer(json[0].pb_idnum, json[0].pb_lv);
			},
			error : function(err) {
				console.log(err);
			}
		});

	}// function openFinalTest() END 
	function testTimer(idnum, lv){
		var pb_idnum= idnum;
		var pb_lv = lv;
		var time=1200;
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
	function selectTest(idnum, lv, pbnum){		
		var obj = {
			"pb_idnum":idnum,
			"pb_lv":lv,
			"pb_num":pb_num,
			"pb_id":professorId,
			"pb_pbnum":pbnum
		}; 
		console.log("hidden 넣기 전 pbnum="+pbnum);
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
    				pbnum = parseFloat(pbnum)+1;
    				console.log("다음 버튼 누르기 전 pbnum="+pbnum);
	   	 			body.append("<input type='button' value='다음문제풀기' onclick=\"insertTest('"+json[0].pb_idnum+"','"+json[0].pb_lv+"',"+pbnum+")\"><br/>");

    		},error: function(err){
    			console.log(err);
    		}
		});//ajax END
	}//function selectQuiz() END
	
	function insertTest(idnum, lv, pbNum){
		var prevNum = $('#pbnum').val();
		console.log("PBPBPBPBPBPBPBPBPB="+pbNum);
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
					"pb_idnum":idnum,
					"pb_lv":lv,
					"pb_num":pb_num,
					"pb_id":professorId,
				 	"pb_pbnum":prevNum,
				 	"pb_pbstudent":multiAnswer
				}
			}else{				
				var obj={
					"pb_idnum":idnum,
					"pb_lv":lv,
					"pb_num":pb_num,
					"pb_id":professorId,
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
	    				console.log("DDDDDD="+nextNum);
	    				$('#quizDiv'+json).css('background-color','red');
	    				selectTest(idnum, lv, nextNum);
	    			},error: function(err){
	    				selectTest(idnum, lv, nextNum);	
	    			}
				});
		}else{
			selectTest(idnum, lv, nextNum);
		}
	}// function insertTest() END 
	
	function lastTestInsert(chk, idnum, lv){
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
					"pb_idnum":idnum,
					"pb_lv":lv,
					"pb_num":pb_num,
					"pb_id":professorId,
				 	"pb_pbnum":lastNum,
				 	"pb_pbstudent":multiAnswer};
			}else{				
				var obj={
					"pb_idnum":idnum,
					"pb_lv":lv,
					"pb_num":pb_num,
					"pb_id":professorId,
				 	"pb_pbnum":lastNum,
				 	"pb_pbstudent":subjectAnswer};
			}
		}else{
			var obj={
					"pb_idnum":idnum,
					"pb_lv":lv,
					"pb_num":pb_num,
					"pb_id":professorId,
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
						modal.removeClass('open');
					}else{
						alert("제한시간이 끝났습니다. 페이지를 종료하겠습니다.");
						modal.removeClass('open');
					}
				}else{
					alert("error : 시험 내역을 확인 후 이상이 있으시면 문의해주세요.");
					modal.removeClass('open');
				}    			
    		},error: function(err){
    			console.log(err);
    		}
		});//ajax END
	}; //function lastTestInsert() END


	modal.find('#bg_modal').on('mousedown', function(evt) {
		console.log(evt);
		if (confirm("이대로 나가면 0점처리 됩니다. 나가시겠습니까?")) {
			forceStopTest();		
		} else {
			return;
		}
	});// modal mousesdown end
	$(document).keydown(function(evt) {
		if (evt.keyCode != 27) {
			return;
		} else if (modal.hasClass('open')) {
			if (confirm("이대로 나가면 0점처리 됩니다. 나가시겠습니까?")) {
				 forceStopTest();			
			} else {
				return;
			}
		}
	}); //modal esc END
	
	function forceStopTest(){
		var obj={
				"pb_idnum":classIdnum,
				"pb_lv":classLv,
				"pb_id":professorId,
				"pb_num":pb_num
		};
		console.log(obj);
		$.ajax({
			type:'get',
			url:"rest/insertFinalTestForceStop",
			data:obj,
			dataType:'json',
			success: function(json){
				if(json != 'true'){
					modal.removeClass('open');
				}else{
					alert("페이지 종료에 실패했습니다.");
				}
			},error: function(err){
				alert("err: 페이지 종료에 실패했습니다.");
			}
		});// ajax END
	 }// function forceStopTest() END 
</script>

</html>