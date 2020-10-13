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
<title>Insert title here</title>
</head>
<body>
<input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<div id="avgPercentage"></div>

<script>
google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);

var avg = '${avg}';
var	avg1= avg.replace(/&quot;/gi, '"');
	avg2= JSON.parse(avg1); 
	
function drawChart() {
	  var data1 = google.visualization.arrayToDataTable(avg2);
	  var options1 = {  title: '반평균 통계 (단위: 점수)', height: 500, legend: { position: "none" } };
	  var chart1 = new google.visualization.ColumnChart(document.querySelector("#avgPercentage"));
		  chart1.draw(data1, options1);
}
</script>
</body>
</html>