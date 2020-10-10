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
	<link href="css/main.css" rel="stylesheet" type="text/css">
	 <script src="js/main.js" type="text/javascript" defer="defer"></script>
<title>H2K5에 오신것을 환영합니다.</title>
<style>
#container {
	float: left;
	background-color: blue;
	width: 1000px;
	height: 10000px;
}

.section {
	width: 998px;
	height: 9998px;
	background-color: pink;
}

.container {
	background-color: red;
}

.img {
	margin: 0px auto;
}

.floating {
	position: fixed;
	right: 50%;
	top: 180px;
	margin-right: -800px;
	text-align: center;
	width: 200px;
	background-color: skyblue;
}
</style>
</head>
<body>
  <div class="slide">
      <ul class="imgSlide">
        <li><img alt="H2K5 메인" src="lms_main_imgFile/header_01.PNG" class="img"></li>
        <li><img alt="dons" src="lms_main_imgFile/dons_01.PNG" class="img"></li>
        <li><img alt="hans" src="lms_main_imgFile/hans_01.PNG" class="img"></li>
      </ul>
      <div class="moveBtn">
        <a href="#" class="pre">
          < </a>
            <a href="#" class="next"> > </a>
      </div>
    </div>
<!-- 	<div id="container"> -->
<!-- 		<div class="section"> -->
<!-- 			<div class="container"> -->
<!-- 				<img alt="H2K5 메인" src="lms_main_imgFile/header_01.PNG" class="img"> -->
<!-- 			</div> -->
<!-- 			<div class="container"> -->
<!-- 				<img alt="dons" src="lms_main_imgFile/dons_01.PNG" class="img"> -->
<!-- 			</div> -->
<!-- 			<div class="container"> -->
<!-- 				<img alt="hans" src="lms_main_imgFile/hans_01.PNG" class="img"> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<div class="floating">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">＜h2＞k5＜h2＞</a>
			</div>
			<ul class="nav navbar-nav">
				<li class="active"><a href="#">Main</a><br></li>
				<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">강의관리<!-- <span class="caret"></span> --><br></a></li>
				<li><a href="#">성적 관리</a></li>
				<li><a href="#">FeedBack 관리</a></li>
			</ul>
			<div class="container-fluid">
				<!-- <form class="navbar-form navbar-left" action="#">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Search">
					</div>
						<button type="submit" class="btn btn-default">검색</button>
				</form> -->
				<ul class="nav navbar-nav navbar-right">
					<li><a href="gologinpage"><span
							class="glyphicon glyphicon-log-in"></span>로그인</a></li>
					<li><a href="gomemberjoinpage"><span
							class="glyphicon glyphicon-user"></span>회원가입</a></li>
					<li><a href="goSearchIdPwPage"><span></span>ID/PW 찾기</a></li>
					<li><a href="#"><span></span>고객센터</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>








