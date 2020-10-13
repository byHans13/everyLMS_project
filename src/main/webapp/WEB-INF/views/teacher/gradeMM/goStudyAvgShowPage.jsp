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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="//www.google.com/jsapi"></script>
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
			
			<table id="selectTable"class="tg"style="width: 1200px;">
			</table>
		</div>
		<hr>
		<button id="btnon" type="button" onclick="percentageBtn()" class="btn btn-primary">성적 그래프 보기</button>
		<button id="btnoff" type="button" onclick="percentageBtnOff()" style="display: none;" class="btn btn-primary">성적 그래프 접기</button>
		
		<div id="percentage"></div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>

<script>
var list=${list};
var test='${clname}';
var clname=	test.replace(/,/gi,' ');
var num=${num};
	console.log(num);
	console.log(list);
	
	if(num==1){
		$("#clname").html("<b>"+clname+" -평균</b>");
		
		$("#selectTable").append("<tr>");
		$("#selectTable").append("<th class='tg-tns0'>강좌명</th>");
		$("#selectTable").append("<th class='tg-tns0'>회차</th>");
		$("#selectTable").append("<th class='tg-tns0'>등수</th>");
		$("#selectTable").append("<th class='tg-tns0'>점수</th>");
		$("#selectTable").append("<th class='tg-tns0'>학생아이디</th>");
		$("#selectTable").append("</tr>");
		for(var i=0; i<list.length; i++){
			$("#selectTable").append("<tr>");
			$("#selectTable").append("<td class='tg-g9xd'>"+list[i].co_name+"</td>");
			$("#selectTable").append("<td class='tg-dlxr'>"+list[i].gr_num+"</td>");
			$("#selectTable").append("<td class='tg-dlxr'>"+list[i].ranking+"</td>");
			$("#selectTable").append("<td class='tg-dlxr'>"+list[i].gr_score+"</td>");
			$("#selectTable").append("<td class='tg-dlxr'>"+list[i].gr_id1+"</td>");
			$("#selectTable").append("</tr>");
		}
		
	}else{
		$("#clname").html("<b>"+clname+" -평균</b>");
		
		$("#selectTable").append("<tr>");
		$("#selectTable").append("<th class='tg-tns0'>강좌명</th>");
		$("#selectTable").append("<th class='tg-tns0'>회차</th>");
		$("#selectTable").append("<th class='tg-tns0'>등수</th>");
		$("#selectTable").append("<th class='tg-tns0'>점수</th>");
		$("#selectTable").append("<th class='tg-tns0'>학생아이디</th>");
		$("#selectTable").append("</tr>");
		
		alert("보여줄 정보가없습니다.");
	}
	
function percentageBtn() {
	$("#btnon").css("display","none");
	$("#btnoff").css("display","block");
	
	var maxcnt =list.length;
	var Arr1 =new Array(maxcnt+1);
	var Arr2 =new Array(maxcnt+1);
	var cnt1 =0;
	var cnt2 =0;
	var max =0;
	
 	for(var i=0; i<maxcnt;i++){
 		max += list[i].gr_score;
 		
 		window['stud'+i] = list[i].gr_id1;
 		window['score'+i] = list[i].gr_score;
 		
 		Arr1[i]= eval("stud"+i);
 		Arr2[i]= eval("score"+i);
	}
 	avg=max/maxcnt;
 	
  	for(var i=maxcnt; i<maxcnt+1;i++){
 		console.log("들어오냐");
  		window['stud'+i] = "총평균";
 		window['score'+i] = avg.toFixed(1);
 		
 		Arr1[i]= eval("stud"+i);
 		Arr2[i]= eval("score"+i);
 	} 
  	
 	console.log(max/9);
 	console.log(Arr1);
 	console.log(Arr2);
  	var arr=new Array(1);
 	for(var i=0; i<arr.length;i++){
 		arr[i]=new Array(maxcnt+2);
 		arr[0][0] = ["학생","점수",{ role: 'style' }];
 			for(var j=1; j<arr[0].length; j++){
 					console.log("j는?  :"+j);
 				if(j!=arr[0].length-1){
 					console.log("왜?  :");
 					arr[i][j]= [Arr1[cnt1++] ,Arr2[cnt2++], '#b87333'];
 				}else{
 					console.log("들어옴?  :"+j);
 					arr[i][j]= [Arr1[cnt1++] ,Arr2[cnt2++], '#662500'];
 				}
 			}
 			
 	} 

 	console.log(arr);
 	
 	var jsonStr =JSON.stringify(  arr[0] );
 	console.log(jsonStr);
 	
	$.ajax({
		type:'get',
		url:'rest/avgPercentage',
		data:{avg:jsonStr},
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
			$("#percentage").html(data);
			$('#percentage').append("<input type='hidden' id='token'  data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />");
		},
		error: function (err) {
			console.log(err);
		}
		
 	});  
 	
}

function percentageBtnOff() {
	$("#btnon").css("display","block");
	$("#btnoff").css("display","none");
	$("#percentage").html("");
}		
</script>
</body>
</html>