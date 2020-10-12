<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.sectionImg {
	width: 200px;
	height: 150px;
	margin: 0 10px;
}

.sectionImgSpan {
	margin: 0 0 0 5px;
}

.boldHr {
	border: 2px solid skyblue;
	border-collapse: collapse;
}

.thinHr {
	border: 1px solid gray;
	border-collapse: collapse;
}
</style>
</head>
<body>
	<section>
		<hr class="boldHr">
		<h2>조회수 높은 강의</h2>
		<hr class="boldHr">
		<div>
		    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
			<ul>
				<li>
					<span class="sectionImgSpan"><img src="upload/java_video_capture_01.png" class="sectionImg"></span>
					<span class="sectionImgSpan"><img src="upload/java_video_capture_02.png" class="sectionImg"></span>
					<span class="sectionImgSpan"><img src="upload/java_video_capture_03.png" class="sectionImg"></span>
					<span class="sectionImgSpan"><img src="upload/java_video_capture_04.png" class="sectionImg"></span>
				</li>
			</ul>
		</div>
		<hr class="boldHr">
		<h2>강의 후기</h2>
		<hr class="boldHr">
		<hr class="thinHr">
		<p>실시간으로 질문을 받았던 것이 수강자와 소통하는 것 같아서 별풍선을 쏴드리고 싶었습니다.</p>
		<hr class="thinHr">
	</section>
</body>
</html>