<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<header>
		<a href="#"><img src="upload/h2k5_mainLogo.PNG" id="mainlogo" width="200"></a>
	</header>
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">＜h2＞k5＜h2＞</a>
			</div>
			<ul class="nav navbar-nav">
				<li class="active"><a href="#">Main</a></li>
				<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">강의관리</a>
				<li><a href="#">성적 관리</a></li>
				<li><a href="#">FeedBack 관리</a></li>
			</ul>
			<div class="container">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="gologinpage"><span class="glyphicon glyphicon-log-in"></span>로그인</a></li>
					<li><a href="gomemberjoinpage"><span class="glyphicon glyphicon-user"></span>회원가입</a></li>
					<li><a href="goSearchIdPwPage"><span></span>ID/PW 찾기</a></li>
					<li><a href="#"><span></span>고객센터</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<script>

	function upDateSt(msg_id){
	$.ajax({
					url:'/h2k5every/stud/rest/upDateSt?msg_id='+msg_id,
					type:'GET',
					dataType: 'json',
					beforeSend : function(xhr){
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token.val());
						},
					success: function(result) {
					alert('해당 쪽지가 읽음 처리되었습니다.'');

							
					},
						error: function(err) {
						console.log(err)
				
						}
					
					});
	}
	</script>
</body>
</html>

