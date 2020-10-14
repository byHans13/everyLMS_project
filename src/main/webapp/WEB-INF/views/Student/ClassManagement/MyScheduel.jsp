<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<script src="../resources/js/jquery.serializeObject.js"></script>

  
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

.menu {
	margin-left: 20px;
	text-align: center;
	width: 200px;
	border: 1px black solid;
	float: left;
}
.main {
	width: 100%;
	display: block;
	background: #ababab;
}

.content-wrap {
	width: 100%;
	margin: 0 auto;
	border: 4px solid rgba(161, 161, 161, 0.5);
	border-radius: 20px;
	overflow: hidden;
	background: white;
}

.month {
	font-size: 25px;
	font-weight: bold;
	margin: 20px 0;
}

.content-right table tr td {
	width: 40px;
	height: 40px;
	text-align: center;
	font-size: 20px;
	font-weight: bold;
}

.plan {
	background: gray;
	color: #ddaf35;
	float: left;
	width: 460px;
	height: 600px;
	padding: 90px 20px 20px 0;
}
table.type05 {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    margin: 20px 10px;
}
table.type05 th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #efefef;
}
table.type05 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}

</style>
</head>
<body>
<script>
$(document).ready
(function() {
	//var aut =JSON.parse("${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}");
	var aut= "${aut}";
	var n = aut.indexOf("ROLE_PROF");
	 var id = "${id}";
	if (n == 1){
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
		<div class="main">
		<!--최상위 div main -->
		<div class="content-wrap">
			<!-- 차상위 div -->
			<div class="plan">
				<!-- 달력 왼쪽에 날짜를 표시하기 위한 div -->
				<div class="plan-day">
					<!-- 날짜와 요일을 표시하는 div -->
					<div id="month" class="month"></div>
				</div>
				<div class="todayPlan">
					<!-- 요일별 todoList input & output -->
					<form id='todoList' name='todoList' class='todoList' method="post">
						<div class="plan-title">Insert Plan</div>
						<div class="plan-input">
							<table class='type05'>
								<tr>
									<th style='color:black;'>강의</th>
									<td style='color:black;'>
									<select name='Sc_idnum' id='classList'></select> 									
									</td>
								</tr>
								<tr>
									<th style='color:black;'>회차</th>
									<td style='color:black;'><select name='Sc_num' id='courseList' ></select></td>
								</tr>
								<tr>
									<th style='color:black;'>일정</th>
									<td style='color:black;'>
							 			<input type="text" placeholder="일정을 적어주세요" id="contents" name='Sc_contents' class="contents">
									</td>
								</tr>
							</table>
								<input type='button' value='일정 입력' onclick="insertCalendar()"
								class='input-data' id='input-data' style='color:black;'>
							<input type='hidden' id='token' data-token-name='${_csrf.headerName}' 
									name = '${_csrf.parameterName}' value='${_csrf.token}' >
							<input type="hidden" name='Sc_year' id='hiddenYear' value=''>
							<input type="hidden" name='Sc_month' id='hiddenMonth' value=''>
							<input type="hidden" name='Sc_date' id='hiddenDate' value=''>
							<br/>
						</div>
					</form>
					<br/>
					<div id="plan-output" class="plan-output" name='plan-output'></div>
				</div>
			</div>
			<div class="content-right">
				<!-- 오른쪽에 calendar 출력을 위한  -->
				<table id="calendar" align="center">
					<thead>
						<tr class="btn-befor-next">
							<td onclick=prev()>&#60;</td>
							<td align="center" id="current-year-month" colspan="5"></td>
							<td onclick=next()>&#62;</td>
						</tr>
						<tr>
							<td class="sun" align="center">Sun</td>
							<td align="center">Mon</td>
							<td align="center">Tue</td>
							<td align="center">Wed</td>
							<td align="center">Thu</td>
							<td align="center">Fri</td>
							<td class="sat" align="center">Sat</td>
						</tr>
					</thead>
					<tbody id="calendar-body" class="calendar-body"></tbody>
				</table>
			</div>
		</div>
	</div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
</body>
<script>
var today = new Date(); // 현재 시간까지 들어감 연 월 일 시 분 초 
var first = new Date(today.getFullYear(), today.getMonth(),1); // 현재 연도, 달, 1일 값을 넣어줌 
var dayList = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
var monthList = ['January','February','March','April','May','June','July','August','September','October','November','December'];
var leapYear=[31,29,31,30,31,30,31,31,30,31,30,31]; // 윤년
var notLeapYear=[31,28,31,30,31,30,31,31,30,31,30,31]; 
var pageFirst = first; 
var pageYear;
var classList = ${classList};
console.log(classList);

// 년도 / 4 = 0 >> 윤년 
if(first.getFullYear() % 4 === 0){ 
    pageYear = leapYear;
}else{
    pageYear = notLeapYear;
}

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
			showCalendar();
			showMain();
		},
		error: function (err) {
			showCalendar();
			showMain();
		}
	});
}; 

