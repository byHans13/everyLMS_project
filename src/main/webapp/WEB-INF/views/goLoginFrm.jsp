<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>

<title>Insert title here</title>
<style>
header {
	/* background-color: gray; */
}

aside {
	/* background-color: blue; */
	width: 300px;
	float: left;
	position: absolute;
	transform :translate(0px, 230px;)
}

section {
	/* background-color: pink; */
	width: 1000px;
	float: left;
	position: absolute;
	transform:translate(300px,0px); 
}
.menu{
    margin-left: 20px;
    text-align:center;
    width: 200px;
    border: 1px black solid;
    float: left;
}
fieldset{
	border: solid black;

}
</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<body>
  <input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
<script>
 $(document).ready
(function() {
	 var id = "${id}";
	test(id);
	console.log('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}');
	console.log('${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}');
	//var aut =JSON.parse("${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}");
	var aut= "${aut}";
	console.log(aut);
	var n = aut.indexOf("ROLE_PROF");
	console.log("권한체크",n);
	var profCheck ="${profCheck}";
	console.log(profCheck);
	 console.log("hansnq3"+id);
	 var obj = {"cc_id": id};
	 console.log("hansObj",obj);
		/* $.ajax({
			type:'get',
			url:'rest/selectmainstudentview',
			data : obj,
			datatype:'json',
			success: function (json) {
				console.log(json);
				console.log(json.length);
			for(var j=0; j<6;i++){
				for(var i=0; i<6;i++){
				var str="<tr>";
				if(i%3!=0){
				str +="<td><img class='detailLecture' src=\"../picture/"+json[i].pi_pisysname+"\"></td>";
				}else{
					str +="</tr><tr><td><img class='detailLecture' src=\"../picture/"+json[i].pi_pisysname+"\"></td>";
				}
				}
		              		 
			}
				str += "</tr>";
				$("#rcmLecture").html(str);
			},
			error: function (err) {
				console.log(err);
			}
			
		}); */
	 
	 
}); 
</script>
	<header>
		<%-- <%@ include file="h2k5every_header.jsp"%><!-- 정적인 방식 --> --%>
		<jsp:include page="h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="h2k5every_aside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
			<fieldset>
			<legend id="recomendLecture">
			<h3> 
			<b>추천강의</b>
			</h3>
			</legend>
			<div>
			<table><tbody id="rcmLecture">
			
			
			
			</tbody>
	        
	        
	        </table>
			
			</div>
			</fieldset>
			<div id="menu"><h3><b>관심사</b></h3></div>
			
	</section>
	<footer>
		<jsp:include page="h2k5every_footer.jsp" />
	</footer>
		
<script>
function test(id) {
	$.ajax({
		type:'get',
		url:'rest/selectConcern',
		datatype:'json',
		success: function (json) {
			console.log(json);
			console.log(json.length);
		
			for(var i=0; i<json.length; i++){
				$('#menu').append("<div class='menu'><p>"+json[i]+"</p></div>");
			}
			
		},
		error: function (err) {
			console.log(err);
		}
		
	});
} 
</script>

</body>
</html>