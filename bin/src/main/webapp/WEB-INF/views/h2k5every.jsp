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
	src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css" />
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>

<!-- css -->
<link href="/h2k5every/css/main.css" rel="stylesheet" type="text/css"
	media="all" />

<title>H2K5에 오신것을 환영합니다.</title>
</head>
<body>
	<div class="floating" id="le">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">＜h2＞k5＜h2＞</a>
			</div>
			<ul class="nav navbar-nav navbar-left">
				<li><a onclick="fnMove('1')">img1로 이동</a></li>
				<li><a onclick="fnMove('2')">img2로 이동</a></li>
				<li><a onclick="fnMove('3')">img3로 이동</a></li>
				<li><a onclick="fnMove('4')">img4로 이동</a></li>
				<li><a onclick="fnMove('5')">img5로 이동</a></li>
				<li><a onclick="fnMove('6')">img6로 이동</a></li>
				<li><a onclick="fnMove('7')">img7로 이동</a></li>
			</ul>
		</div>
	</div>
	<div class="floating">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">＜h2＞k5＜h2＞</a>
			</div>
			<div class="container-fluid">
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
	<div id="main">
<!-- 		<div class="container1"> -->
<!-- 			<div id="div1" class="div"> -->
<!-- 				<img src="lms_main_imgFile/header_01.PNG"> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="container2"> -->
<!-- 			<div id="div2" class="div"> -->
<!-- 				<img src="lms_main_imgFile/dons_01.PNG"> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="container3"> -->
<!-- 			<div id="div3" class="div"> -->
<!-- 				<img src="lms_main_imgFile/hans_01.PNG"> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="container4"> -->
<!-- 			<div id="div4" class="div"> -->
<!-- 				<img src="lms_main_imgFile/sexydons.jpg"> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="container5"> -->
<!-- 			<div id="div5" class="div"> -->
<!-- 				<img src="lms_main_imgFile/dog.jpg"> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="container6"> -->
<!-- 			<div id="div6" class="div"> -->
<!-- 				<img src="lms_main_imgFile/hans_01.PNG"> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="container7"> -->
<!-- 			<div id="div7" class="div"> -->
<!-- 				<img src="lms_main_imgFile/dons_01.PNG"> -->
<!-- 			</div> -->
<!-- 		</div> -->

		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">

				<div class="item active">
					<div class="container1">
						<div id="div1" class="div">
							<img src="lms_main_imgFile/header_01.PNG">
						</div>
					</div>
					<div class="container2">
						<div id="div2" class="div">
							<img src="lms_main_imgFile/dons_01.PNG">
						</div>
					</div>
					<div class="container3">
						<div id="div3" class="div">
							<img src="lms_main_imgFile/hans_01.PNG">
						</div>
					</div>
				</div>

				<div class="item">
					<div class="container4">
						<div id="div4" class="div">
							<img src="lms_main_imgFile/sexydons.jpg">
						</div>
					</div>
					<div class="container5">
						<div id="div5" class="div">
							<img src="lms_main_imgFile/dog.jpg">
						</div>
					</div>
				</div>
				<div class="item">
					<div class="container6">
						<div id="div6" class="div">
							<img src="lms_main_imgFile/hans_01.PNG">
						</div>
					</div>
					<div class="container7">
						<div id="div7" class="div">
							<img src="lms_main_imgFile/dons_01.PNG">
						</div>
					</div>
				</div>
				<div class="item">
					<div class="container6">
						<div id="div6" class="div">
							<img src="lms_main_imgFile/hans_01.PNG">
						</div>
					</div>
					<div class="container7">
						<div id="div7" class="div">
							<img src="lms_main_imgFile/dons_01.PNG">
						</div>
					</div>
				</div>

			</div>
			<!-- Left and right controls -->
			<a class="left carousel-control" href="#myCarousel" role="button"
				data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel" role="button"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>
</body>
<script>
	function fnMove(seq) {
		var offset = $("#div" + seq).offset();
		$('html, body').animate({
			scrollTop : offset.top
		}, 400);
	}
</script>
</html>








