<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<style>
a:link {
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: underline;
}

.asideMenu {
	height: auto;
}

input[id*="my"] {
	/*  */
	display: none;
}

input[id*="my"]+label {
	display: block;
	padding: 20px;
	border: 1px solid black;
	border-bottom: 0px;
	color: #fff;
	font-weight: 900;
	background: black;
	cursor: pointer;
}

input[id*='my']+label+div {
	max-height: 0;
	transition: all .35s;
	overflow: hidden;
	background: #ebf8ff;
	font-size: 11px;
}

input[id*='my']+label+div p {
	display: inline-block;
}

input[id*='my']:checked+label+div {
	max-height: 800px;
}

input[class*='myClassCheckbox']+label {
	background: rgb(66, 65, 65);
}
</style>

</head>
<script type="text/javascript">
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
 console.log("hansnq3"+id);
if (n != -1){
	$("#goTeacherPage").append("<p style='margin-top: auto;'><b><a href='/h2k5every/prof/goTeacherLoginFrm' style='color: black; '>강사페이지이동</a></b></p>");
}
});
</script>

<body>
	<div class='asideMenu'>
		<input type='radio' name='asideMenu' id='myMenu'> <label
			for='myMenu'>회원관리</label>
		<div>
			<div>
				<p>
					<a href='selectintroductionteacherconfirm'>강사 관리</a>
				</p>
			</div>
			<div>
				<p>
					<a href='#'>블랙 리스트 관리</a>
				</p>
			</div>
		</div>

		<input type='radio' name='asideMenu' id='myGradeManagement'> <label
			for='myGradeManagement'>강의관리</label>
		<div>
			<div>
				<p>
					<a href='selectlectureconfirm'>강의 등록 관리</a>
				</p>
			</div>
		</div>
		<div>
			<input type='checkbox' class='myClassCheckbox' name='asideMenu'
				id='myClassManagement' onclick="checkboxChecked(1)"> <label
				for='myClassManagement'>공지관리</label>
			<div>
				<div>
					<p>
						<a href='#'>공지 관리</a>
					</p>
				</div>

			</div>
			<div id="goTeacherPage"></div>
			<input type='checkbox' class='myClassCheckbox' name='asideMenu'
				id='mySuggestClass' onclick="checkboxChecked(2)">
			<script>
				var classManage = document.getElementById("myClassManagement");
				var suggestClass = document.getElementById("mySuggestClass");
				var myTest = document.getElementById("myTestAndAssign");
				function checkboxChecked(i) {

					if (i == 1) {
						suggestClass.checked = false;
						myTest.checked = false;
					} else if (i == 2) {
						classManage.checked = false;
						myTest.checked = false;
					} else if (i == 3) {
						classManage.checked = false;
						suggestClass.checked = false;
					}
				}
			</script>
</body>
</html>





