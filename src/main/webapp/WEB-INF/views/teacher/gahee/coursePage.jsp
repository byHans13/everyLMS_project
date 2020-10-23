<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<style>
table,th,td{
border: 1px solid black;
border-collapse: collapse;
}

html, body {
   height: 100%;
   margin: 0
}

#articleView_layer {
   display: none;
   position: fixed;
   position: absolute;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%
}

#articleView_layer.open {
   display: block;
   color: red;
}

#articleView_layer #bg_layer {
   position: absolute;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background: #000;
   opacity: .5;
   filter: alpha(opacity = 50);
   z-index: 100
}

#contents_layer {
   position: absolute;
   top: 40%;
   left: 40%;
   width: 400px;
   height: 400px;
   margin: -150px 0 0 -194px;
   padding: 28px 28px 0 28px;
   border: 2px solid #555;
   background: #fff;
   font-size: 12px;
   z-index: 200;
   color: #767676;
   line-height: normal;
   white-space: normal;
   overflow: scroll
}
html, body {
   height: 100%;
   margin: 0
}
aside {
	width: 300px;
	float: left;
}
section {
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
table.type10 {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    margin: 20px 10px;
}
table.type10 thead th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
    background: #e7708d;
    margin: 20px 10px;
}
table.type10 tbody th {
    width: 150px;
    padding: 10px;
}
table.type10 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
}
table.type10 .even {
    background: #fdf3f5;
}
</style>
</head>
<body>
<header style="width: 1500px;">
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
	<center><h1 style="color: #e7708d;">나의 강좌</h1>

	<div id="selCo">
	<table class="type10">
    <thead>
    <tr>
        <th>강좌 회차</th>
        <th>업로드 강좌</th>
    </tr>
    </thead>
    <tbody> </tbody>
</table>
	</div>

	<div id="inCo">
		<table class="type10">
    <thead>
    <tr>
        <th >강좌 회차</th>
        <th>작성 할 강좌</th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
	</div>
	</center>
	
	
	
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>

	<p id='result' style="color: red"></p>
	<div id='goHome'></div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>

	<script>
	var msg = "${msg}";
	if(msg!=""){
		alert(msg);
	}
		var co_idnum = "${co_idnum}";
		var co_sumStr = "${co_lcnum}";
		var co_sum = parseInt(co_sumStr);

		if (co_idnum != "" || co_idnum != null) {
			$.ajax({
						url : 'rest/courseList?co_idnum=' + co_idnum,
						type : 'POST',
						dataType : 'json',
						beforeSend : function(xhr)
						{
							//이거 안하면 403 error
							//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
							var $token = $("#token");
							xhr.setRequestHeader($token.data("token-name"), $token.val());
						},
						success : function(myCourseNum) {
							var num=0;
							var number = 0;
							var arr = new Array();
							
				 		if(myCourseNum.length != 0){
				 			
								for(var i=0; i<myCourseNum.length; i++){
									arr[i] = myCourseNum[i].co_num;
								}
								
								for(var j=1; j<(co_sum+1); j++){
									for(var z=0; z<arr.length; z++){
										if(arr[z]==j){
											$('#selCo table tbody').append("<tr><th>"+arr[z]+"회차</th><td><a href='selectCoursePage/"+co_idnum + "/"+arr[z] + "'>확인하기</a></td></tr>");
											num=arr[z];
										}
									}
									if(num!=j){
										number = 1;
									$('#inCo table tbody').append("<tr><th>"+j+"회차</th><td><a href='insertcoursePage/"+ co_idnum + "/" + j + "'>강좌 작성</a></td></tr>");
									}
								}
								
							} 
				 		if (myCourseNum.length == 0) {
				 				$('#selco').empty();
								$('#selCo').append("<p style='color: red;'>업로드한 강의가 없습니다.</p>");
								for (i = 1; i < co_sum + 1; i++) {
									number = 1;
									$('#inCo table tbody').append("<tr><th>"+i+"회차</th><td><a href='insertcoursePage/"+ co_idnum + "/" + i+ "'>강좌 작성</a></td></tr>");
								}
							}else if (number == 0) {
								$('#goCo').text("");
								$('#inCo').after("<button type='button' onclick='go()'>관리자에게 보내기</button>");

							}

						},
						error : function(err) {
							console.log(err);
						}

					});
		}
		

		function go() {
			$.ajax({
				url : 'rest/goAdmin?co_idnum=' + co_idnum,
				type : 'POST',
				dataType : 'json',
				beforeSend : function(xhr)
				{
					//이거 안하면 403 error
					//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
					var $token = $("#token");
					xhr.setRequestHeader($token.data("token-name"), $token.val());
				},
				success : function(result) {
					console.log(result);
					$('#result').text(result);
					$('#goHome').append("<button><a href='gohome'>홈으로</a></button>");
				},
				error : function(err) {
					console.log(err);
				}

			});

		}
	</script>



</body>
</html>