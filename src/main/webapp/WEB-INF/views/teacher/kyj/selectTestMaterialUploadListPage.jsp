<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>시험 업로드 자료 확인</title>
<!-- Latest compiled and minified CSS -->
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

<!-- Latest compiled and minified JavaScript -->
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
	<input type="hidden" id="idnum" value="${Cl_idnum}">
	<input type="hidden" id="lv" value="${Cl_lv}">
	<div class="container" id="container">

	</div>

	<script>
	var idnum = $("#idnum").val();
	var lv = $("#lv").val();
	console.log("일련번호 : " + idnum);
	console.log("레벨값 : " + lv);
	
	$(document).ready(function(){
		//var FormData = $('#selectTestMaterialUploadFrm').serialize();
		$.ajax({
			url: 'rest/selectviewtestmaterialuploadpageajax?cl_idnum='+idnum+'&cl_lv='+lv,
			type: 'post',
			//contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			dataType : 'json',
			beforeSend : function(xhr){
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			}, success: function(uploadInfo){
				console.log(uploadInfo);
				//if ( uploadInfo != null ){
					$("#container").html("<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name='${_csrf.parameterName}' value='${_csfr.token}' />");
					$("#container").append("<form id='selectTestMaterialUploadFrm' action='selecttestmaterialupload?${_csrf.parameterName}=${_csrf.token}' method='post' encType='multipart/form-data'>");
					$("#selectTestMaterialUploadFrm").append("<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name='${_csrf.parameterName}' value='${_csfr.token}' />");
				for( var i = 0; i < uploadInfo[0].muPbList.length; i++){
					$("#selectTestMaterialUploadFrm").append("<table id='testMaterialUploadTable"+i+"' class='table table-border'>");
					$("#testMaterialUploadTable").append("<thead id='testMaterialUploadThead"+i+"'>");
					$("#testMaterialUploadThead").append("<caption id='testMaterialUploadCaption"+i+"' style='width:500px;'>");
					$("#testMaterialUploadCaption").append("<h2>시험 업로드 자료 확인</h2>");
					$("#testMaterialUploadTable"+i).append("<tr><td id='btnTd'>"
										 + "<input type='button' id='btnAdd' value='문제수정' onclick='uploadAddClick()'>"
							 			 /* + "<input type='button' value='홈으로' onclick=location.href='/h2k5every/'></td></tr>"); */
							 			 + "<input type='button' value='홈으로' onclick=location.href='/h2k5every/prof/goTeacherLoginFrm'></td></tr>");
					$("#testMaterialUploadTable"+i).append("<tbody id='testMaterialUploadTbody"+i+"'>");
					$("#testMaterialUploadTbody"+i).append("<tr><td><h1>"+(i+1)+"번 문제</h1></td></tr>");
					$("#testMaterialUploadTbody"+i).append("<tr><td class='muSmall'><b>교수명 : </b>"
						 				 + "<input type='text' name='pb_id' placeholder='교수명' value='"+ uploadInfo[0].muPbList[i].pb_id +"' readonly='readonly'></td>"
										 + "<td class='muSmall'><b>총회차 : </b>"
										 + "<input type='text' name='pb_num' placeholder='총회차' value='"+ uploadInfo[0].cl_lcnum +"' readonly='readonly'></td><tr>");
					$("#testMaterialUploadTbody"+i).append("<tr><td><b>강의명 : </b><input type='text' name='cl_clname' value='"+ uploadInfo[0].cl_clname +"' readonly='readonly'></td>"
							+ "<td><b>강좌명 : </b><input type='text' name='co_name' placeholder='강좌명' value='"+ uploadInfo[0].muPbList[i].dp_coname +"' readonly='readonly'></td></tr>");
					$("#testMaterialUploadTbody"+i).append("<tr>"
										 + "<td style='width:500px'><b>문제) </b><input type='text' name='pb_pbname' value='"+uploadInfo[0].muPbList[i].pb_pbname+"' style='width:500px;'></td>"
										 + "<td class='muSmall'><input type='hidden' name='pb_pbnumSt' placeholder='문제번호' value='"+uploadInfo[0].muPbList[i].pb_pbnum+"'></td></tr>");
					$("#testMaterialUploadTbody"+i).append("<tr id='testMaterialUploadTr"+i+"'><td id='testMaterialUploadTd"+i+"' colspan='2'><b>보기)<br>");
										for( var j = 0; j < uploadInfo[0].muPbList[i].muDpList.length; j++){
					$("#testMaterialUploadTd"+i).append("<span><label for='dp_pbexmnum1'>&nbsp;&nbsp;"+uploadInfo[0].muPbList[i].muDpList[j].muDpExmList[0].dp_pbexmnum+"&nbsp;&nbsp;</label>"
										 + "<input type='text' class='dp_pbexm' name='dp_pbexm' value='"+uploadInfo[0].muPbList[i].muDpList[j].muDpExmList[0].dp_pbexm+"'>"
										 + "</span></td></tr>");
										}
					$("#testMaterialUploadTbody"+i).append("<tr><td colspan='2'>"
										 + "<b>정답 : </b><br>"
										 + "<input type='text' class='pb_pbexplain' name='pb_pbexplain' value='"+uploadInfo[0].muPbList[i].pb_pbexplain+"'><br>"
										 + "</td></tr>");
					$("#testMaterialUploadTbody"+i).append("<tr>"
										 + "<td colspan='2'>"
										 + "<label for='pb_pbanswer'>해설</label><br>"
										 + "<textarea class='pb_pbanswer' name='pb_pbanswer' style='width: 800px; height:500px';>"+uploadInfo[0].muPbList[i].pb_pbanswer+"</textarea>"
										 + "</td></tr>");
				}
				//} else {
				//	$("#container").html("<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name='${_csrf.parameterName}' value='${_csfr.token}' />");
				//	$("#container").append("<h1>업로드된 자료가 없습니다.</h1>");
				//}
		},
			error : function(err){
				console.log(err);
			}
		});
	});
		
		
	</script>
</body>
</html>

