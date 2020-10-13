<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<div id="grade1Percentage" style="display: inline-block;"></div>
<div id="grade2Percentage" style="display: inline-block;"></div>
<script>
google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart1);
google.setOnLoadCallback(drawChart2);

var grade2 = '${grade2}';
var PieChart1 = grade2.replace(/&quot;/gi, '"');
var	Pie1= JSON.parse(PieChart1);
var grade1 = '${grade1}';
var ColumnChart1 = grade1.replace(/&quot;/gi, '"');
var	Column1= JSON.parse(ColumnChart1);
/* var json = JSON.parse(test);  */ 

   	  function drawChart1() {
			var dataVis = google.visualization.arrayToDataTable(Pie1);
			var options = {title: "성적 PieChart", width: 700, height: 600 };
			var chart = new google.visualization.PieChart(document.getElementById("grade2Percentage"));
				chart.draw(dataVis, options);
   	  }	  
	  
	  function drawChart2() {
		  var data1 = google.visualization.arrayToDataTable(Column1);
		  var options1 = {  title: '성적 ColumnChart (단위:점수)', width: 500, height: 600, legend: { position: "none" }};
		  var chart1 = new google.visualization.ColumnChart(document.querySelector("#grade1Percentage"));
			  chart1.draw(data1, options1);
	  }
	 
</script>
</body>
</html>