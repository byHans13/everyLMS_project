<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title here</title>
</head>
<body>
<input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<div id="avgPercentage"></div>

<script>
google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);

var avg = ${avg};

function drawChart() {
	  var data1 = google.visualization.arrayToDataTable(avg);
	  var options1 = {  title: '반평균 통계 (단위: 점수)', height: 500, legend: { position: "none" } };
	  var chart1 = new google.visualization.ColumnChart(document.querySelector("#avgPercentage"));
		  chart1.draw(data1, options1);
}
</script>
</body>
</html>