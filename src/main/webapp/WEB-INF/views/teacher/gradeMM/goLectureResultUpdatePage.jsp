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
 	/* border: 1px solid black;  */
	border-collapse: collapse;
	text-align: center;
}
th, td {
	font-size: 30px;
	/* border: 1px solid black; */
}
td{
	/*  border: 1px solid black;  */
	height: 60px;
}
.b{
	font-size: 30px;
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
	
	<div style="height: 50px;"></div>
	
	<section id="section" style="margin-left: 20px;">
		<div style="background-color: #B7F0B1; height: 80px; ">
		<div style="height: 5px;"></div>
			<h1 id="cmt"></h1>
			<p id="studid"></p>
		</div>
		<div style="height: 50px;"></div>
		<div style="width: 1000px; height: 100px; border: 1px solid black; overflow: auto;">
			<div style="width: 120px ; height: 98px; float: left;">
				<div style="width: 118px;height: 2px;"></div>
				<b style="font-size: 24px;">&nbsp;문제번호 : </b>
			</div>
			<div id="pbnum" style="width: 758px ; height: 98px; float: left;">
				<!-- <div style="width: 75px; text-align: center; float: left;"><b class="b">1</b></div> -->
			</div>
			<div style="width: 120px ; height: 98px; float: left;"></div>
		</div>
		<form action="LectureResultUpdate" method="post">		
			<div style="height: 50px;"></div>
	<div style="width: 500px; display: inline-block;">	
		<div id="pbview" style=" display: none; ">
			<div id="pbbox">
				
			</div><div id="percentage" style="float: left; display: none;"></div>
		</div>

		<br><br>
			<div id="pbview2" style="display: none;">
		</div>
	</div>
	<div style="display: inline-block;">
		<div id="Bnt" style="display: none; display: inline;">	
			<div id="LRbtn" style="display: inline;"></div>
		</div>
	</div>
	</form>
	</section>
		
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>

<script>
var qlist= ${qlist};
var dtlist= ${dtlist};
var cl_clname='${cl_clname}';
var co_name='${co_name}';
var pbmaxnum= qlist.length;
var dtmaxnum= dtlist.length;
console.log(qlist);
console.log(dtlist);

if(qlist[0].pb_pbchkqz==0){
	$("#cmt").html(cl_clname+"  - "+co_name+" 시험문제");
}else{
	$("#cmt").html(cl_clname+"  - "+co_name+"   "+qlist[0].pb_num+""+"회차 퀴즈문제");
}
	$("#studid").html("<h3>학생 아이디   :  "+qlist[0].pb_id+"</h3>");
	
for(var i=0; i<pbmaxnum; i++){
	 $("#pbnum").append("<div style='width: 75px; text-align: center; float: left;'>"+
				"<button type='button' onclick='pbnumclick("+i+")'><b class='b'>"+(i+1)+"</b></button></div>");
}

	
	function pbnumclick(a) {
		$("#pbview").css("display","block");
		$("#LRbtn").html("");
		$("#pbbox").html("");
		$("#pbview2").html("");
		$("#pbview2").css("display","block");
		
		if((a+1)==pbmaxnum){
			$("#LRbtn").html("");
			$("#nextbtn").css("display","none");
			$("#LRbtn").append("<button id='gobackbtn' type='button' class='btn btn-primary' onclick='pbnumclick("+(a-1)+")'>이전</button>");		
		}
		else if(a==0){
			$("#LRbtn").html("");						
			$("#gobackbtn").css("display","none");						
			$("#LRbtn").append("<button id='nextbtn' type='button' class='btn btn-primary' onclick='pbnumclick("+(a+1)+")'>다음</button>");		
		}else if(a!=0 && (a+1)!=pbmaxnum){
			$("#LRbtn").html("");
			$("#LRbtn").append("<button id='gobackbtn' type='button' class='btn btn-primary' onclick='pbnumclick("+(a-1)+")'>이전</button>");
			$("#LRbtn").append("<button id='nextbtn' type='button' class='btn btn-primary' onclick='pbnumclick("+(a+1)+")'>다음</button>");
		}
		
		var cnt =a+1; 
		
		var clname= cl_clname.replace(/ /gi,',');
		var name= co_name.replace(/ /gi,',');
		
		console.log("a의 값 :"+a);
		console.log("문제지문 :"+qlist[a].pb_pbname);				
		$("#pbbox").append("<h1>"+qlist[a].pb_pbname+"</h1><br><br>");
		console.log("학생답 :"+qlist[a].pb_pbstudent);
		console.log("문제답 :"+qlist[a].pb_pbexplain);
		$("#pbview2").append("<h1>학생답 : "+qlist[a].pb_pbstudent+"</h1>");
		$("#pbview2").append("<h1>정답 : "+qlist[a].pb_pbexplain+"</h1>");
		$("#LRbtn").append("<input type='hidden' name='cl_clname' value='"+clname+"'>");
		$("#LRbtn").append("<input type='hidden' name='co_name' value='"+name+"'>");
		$("#LRbtn").append("<input type='hidden' name='gr_id1' value='"+qlist[a].pb_id+"'>");
		$("#LRbtn").append("<input type='hidden' name='cl_idnum' value='"+qlist[a].pb_idnum+"'>");
		$("#LRbtn").append("<input type='hidden' name='pb_lv' value='"+qlist[a].pb_lv+"'>");
		$("#LRbtn").append("<input type='hidden' name='cl_lcnum' value='"+qlist[a].pb_num+"'>");
		$("#LRbtn").append("<input type='hidden' name='pb_pbnum' value='"+qlist[a].pb_pbnum+"'>");
		$("#LRbtn").append("<input type='hidden' name='pb_pbexplain' value='"+qlist[a].pb_pbexplain+"'>");
		$("#LRbtn").append("<input type='hidden' name='pb_pbchkqz' value='"+qlist[a].pb_pbchkqz+"'>");
		$("#LRbtn").append("<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />");
		var aa=1;
		for(var i=0; i<dtmaxnum;i++) {
			
			if(cnt==dtlist[i].dp_pbnum){
				console.log("문제번호 :"+dtlist[i].dp_pbnum);
				console.log("문제보기번호 :"+dtlist[i].dp_pbexmnum);
				console.log("문제보기 :"+dtlist[i].dp_pbexm);
				$("#pbbox").append("<input style='display: inline-block;' type='radio' name='pb_pbstudent' value="+(aa++)+">&nbsp&nbsp&nbsp<h2 style='display: inline-block;'>"+dtlist[i].dp_pbexmnum+".  "+dtlist[i].dp_pbexm+"</h2><br>");
				
			}
		}
			
		var pb_pbstudent=document.getElementsByName("pb_pbstudent");
		console.dir(pb_pbstudent);
		for(var i=0; i<pb_pbstudent.length;i++){
		console.dir(pb_pbstudent[i].defaultValue);
			
			if(pb_pbstudent[i].defaultValue==qlist[a].pb_pbstudent){
				pb_pbstudent[i].checked=true;
				}		
		}
		$("#LRbtn").append("&nbsp&nbsp&nbsp<button type='submit' class='btn btn-primary'>수정</button>");
		$("#Bnt").css("display","block");
	}
	
</script>
</body>
</html>





