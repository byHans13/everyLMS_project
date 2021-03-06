<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>퀴즈 자료 업로드</title>
<!-- LaTest compiled and minified CSS -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="../resources/js/jquery.serializeObject.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- LaTest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
</head>
<style>
.muSmall {
	width: 300px;
}
</style>
<body>
	<input type="hidden" id="token" data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" id="idnum" name="idnum" value="${muList[0].cl_idnum}">
	<input type="hidden" id="lv" name="lv" value="${muList[0].cl_lv}">
	<input type="hidden" id="conum" name="conum" value="conum">
	<div class="container" id="container">
	</div>

	<script>
	$.urlParam = function(name){
	    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
	    return results[1] || 0;
	}
	var cnt = 0;
	var idnum = $("#idnum").val();
	var lv = $("#lv").val();
	var conum = $.urlParam('co_num');
	console.log("일련번호 : "+ $("#idnum").val());
	console.log("레벨값 : " + $("#lv").val());
	console.log("conum = "+conum);
	$(document).ready(function(){
		var FormData = $('#insertQuizMaterialUploadFrm').serialize();
		$.ajax({
 			url: 'rest/insertquizmaterialuploadfrmajax?cl_idnum='+idnum+'&cl_lv='+lv+'&co_num='+conum,
			type: 'post',
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			data : FormData,
			dataType : 'json',
			beforeSend : function(xhr){
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			}, success: function(uploadInfo){
				console.log(uploadInfo);
				$("#container").html("<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name='${_csrf.parameterName}' value='${_csfr.token}' />");
				//$("#container").append("<form id='insertquizMaterialUploadFrm' action='insertquizmaterialupload?${_csrf.parameterName}=${_csrf.token}&cl_idnum='"+idnum+"'&cl_lv='"+lv+"' method='post' encType='multipart/form-data'>");
				$("#container").append("<form id='insertquizMaterialUploadFrm' action='insertquizmaterialupload?${_csrf.parameterName}=${_csrf.token}' method='post' encType='multipart/form-data'>");
				$("#insertquizMaterialUploadFrm").append("<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name='${_csrf.parameterName}' value='${_csfr.token}' />");
				$("#insertquizMaterialUploadFrm").append("<table id='quizMaterialUploadTable' class='table table-border'>");
				$("#quizMaterialUploadTable").append("<thead id='quizMaterialUploadThead'>");
				$("#quizMaterialUploadThead").append("<caption id='quizMaterialUploadCaption' style='width:500px;'>");
				$("#quizMaterialUploadCaption").append("<h2>퀴즈 자료 업로드</h2>");
				$("#quizMaterialUploadTable").append("<tr><td id='btnTd'>"
									 + "<input type='button' id='btnAdd' onclick='uploadAddClick()' value='퀴즈 추가'>"
									 /* + "<input type='button' id='btnCntAfter' onclick='cntAfter()' value='다음 퀴즈'>" */
									 + "<input type='submit' value='업로드 완료'></td></tr>");
				$("#quizMaterialUploadTable").append("<tbody id='quizMaterialUploadTbody'>");					
				$("#quizMaterialUploadTbody").append("<tr><td><h1>"+(cnt+1)+"번 퀴즈</h1>");
				$("#quizMaterialUploadTbody").append("<input type='hidden' name='pb_idnum' value='"+idnum+"'>");
				$("#quizMaterialUploadTbody").append("<input type='hidden' name='pb_lv' value='"+lv+"'></td></tr>");
				$("#quizMaterialUploadTbody").append("<tr><td class='muSmall'><b>교수명 : </b>"
					 				 + "<input type='text' name='pb_id' placeholder='교수명' value='"+ uploadInfo[0].cl_id +"' readonly='readonly'></td>"
									 + "<td class='muSmall'><b>회차 : </b>"
									 //문자열을 정수로 변환해주기.
									 + "<input type='text' name='pb_num' value='"+ conum +"' readonly='readonly'></td><tr>");
				$("#quizMaterialUploadTbody").append("<tr><td><b>강의명 : </b><input type='text' name='cl_clname' value='"+ uploadInfo[0].cl_clname +"' readonly='readonly'></td>"
									 + "<td><b>강좌명 : </b><input type='text' name='dp_coname' value='"+ uploadInfo[0].co_name +"' readonly='readonly'></td></tr>");
				$("#quizMaterialUploadTbody").append("<tr>"
									 + "<td style='width:500px'><b>퀴즈) </b><input type='text' name='pb_pbname' placeholder='퀴즈명' style='width:500px;'></td>"
									 + "<td class='muSmall'><input type='hidden' name='pb_pbnumSt' placeholder='퀴즈번호' value='"+(cnt+1)+"'></td></tr>");
				$("#quizMaterialUploadTbody").append("<tr><td colspan='2'><b>보기)<br><span>"
									 + "<label for='dp_pbexmnum1'>1&nbsp;</label>"
									 + "<input type='text' class='dp_pbexm' name='dp_pbexm' placeholder='1번 보기'>"
									 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='1'>"
									 + "<label for='dp_pbexmnum2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;</label>"
									 + "<input type='text' class='dp_pbexm' name='dp_pbexm' placeholder='2번 보기'>"
									 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='2'>"
									 + "<label for='dp_pbexmnum3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3&nbsp;</label>"
									 + "<input type='text' class='dp_pbexm' name='dp_pbexm' placeholder='3번 보기'>"
									 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='3'>"
									 + "<label for='dp_pbexmnum4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4&nbsp;</label>"
									 + "<input type='text' class='dp_pbexm' name='dp_pbexm' placeholder='4번 보기'>"
									 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='4'>"
									 + "</span></td></tr>");
				$("#quizMaterialUploadTbody").append("<tr><td colspan='2'>"
									 + "<b>정답 : </b><br>"
									 + "<label for='pb_pbexplain1'>&nbsp;&nbsp;1번&nbsp;</label>"
									 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='1'><br>"
									 + "<label for='pb_pbexplain2'>&nbsp;&nbsp;2번&nbsp;</label>"
									 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='2'><br>"
									 + "<label for='pb_pbexplain3'>&nbsp;&nbsp;3번&nbsp;</label>"
									 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='3'><br>"
									 + "<label for='pb_pbexplain4'>&nbsp;&nbsp;4번&nbsp;</label>"
									 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='4'><br>"
									 + "</td></tr>");
				$("#quizMaterialUploadTbody").append("<tr>"
									 + "<td colspan='2'>"
									 + "<label for='pb_pbanswer'>해설</label><br>"
									 + "<textarea class='pb_pbanswer' name='pb_pbanswer' style='width: 800px; height:500px';></textarea>"
									 + "</td></tr>");
				cnt++;
		},
			error : function(err){
				console.log(err);
			}
		});
	});
		
	function uploadAddClick() {
		console.log("퀴즈추가 일련번호 : "+ $("#idnum").val());
		console.log("퀴즈추가 레벨값 : " + $("#lv").val());
		var FormData = $('#insertquizMaterialUploadFrm').serialize();
		$.ajax({
			url: 'rest/insertselectquizmaterialuploadfrmajax?cl_idnum='+idnum+'&cl_lv='+lv,
			type: 'post',
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			data : FormData,
			dataType : 'json',
			beforeSend : function(xhr){
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			}, success: function(uploadInfo){
				console.log(uploadInfo);
				$("#container").html("<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name='${_csrf.parameterName}' value='${_csfr.token}' />");
				//$("#container").append("<form id='insertquizMaterialUploadFrm' action='insertquizmaterialupload?${_csrf.parameterName}=${_csrf.token}&cl_idnum='"+idnum+"'&cl_lv='"+lv+"' method='post' encType='multipart/form-data'>");
				$("#container").append("<form id='insertquizMaterialUploadFrm' action='insertquizmaterialupload?${_csrf.parameterName}=${_csrf.token}' method='post' encType='multipart/form-data'>");
				$("#insertquizMaterialUploadFrm").append("<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name='${_csrf.parameterName}' value='${_csfr.token}' />");
				$("#insertquizMaterialUploadFrm").append("<table id='quizMaterialUploadTable' class='table table-border'>");
				$("#quizMaterialUploadTable").append("<thead id='quizMaterialUploadThead'>");
				$("#quizMaterialUploadThead").append("<caption id='quizMaterialUploadCaption' style='width:500px;'>");
				$("#quizMaterialUploadCaption").append("<h2>퀴즈 자료 업로드</h2>");
				$("#quizMaterialUploadTable").append("<tr><td id='btnTd'>"
									 + "<input type='button' id='btnAdd' onclick='uploadAddClick()' value='퀴즈 추가'>"
									 /* + "<input type='button' id='btnCntAfter' onclick='cntAfter()' value='다음 퀴즈'>" */
									 + "<input type='submit' value='업로드 완료'></td></tr>");
				$("#quizMaterialUploadTable").append("<tbody id='quizMaterialUploadTbody'>");					
				$("#quizMaterialUploadTbody").append("<tr><td><h1>"+(cnt+1)+"번 퀴즈</h1>");
				$("#quizMaterialUploadTbody").append("<input type='hidden' name='pb_idnum' value='"+idnum+"'>");
				$("#quizMaterialUploadTbody").append("<input type='hidden' name='pb_lv' value='"+lv+"'></td></tr>");
				$("#quizMaterialUploadTbody").append("<tr><td class='muSmall'><b>교수명 : </b>"
					 				 + "<input type='text' name='pb_id' placeholder='교수명' value='"+ uploadInfo[0].cl_id +"' readonly='readonly'></td>"
									 + "<td class='muSmall'><b>회차 : </b>"
									 + "<input type='text' name='pb_num' value='"+ conum +"' readonly='readonly'></td><tr>");
				$("#quizMaterialUploadTbody").append("<tr><td><b>강의명 : </b><input type='text' name='cl_clname' value='"+ uploadInfo[0].cl_clname +"' readonly='readonly'></td>"
									 + "<td><b>강좌명 : </b><input type='text' name='dp_coname' value='"+ uploadInfo[0].co_name +"' readonly='readonly'></td></tr>");
				$("#quizMaterialUploadTbody").append("<tr>"
									 + "<td style='width:500px'><b>퀴즈) </b><input type='text' name='pb_pbname' placeholder='퀴즈명' style='width:500px;'></td>"
									 + "<td class='muSmall'><input type='hidden' name='pb_pbnumSt' placeholder='퀴즈번호' value='"+(cnt+1)+"'></td></tr>");
				$("#quizMaterialUploadTbody").append("<tr><td colspan='2'><b>보기)<br><span>"
									 + "<label for='dp_pbexmnum1'>1&nbsp;</label>"
									 + "<input type='text' class='dp_pbexm' name='dp_pbexm' placeholder='1번 보기'>"
									 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='1'>"
									 + "<label for='dp_pbexmnum2'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2&nbsp;</label>"
									 + "<input type='text' class='dp_pbexm' name='dp_pbexm' placeholder='2번 보기'>"
									 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='2'>"
									 + "<label for='dp_pbexmnum3'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3&nbsp;</label>"
									 + "<input type='text' class='dp_pbexm' name='dp_pbexm' placeholder='3번 보기'>"
									 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='3'>"
									 + "<label for='dp_pbexmnum4'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4&nbsp;</label>"
									 + "<input type='text' class='dp_pbexm' name='dp_pbexm' placeholder='4번 보기'>"
									 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='4'>"
									 + "</span></td></tr>");
				$("#quizMaterialUploadTbody").append("<tr><td colspan='2'>"
									 + "<b>정답 : </b><br>"
									 + "<label for='pb_pbexplain1'>&nbsp;&nbsp;1번&nbsp;</label>"
									 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='1'><br>"
									 + "<label for='pb_pbexplain2'>&nbsp;&nbsp;2번&nbsp;</label>"
									 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='2'><br>"
									 + "<label for='pb_pbexplain3'>&nbsp;&nbsp;3번&nbsp;</label>"
									 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='3'><br>"
									 + "<label for='pb_pbexplain4'>&nbsp;&nbsp;4번&nbsp;</label>"
									 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='4'><br>"
									 + "</td></tr>");
				$("#quizMaterialUploadTbody").append("<tr>"
									 + "<td colspan='2'>"
									 + "<label for='pb_pbanswer'>해설</label><br>"
									 + "<textarea class='pb_pbanswer' name='pb_pbanswer' style='width: 800px; height:500px';></textarea>"
									 + "</td></tr>");
				cnt++;
		},
			error : function(err){
				console.log(err);
			}
		});
	}
	
	</script>
</body>
</html>

