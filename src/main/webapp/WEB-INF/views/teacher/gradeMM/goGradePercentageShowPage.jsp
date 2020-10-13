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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="//www.google.com/jsapi"></script>
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
	width: 1300px;
	float: left;
}
.menu{
    margin-left: 20px;
    text-align:center;
    width: 200px;
    border: 1px black solid;
    float: left;
}
.tg  {border-collapse:collapse;border-color:#9ABAD9;border-spacing:0;}
.tg td{background-color:#EBF5FF;border-color:#9ABAD9;border-style:solid;border-width:0px;color:#444;
  font-family:Arial, sans-serif;font-size:14px;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{background-color:#409cff;border-color:#9ABAD9;border-style:solid;border-width:0px;color:#fff;
  font-family:Arial, sans-serif;font-size:14px;font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-tns0{font-size:32px;font-weight:bold;text-align:center;vertical-align:top}
.tg .tg-qncv{font-size:32px;text-align:left;vertical-align:top}
.tg .tg-g9xd{background-color:#D2E4FC;font-size:32px;text-align:left;vertical-align:top}
.tg .tg-dlxr{background-color:#D2E4FC;font-size:32px;text-align:center;vertical-align:top}
.tg .tg-j32n{font-size:32px;text-align:center;vertical-align:top}
</style>
</head>
<body>
  <input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<header>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
	
	<form id="frm">	
		<div style="background-color: #409cff; height: 80px; ">
			<h2 id="clname" style="float: left; margin-left: 10px;margin-top: 15px;color: white; font-size: 35px;"></h2>
		</div>
	</form>	
		
		<div style="height: 100px;"></div>
		
		<div id="selectbox" style="height: 200px; overflow: auto;">
			
			<table id="selectTable" class="tg" style="width: 1300px;">
			</table>
		</div>
		<hr>
		
		<div id="percentage">
			<table id="percentageTable" class="tg" style="width: 1300px;">
			</table>
		</div>
		<hr>
		<div id="pct"></div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>


<script>
var glist = ${glist};
var clname = '${clname}';
	console.log(glist);
	console.log(clname);
var pctArr=null;
$("#clname").html("<b>"+clname+"- 수강생 백분율 보기</b>");

$("#selectTable").append("<tr>");
$("#selectTable").append("<th class='tg-tns0'>강의명</th>");
$("#selectTable").append("<th class='tg-tns0'>회차</th>");
$("#selectTable").append("<th class='tg-tns0'>학생아이디</th>");
$("#selectTable").append("<th class='tg-tns0'>백분율</th>");
$("#selectTable").append("</tr>");
var clname1 = clname.replace(/ /gi,',');
	console.log(clname1);

for(var i=0; i<glist.length;i++){

var test = glist[i].co_name;
	console.log(test);
var co_name = test.replace(/ /gi,',');
	console.log(co_name);
	console.log(glist[i].gr_id1);

$("#selectTable").append("<tr>");
$("#selectTable").append("<td class='tg-dlxr'>"+clname+"</td>");
$("#selectTable").append("<td class='tg-dlxr'>"+glist[i].gr_num+"</td>");
$("#selectTable").append("<td class='tg-dlxr'>"+glist[i].gr_id1+"</td>");
$("#selectTable").append("<td class='tg-dlxr'> <form id='gradepercentage"+i+"'>"+
		"<input type='hidden' name='cl_clname' value="+clname1+">"+
		"<input type='hidden' name='co_name' value="+co_name+">"+
		"<input type='hidden' name='co_num' value="+glist[i].gr_num+">"+
		"<input type='hidden' name='cl_idnum' value="+glist[i].gr_idnum+">"+
		"<input type='hidden' name='gr_id1' value="+glist[i].gr_id1+">"+
		"<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
		"<button class='btn btn-primary' type='button' onclick='gradepercentage("+i+")'>보기</button></form></td>");
$("#selectTable").append("</tr>");
	
}

function gradepercentage(a) {
console.log("OK");
var form=$("#gradepercentage"+a).serialize();
console.log(form);
$("#pct").html("");
	$.ajax({
	type:'post',
	data:$("#gradepercentage"+a).serialize(),
	url:'rest/selectGradePercentage',
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
		console.log(json.homeworkStudNum/json.homeworkMaxNum);
		var attendance= Math.floor((json.studAttendanceNum/json.classMaxRoundNum)*json.rc_at);
		var quiz=		Math.floor((json.quizStudPbNum/json.quizPbMaxNum)*json.rc_qz);
		var homework=	Math.floor((json.homeworkStudNum/json.homeworkMaxNum)*json.rc_hw);
		var test=		Math.floor((json.teststudPbNum/json.testPbMaxNum)*json.rc_test);
		console.log("과제       :"+isNaN(homework));
		console.log("퀴즈       :"+isNaN(quiz));
		
		if(isNaN(homework)){
			if(json.homeworkStudNum==0 && json.homeworkMaxNum==0){
				homework=0;
				var tot= attendance+quiz+homework+test;
			}			
		}else{
			var tot= attendance+quiz+homework+test;
		}
		
		
		var Arr1= new Array(5);
		var Arr2= new Array(5);
		
		var cnt1=0;
		var cnt2=0;
		var cnt3=0;
		var cnt4=0;
		
		Arr1[0]="출결";
		Arr1[1]="퀴즈";
		Arr1[2]="과제";
		Arr1[3]="시험";
		Arr1[4]="총점수";

		Arr2[0]=attendance;
		Arr2[1]=quiz;
		Arr2[2]=homework;
		Arr2[3]=test;
		Arr2[4]=tot;
		
		var arr=new Array(2);
		for(var i=0;i<arr.length;i++){
			arr[i]=new Array(6);
			if(i==0){
				arr[i][0]=["과목","점수",{ role: 'style' }];
			}
			else if(i==1){
				arr[i][0]=["과목","점수"];
			}
			for(var j=1;j<arr[0].length;j++){
				if(i==0){
	 				if(j!=arr[0].length-1){
	 					console.log("왜?  :");
	 					arr[i][j]= [Arr1[cnt1++] ,Arr2[cnt2++], '#b87333'];
	 				}else{
	 					console.log("들어옴?  :"+j);
	 					arr[i][j]= [Arr1[cnt1++] ,Arr2[cnt2++], '#662500'];
	 				}
					
				}
				else if(i==1){
					arr[i][j]=[Arr1[cnt3++],Arr2[cnt4++]];
				}
			}
			if(i==1){
				arr[i].splice(5);
			}
		}
		console.log(arr);
		pctArr=arr;
		console.log("출결:"+attendance);
		console.log("퀴즈:"+quiz);
		console.log("과제:"+homework);
		console.log("시험:"+test);
		
		$("#percentageTable").html("");
		$("#percentageTable").append("<tr>");
		$("#percentageTable").append("<th class='tg-tns0'>학생아이디</th>");
		$("#percentageTable").append("<th class='tg-tns0'>출결</th>");
		$("#percentageTable").append("<th class='tg-tns0'>퀴즈</th>");
		$("#percentageTable").append("<th class='tg-tns0'>과제</th>");
		$("#percentageTable").append("<th class='tg-tns0'>시험</th>");
		$("#percentageTable").append("<th class='tg-tns0'>총점수</th>");
		$("#percentageTable").append("<th class='tg-tns0'>그래프 보기</th>");
		$("#percentageTable").append("</tr>");
		
		$("#percentageTable").append("<tr>");
		$("#percentageTable").append("<td class='tg-dlxr'>"+json.studId+"</td>");
		$("#percentageTable").append("<td class='tg-dlxr'>"+attendance+"</td>");
		$("#percentageTable").append("<td class='tg-dlxr'>"+quiz+"</td>");
		$("#percentageTable").append("<td class='tg-dlxr'>"+homework+"</td>");
		$("#percentageTable").append("<td class='tg-dlxr'>"+test+"</td>");
		$("#percentageTable").append("<td class='tg-dlxr'>"+tot+"</td>");
		$("#percentageTable").append("<td class='tg-dlxr'><button id='pctOnBtn' class='btn btn-primary' type='button' onclick='percentage()'>클릭</button><button id='pctOffBtn' class='btn btn-primary' type='button' onclick='pctOffBtn()' style='display: none'>접기</button></td>");
		$("#percentageTable").append("</tr>");
		
	},
	error: function (err) {
		console.log(err);
	}
	
});  
}

function percentage() {
console.log("OK");
console.log(pctArr);
$("#pctOnBtn").css("display","none");
$("#pctOffBtn").css("display","block");
//margin:auto
$("#pctOffBtn").css("margin","auto");

	var jsonStr1 =JSON.stringify(  pctArr[0] );
	var jsonStr2 =JSON.stringify(  pctArr[1] );
	console.log(jsonStr1);
	console.log(jsonStr2);
	
	$.ajax({
	type:'get',
	url:'rest/gradePercentage',
	data:{grade1:jsonStr1, grade2:jsonStr2},
	datatype:'html', 
	beforeSend : function(xhr)
	{
		//이거 안하면 403 error
		//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
		var $token = $("#token");
		xhr.setRequestHeader($token.data("token-name"), $token.val());
	},
	success: function (data) {
		console.log(data);
		$("#pct").html(data);
	},
	error: function (err) {
		console.log(err);
	}
	
	});   
}

function pctOffBtn() {
$("#pct").html("");
$("#pctOffBtn").css("display","none");
$("#pctOnBtn").css("display","block");
$("#pctOnBtn").css("margin","auto");

}
</script>
</body>
</html>