function showCalendar(){
    let monthCnt = 100; // week id value 100~105 
    let cnt = 1; // datee id value 1~31 
    for(var i = 0; i < 6; i++){ //최대 6주
        var $tr = document.createElement('tr'); // equals <tr></tr>
        $tr.setAttribute('id', monthCnt);   
        for(var j = 0; j < 7; j++){ // 일주일
            if((i === 0 && j < first.getDay()) || cnt > pageYear[first.getMonth()]){
                var $td = document.createElement('td');
                $tr.appendChild($td);     
            }else{
                var $td = document.createElement('td');
                var todaytoday = new Date();
                $td.textContent = cnt;
                if(cnt == todaytoday.getDate()){
                	$td.style.backgroundColor='yellow';
                }
                $td.setAttribute('id', cnt); //db에 넣을 pk값 +sessionID                  
            	//$td.setAttribute('onclick', test(cnt));
                $td.addEventListener('click', test);
            	//$td.onclick=test(cnt);
                $tr.appendChild($td); 
               	//console.log($td.getAttribute('id'));
                cnt++;
            }
        }
        monthCnt++;
        document.getElementById('calendar-body').appendChild($tr);
    }
    document.getElementById('current-year-month').innerHTML = monthList[first.getMonth()] +" "+ first.getFullYear();
} //showCalendar End 
function removeCalendar(){
    let catchTr = 100;
    for(var i = 100; i< 106; i++){
        var $tr = document.getElementById(catchTr);
        $tr.remove();
        catchTr++;
    }
} // 만들어놓은 달력을 지우기 위한 함수  
function prev(){  
    if(pageFirst.getMonth() === 1){// 1월일 경우 전년도 12월로 가기 위한 if 
        pageFirst = new Date(first.getFullYear()-1, 12, 1);
        first = pageFirst;
        if(first.getFullYear() % 4 === 0){
            pageYear = leapYear;
        }else{
            pageYear = notLeapYear;
        }
    }else{
        pageFirst = new Date(first.getFullYear(), first.getMonth()-1, 1);
        first = pageFirst; // pageFirst에 달 -1 해줌.
    }
    today = new Date(today.getFullYear(), today.getMonth()-1, today.getDate());
    document.getElementById('current-year-month').innerHTML = monthList[first.getMonth()] + " "+ first.getFullYear();
    removeCalendar(); // 이전 달력 지우기
    showCalendar(); // 변경된 month값 가지고 달력 다시 출력하는 함수 
    showMain(); // 해당 getDate값으로  요일, 해당일 찍어주는 함수 
    
}// prev End // 이전 달로 돌아가기 위한 함수ㅜ 
function next(){
    if(pageFirst.getMonth() === 12){
        pageFirst = new Date(first.getFullYear()+1, 1, 1);
        first = pageFirst;
        if(first.getFullYear() % 4 === 0){
            pageYear = leapYear;
        }else{
            pageYear = notLeapYear;
        }
    }else{
        pageFirst = new Date(first.getFullYear(), first.getMonth()+1, 1);
        first = pageFirst;
    }
    if(today.getDate()==31){
    	today = new Date(today.getFullYear(), today.getMonth() + 2, 0); //0은 전달 마지막일을 뜻함 0으로 전달로 넘어가서 +1해도 달은 그대로 그래서 +2를 해줬음 
    }else{    	
    	today = new Date(today.getFullYear(), today.getMonth() + 1,today.getDate());
    }
    console.log(today.getDate());
    document.getElementById('current-year-month').innerHTML = monthList[first.getMonth()] + " "+ first.getFullYear();
    removeCalendar();
    showCalendar(); 
    showMain();    
}//next End // 다음달로 넘어가기 위한 함수

