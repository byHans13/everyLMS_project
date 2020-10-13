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
table.type07 {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    border: 1px solid #ccc;
    margin: 20px 10px;
}
table.type07 thead {
    border-right: 1px solid #ccc;
    border-left: 1px solid #ccc;
    background: #e7708d;
}
table.type07 thead th {
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
}
table.type07 tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #fcf1f4;
}
table.type07 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
table.type07 a{text-decoration: none; 
 color: #333333;}
</style>
</head>
<body>
<header>
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
<div id='st'>
<input type='hidden' id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>

</div>
</section>
<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>



<script>


var hwResultList = ${hwResultList};
console.dir(hwResultList);
if(hwResultList.length!=0){

	 $('#st').append("<table class='type07'><thead><tr><th id='stId'></th><th>내용</th></tr></thead>"+
	    		"<tbody><tr><th>강좌회차</th><td id='stNum'></td></tr><tr><th>제출날짜</th><td id='stDate'></td></tr>"+
	    		"<tr><th>과제제목</th><td id='stName'></td></tr><tr><th>과제파일<br>(다운로드)</th><td id='stFl'></td></tr>"+
	    		"<tr><th>과제결과</th><td id='stResult'></td></tr></tbody></table>");	
	
}
$('#stId').text(hwResultList[0].hw_id+"님의 과제");
$('#stNum').text(hwResultList[0].hw_num+"강");
$('#stDate').text(hwResultList[0].hw_date);
$('#stName').text(hwResultList[0].hw_hwname);
$('#stFl').html("<a href='/h2k5every/stud/homeworkFiledown?sysFileName="+hwResultList[0].fbList[0].fl_sysname+"'>"+hwResultList[0].fbList[0].fl_oriname+"다운로드</a>");
switch (hwResultList[0].hw_psfa) {
case "P" :
	$('#stResult').html("PASS    <button type='button' id='reBnt' value='pass'>수정하기</button>");
	break;
case "p" :
	$('#stResult').html("PASS    <button type='button' id='reBnt' value='pass'>수정하기</button>");
	break;
case "F":
	$('#stResult').html("FAIL    <button type='button' id='reBnt' value='fail'>수정하기</button>");
	break;
case "f":
	$('#stResult').html("FAIL    <button type='button' id='reBnt' value='fail'>수정하기</button>");
	break;

}
$('#reBnt').click(function() {
	$('#stResult').html("");
	$('#stResult').html("<input type='radio' name='aa' value='f'>FAIL<input type='radio' name='aa' value='p'>PASS     <button type='button' onclick='goUpdate()'>수정</button>");
	//$(this).attr('value')
});



	function goUpdate() {
		var pafa = $("input:radio[name=aa]:checked").val();
			//document.getElementsByName('aa').values;
		//console.log(pafa);
		$.ajax({
			url:'rest/updateStHw?id='+hwResultList[0].hw_id+'&num='+hwResultList[0].hw_num+'&pafa='+pafa+'&idnum='+hwResultList[0].hw_idnum+'&lv='+hwResultList[0].hw_lv,
			type:'GET',
			//async: false,
			dataType: 'json',
			beforeSend : function(xhr)
			{
				//이거 안하면 403 error
				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
			success: function(result) {
				console.log(result);
				switch (result) {
				case true:
					alert("수정되었습니다.");
					//history.go(-1);
					location.href='/h2k5every/prof/selectmanagercoursehomeworkpage/'+hwResultList[0].hw_idnum;
					break;
				default:
					alert("수정과정에서 문제 발생");
					//history.go(-1);
					location.href='/h2k5every/prof/selectmanagercoursehomeworkpage';
					break;
				}
				
			},
			error: function(err) {
				console.log(err)
				
			}
		});
	}
	





</script>

</body>
</html>