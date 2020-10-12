<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<h1>강의</h1>

	<h2>업로드한 강의보기</h2>
	<div id="selCo"></div>
	<h2 id='goCo'>강의쓰러가기</h2>
	<div id="inCo"></div>
	
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>

	<p id='result' style="color: red"></p>
	<div id='goHome'></div>

	<script>
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
											$('#selCo').append("<a href='selectCoursePage/"+co_idnum + "/"+arr[z] + "'>"+arr[z]+"의 강좌보기</a><br>");
											num=arr[z];
										}
									}
									if(num!=j){
										number = 1;
									$('#inCo').append("<a href='insertcoursePage/"+ co_idnum + "/" + j + "'>" + j + "의 강좌쓰러가기</a><br>");
									}
								}
								
							} 
				 		if (myCourseNum.length == 0) {
								$('#selCo').append("<p style='color: red;'>업로드한 강의가 없습니다.</p>");
								for (i = 1; i < co_sum + 1; i++) {
									number = 1;
									$('#inCo').append("<a href='insertcoursePage/"+ co_idnum + "/" + i+ "'>" + i+ "의 강좌쓰러가기</a><br>");
								}
							}
							if (number == 0) {
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