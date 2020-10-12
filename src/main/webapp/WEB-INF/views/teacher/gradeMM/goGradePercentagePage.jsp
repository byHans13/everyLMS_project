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
	width: 1200px; 
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
			<h2 style="float: left; margin-left: 10px;margin-top: 15px;color: white; font-size: 35px;"><b>성적 백분율 페이지</b></h2>
			<button style="float: right; margin-right: 20px; margin-top: 30px; height: 30px;" 
					type="button" onclick="contSelect()">검색</button>
			<input style="float: right; height: 30px; margin-top: 30px;" type="text" name="cont"/> 
			<select style="float: right; height: 30px; margin-top: 30px;" name="box2">
				<option value="0">전체검색</option>
				<option value="1">강의명</option>
				<option value="2">강좌명</option>
			</select>
		</div>
	</form>
	<div style="height: 100px;"></div>	
		
		<div style="overflow: auto; height: 500px;" >
			<h2 id="selectbox"></h2><br>
			<table id="selectTable" class="tg" style="width: 1200px;">
			</table>
		</div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
<script>
var glist= ${glist};
	console.log(glist);
	console.log(glist.length);
	
	if(glist.length==0){
		$("#selectbox").html("시험을 본 학생이 없습니다.");
	}else{
		$("#selectTable").append("<tr>");
		$("#selectTable").append("<th class='tg-tns0'>강의명</th>");
		$("#selectTable").append("<th class='tg-tns0'>강좌명</th>");
		$("#selectTable").append("<th class='tg-tns0'>회차</th>");
		$("#selectTable").append("<th class='tg-tns0'>학생수</th>");
		$("#selectTable").append("<th class='tg-tns0'>교수명</th>");
		$("#selectTable").append("<th class='tg-tns0'>상세보기</th>");
		$("#selectTable").append("</tr>");
		
	 	for(var i=0; i<glist.length; i++){
			var test = glist[i].cl_clname;
			console.log(test);
			var clname = test.replace(/ /gi,',');
			console.log(clname);
			var test2 = glist[i].co_name;
			console.log(test);
			var co_name = test2.replace(/ /gi,',');
			console.log(co_name);
	 		
			$("#selectTable").append("<tr>");
			$("#selectTable").append("<td class='tg-g9xd'>"+glist[i].cl_clname+"</td>");
			$("#selectTable").append("<td class='tg-dlxr'>"+glist[i].co_name+"</td>");
			$("#selectTable").append("<td class='tg-dlxr'>"+glist[i].co_num+"</td>");
			$("#selectTable").append("<td class='tg-dlxr'"+glist[i].gr_id+"</td>");
			$("#selectTable").append("<td class='tg-dlxr'>"+glist[i].cl_id+"</td>");
			$("#selectTable").append("<td class='tg-dlxr'> <form action='goGradePercentageShowPage' method='post'>"+
					"<input type='hidden' name='cl_clname' value="+clname+">"+
					"<input type='hidden' name='co_name' value="+co_name+">"+
					"<input type='hidden' name='co_num' value="+glist[i].co_num+">"+
					"<input type='hidden' name='cl_idnum' value="+glist[i].cl_idnum+">"+
					"<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />"+
					"<button class='btn btn-primary'>클릭</button></form></td>");
			$("#selectTable").append("</tr>");
		} 
		
	</script>
	</body>
	</html>