function showMain(){ // 시작했을 때,날짜 변경시 실행
	var option = $('#classList');
	var courseOption = $('#courseList');
	option.html("");
	courseOption.html("");
	option.append("<option  value=''>강의를 선택해주세용.</option>");
	courseOption.append("<option value=''>강의를 먼저 선택해주세요.</option>");
	for(var i in classList){
	option.append("<option value='"+classList[i].cl_idnum+"'>"+classList[i].cl_clName+"</option>");
	} // selectBox에 강의 일련번호 = value 강의 이름 = name 넣어주기위한 반복문
	
	document.getElementById('month').innerHTML = today.getDate()+" "+
	monthList[today.getMonth()] +" " + today.getFullYear() +" ("+dayList[today.getDay()]+")";
    
    document.getElementById('hiddenYear').value=today.getFullYear();
    document.getElementById('hiddenMonth').value=(today.getMonth()+1);
    document.getElementById('hiddenDate').value=today.getDate(); 
	jQuery.fn.serializeObject = function() {
		  var obj = null;
		  try {
		    if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) {
		      var arr = this.serializeArray();
		      if(arr){
		        obj = {};    
		        jQuery.each(arr, function() {
		        obj[this.name] = this.value;
		        });             
		      }
		    }
		  }catch(e) {
		    alert(e.message);
		  }finally  {}
		  console.log("serialObject hans= ",obj);
		  return obj;
		}
    var obj = jQuery('#todoList').serializeObject();
    /* var obj = {
    		"sc_idnum":,
    		"sc_lv":,
    		"sc_num":,
    		"sc_year":,
    		"sc_month":,
    		"sc_date":
    }; */
    console.log(obj);
    $.ajax({ //일정 select하기
    	type:'post' ,
    	url: "rest/selectScheduleAjax",
    	data: obj ,
    	dataType:'json',
    	beforeSend : function(xhr)
		{
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
    	success: function(json){
    		$('#plan-output').html("");
  			if(json!=""){
    			var str=$('#plan-output');  
    			var build="";
    			build += "<table class='type05'>";
    			for(var i=0; i<json.length; i++){
    				console.log(json);
					build += "<tr>";
					build += "<td style='color:black;'>"+json[i].cl_clName+"</td>";	
					build += "<td style='color:black;'>"+json[i].co_name+"</td>";
					build += "<td style='color:black;'>"+json[i].sc_contents+"</td>";
					build += "<td onclick =\"deleteCalendar('"+json[i].sc_idnum+"','"
							+json[i].sc_lv+"','"+json[i].sc_contents+"','"+json[i].sc_num+"')\"><a href='#;' style='color:black;'>일정 삭제</a></td>";
					build +="<td><a href='/h2k5every/stud/classHome?cl_idnum="
							+json[i].sc_idnum+"&cl_lv="+json[i].sc_lv+
							"' style='color:black;'>강의실로 이동</a></td>"
					build += "</tr>";
				}
    			build += "</table>";
    			str.append(build);
    			str.append("<input type='hidden' id='token' data-token-name='${_csrf.headerName}'" 
					+"name = '${_csrf.parameterName}' value='${_csrf.token}' >");
  			}else {
  				$('#plan-output').html("일정을 추가해주세요.");
  				$('#plan-output').append("<input type='hidden' id='token' data-token-name='${_csrf.headerName}'" 
					+"name = '${_csrf.parameterName}' value='${_csrf.token}' >");
  			}
    	},error: function(err){
    		console.log(err);
    	}
    }); //ajax
} // showMain End // 일정 위에 날짜를 찍기 위한 함수
function test(e){
	var cnt = e.currentTarget;
    today = new Date(today.getFullYear(), today.getMonth(), cnt.id);
    showMain();
}
function insertCalendar(){

    var obj = $('#todoList').serializeObject();
	$.ajax({
		type:'post',
		url:'rest/insertScheduleAjax',
		data:obj ,
		dataType:'json',
		beforeSend : function(xhr)
		{
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
		success : function(json){
    		$('#plan-output').html("");
			var str=$('#plan-output');
			var option = $('#classList');
			var classList = ${classList};
			var courseOption = $('#courseList');
			option.html("");
			courseOption.html("");
			option.append("<option  value=''>강의를 선택해주세용.</option>");
			courseOption.append("<option value=''>강의를 먼저 선택해주세요.</option>");
			for(var i in classList){
			option.append("<option value='"+classList[i].cl_idnum+"'>"+classList[i].cl_clName+"</option>");
			} // selectBox에 강의 일련번호 = value 강의 이름 = name 넣어주기위한 반복문
			
			if(json.length !=0){
    			var build="";
    			build += "<table class='type05'>";
    			for(var i=0; i<json.length; i++){
    				console.log(json);
					build += "<tr>";
					build += "<td style='color:black;'>"+json[i].cl_clName+"</td>";	
					build += "<td style='color:black;'>"+json[i].co_name+"</td>";
					build += "<td style='color:black;'>"+json[i].sc_contents+"</td>";
					build += "<td onclick =\"deleteCalendar('"+json[i].sc_idnum+"','"
							+json[i].sc_lv+"','"+json[i].sc_contents+"','"+json[i].sc_num+"')\"><a href='#;' style='color:black;'>일정 삭제</a></td>";
					build +="<td><a href='/h2k5every/stud/classHome?cl_idnum="
							+json[i].sc_idnum+"&cl_lv="+json[i].sc_lv+
							"' style='color:black;'>강의실로 이동</a></td>"
					build += "</tr>";
				}
    			build += "</table>";
    			str.append(build);

  			}else {
	  			$('#plan-output').html("일정을 추가해주세요.");
			}
  			
		}, error: function(err){
			console.log(err);
		}
	});
	$('#classList').val("강의를 선택해주세요");
	$('#contents').val(""); // insert 후 입력값 초기화 하기 위함ㅁ 
}
function deleteCalendar(classList, lv, contents, courseList){
	var sc_idnum = classList;
	var sc_contents = contents;
	var sc_num = courseList;
	var sc_lv = lv;
	var obj = $('#todoList').serializeObject();
	obj.sc_idnum = sc_idnum; 
	obj.sc_contents = sc_contents;
	obj.sc_num = sc_num;
	obj.sc_lv = sc_lv;
	console.log(obj);
	$.ajax({
		type: 'post' ,
		url: "rest/deleteScheduleAjax",
		data: obj, 
		dataType: 'json',
		beforeSend : function(xhr)
		{
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
		success: function(json){
			$('#plan-output').html("");
			var str=$('#plan-output');
			if(json.length!=0){
				var build="";
				build += "<table class='type05'>";
    		for(var i=0; i<json.length; i++){    			
    			build += "<tr>";
				build += "<td style='color:black;'>"+json[i].cl_clName+"</td>";	
				build += "<td style='color:black;'>"+json[i].co_name+"</td>";
				build += "<td style='color:black;'>"+json[i].sc_contents+"</td>";
				build += "<td onclick =\"deleteCalendar('"+json[i].sc_idnum+"','"
						+json[i].sc_lv+"','"+json[i].sc_contents+"','"+json[i].sc_num+"')\"><a href='#;' style='color:black;'>일정 삭제</a></td>";
				build +="<td><a href='/h2k5every/stud/classHome?cl_idnum="
						+json[i].sc_idnum+"&cl_lv="+json[i].sc_lv+
						"' style='color:black;'>강의실로 이동</a></td>"
				build += "</tr>";
			}
			build += "</table>";
			str.append(build);
  			}else {
		 	$('#plan-output').html("일정을 추가해주세요.");
			}
		}, error: function(err){
			console.log(err);
		}
	});
 }
 // classList값을 통해 이벤트 발생 courseList 출력
 $('#classList').change(function(){
	console.log($('#classList').val());
	var idnum =$('#classList').val();
	var lv = classList[0].cl_lv;
	/////////////전역변수에 idnum lv 넣어야해 근데 이건 showInfo에서 그 후 여기서 co_num 넣는 작업 ! 
	$.ajax({
		type:'post',
		url:'rest/selectCourseListAjax',
		data:{co_idnum:idnum, co_lv : lv},
		dataType:'json',
		beforeSend : function(xhr)
		{
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
		success:function(json){
			$('#courseList').html("");
			$('#courseList').append("<input type='hidden' id='token' data-token-name='${_csrf.headerName}'" 
					+"name = '${_csrf.parameterName}' value='${_csrf.token}' >");
			console.log(json);
			var cl = $('#courseList');
			if(json.length!=0){				
			for(var i in json){
				cl.append("<option value='"+json[i].co_num+"'>"+json[i].co_name+"</option>");
				}		
			}else{
				cl.append("<option value=''>강의를 먼저 선택해주세요.</option>")
			}//if 
		}, error: function(err){
		console.log(err);	
		}
	}); //courseList ajax
 });
</script>
</html>