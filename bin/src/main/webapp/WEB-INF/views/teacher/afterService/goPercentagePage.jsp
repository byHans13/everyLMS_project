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
<div id="choesPercentage"></div>
<div id="answerPercentage"></div>
<script>
google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart1);
google.setOnLoadCallback(drawChart2);

var choice = '${choice}';
var choice1 = choice.replace(/&quot;/gi, '"');
var	choice2= JSON.parse(choice1);
var answer = '${answer}';
var answer1 = answer.replace(/&quot;/gi, '"');
var	answer2= JSON.parse(answer1);
/* var json = JSON.parse(test);  */ 

   	  function drawChart1() {
			var dataVis = google.visualization.arrayToDataTable(choice2);
			var options = {title: "정답 선택비율 보기", width: 500, height: 500 };
			var chart = new google.visualization.PieChart(document.getElementById("choesPercentage"));
				chart.draw(dataVis, options);
   	  }	  
	  
	  function drawChart2() {
		  var data1 = google.visualization.arrayToDataTable(answer2);
		  var options1 = {  title: '성적통계 (단위: %)', width: 500, height: 500 };
		  var chart1 = new google.visualization.ColumnChart(document.querySelector("#answerPercentage"));
			  chart1.draw(data1, options1);
	  }
	 
</script>
</body>
</html>