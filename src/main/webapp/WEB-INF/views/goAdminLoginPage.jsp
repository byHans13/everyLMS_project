<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://d3js.org/d3.v4.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
</head>
<style>
.grid line {
    stroke: lightgrey;
    stroke-opacity: 0.7;
}
.lineChart {
    fill: none;
    stroke: steelblue;
    stroke-width: 1.5px;
}
.lineChart:hover {
    stroke: black;
    stroke-width: 3px;
}
.toolTip {
    position: absolute;
    border: 1px solid;
    border-radius: 4px 4px 4px 4px;
    background: rgba(0, 0, 0, 0.8);
    color : white;
    padding: 5px;
    text-align: center;
    font-size: 12px;
    min-width: 30px;
}
</style>
<body>
<script>
$(document).ready
(function() {
	
	console.log('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}');
	console.log('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}');
	//var aut =JSON.parse("${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}");
	var aut= '${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}';
	console.log(aut);
	var n = aut.indexOf("ROLE_PROF");
	console.log(n);

	 var id = "${id}";
	test(id);
});
</script>

<h1>adminLoginFrm</h1>
    <input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />
	<svg width="600" height="320"></svg>
	
	

</body>
<script>
function test() {
	$.ajax({
		type:'get',
		url:'rest/selectJoinMemberAdmin',
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
			console.dir(json.result);
			var dataset = json.result;
		 	console.log(typeof(dataset));
		 	console.log(Array.isArray(json.result));
			var series = ["최근 1년"];		 
		 	//dataset=JSON.parse(dataset);
		 	console.log(dataset);
		    var obj=[];
		    obj[0]=dataset;
		    var keys = d3.keys(obj[0]);
		    console.log(dataset);
		    console.log("hanseugn");
		    console.log(keys);
		    var data = [];
		 
		    Array.from(obj).forEach(function(d, i) {
		    data[i] = keys.map(function(key) { return {x: key, y: d[key]}; })
		    	console.log("아뵤");
		        console.log(d);
		        console.log("hans");
		        console.log(i);
		    console.log(data[i]);
		    });
		 
		    var margin = {left: 20, top: 10, right: 10, bottom: 20};
		    var svg = d3.select("svg");
		    console.log(svg);
		    var width  = parseInt(svg.style("width"), 10) - margin.left - margin.right;
		    var height = parseInt(svg.style("height"), 10)- margin.top  - margin.bottom;
		    var svgG = svg.append("g")
		        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
		    var xScale = d3.scalePoint()//scaleBand() scaleOrdinal
		        .domain(keys)
		        .rangeRound([0, width]);
		    var yScale = d3.scaleLinear()
		        .domain([0, d3.max(obj, function(d) { return d3.max(keys, function(key) { return d[key];});})])
		        .nice()
		        .range([height, 0]);
		    var colors = d3.scaleOrdinal(d3.schemeCategory10);
		 
		    svgG.append("g")
		        .attr("class", "grid")
		        .attr("transform", "translate(0," + height + ")")
		        .call(d3.axisBottom(xScale)
		            .tickSize(-height)
		        );
		 
		    svgG.append("g")
		        .attr("class", "grid")
		        .call(d3.axisLeft(yScale)
		            .ticks(5)
		            .tickSize(-width)
		           );
		 
		    var line = d3.line()
		        //.curve(d3.curveBasis)
		        .x(function(d) { return xScale(d.x); })
		        .y(function(d) { return yScale(d.y); });
		    
		    var lineG = svgG.append("g")
		        .selectAll("g")
		        .data(data)
		           .enter().append("g");
		 
		    lineG.append("path")
		        .attr("class", "lineChart")
		        .style("stroke", function(d, i) { return colors( series[i]); })
		        .attr("d", function(d, i) {return line(d); });
		 
		    lineG.selectAll("dot")
		        .data(function(d) {return d })
		        .enter().append("circle")
		            .attr("r", 3)
		            .attr("cx", function(d) { return xScale(d.x) })
		            .attr("cy", function(d) { return yScale(d.y);})
		            .on("mouseover", function() { tooltip.style("display", null); })
		            .on("mouseout",  function() { tooltip.style("display", "none"); })
		            .on("mousemove", function(d) {
		                tooltip.style("left", (d3.event.pageX+10)+"px");
		                tooltip.style("top",  (d3.event.pageY-10)+"px");
		                tooltip.html("month. " + d.x + "<br/>" + "data value : " + d.y);
		            });


		    var tooltip = d3.select("body")
		        .append("div")
		        .attr("class", "toolTip")
		        .style("display", "none");
		 
		    var legend = svgG.append("g")
		        .attr("text-anchor", "end")
		        .selectAll("g")
		        .data(series)
		        .enter().append("g")
		        .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });
		 
		    legend.append("rect")
		          .attr("x", width - 20)
		          .attr("width", 19)
		          .attr("height", 19)
		          .attr("fill", colors);
		 
		      legend.append("text")
		          .attr("x", width - 30)
		          .attr("y", 9.5)
		          .attr("dy", "0.32em")
		          .text(function(d) { return d; });			
		},
		error: function (err) {
			console.log(err);
		}
		
	});
} 
</script>
</html>