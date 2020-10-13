<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>퀴즈 업로드 자료 확인</title>
<!-- Latest compiled and minified CSS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
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
	
<style>
header {
	/* background-color: gray; */
	 position: absolute; 
	 transform:translate(0px,0px);  
	 width: 1500px; 
}

aside {
	/* background-color: blue; */
	width: 300px;
	float: left;
	position : absolute;
	transform:translate(0px,112px);  
}

section {
	/* background-color: pink; */
	margin-top: 20px;
	width: 1100px;
	float: left;
	position: absolute;
	transform:translate(320px,110px);
}

.muSmall {
	width: 300px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="../../h2k5every_loginHeader.jsp" />
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section>
	<input type="hidden" id="token" data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" id="idnum" value="${Cl_idnum}">
	<input type="hidden" id="lv" value="${Cl_lv}">
	<input type="hidden" id="conum" value="${Co_num}">
	<div class="container" id="container">
	</div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>

	<script>
	$.urlParam = function(name){
	    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
	    return results[1] || 0;
	}
	
	var idnum = $("#idnum").val();
	var lv = $("#lv").val();
	var conum = $("#conum").val();
	//var conum = $.urlParam('co_num');
	console.log("일련번호 : " + idnum);
	console.log("레벨값 : " + lv);
	console.log("회차 : " + conum);
	
	$(document).ready(function(){
		//var FormData = $('#selectQuizMaterialUploadFrm').serialize();
		$.ajax({
			url: 'rest/selectviewquizmaterialuploadpageajax?cl_idnum='+idnum+'&cl_lv='+lv+'&co_num='+conum,
			type: 'post',
			//contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			dataType : 'json',
			beforeSend : function(xhr){
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			}, success: function(uploadInfo){
				console.log(uploadInfo);
					$("#container").html("<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name='${_csrf.parameterName}' value='${_csfr.token}' />");
					$("#container").append("<form id='selectQuizMaterialUploadFrm' action='selectquizmaterialupload?${_csrf.parameterName}=${_csrf.token}' method='post' encType='multipart/form-data'>");
					$("#selectQuizMaterialUploadFrm").append("<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name='${_csrf.parameterName}' value='${_csfr.token}' />");
				for( var i = 0; i < uploadInfo[0].muPbList.length; i++){
					$("#selectQuizMaterialUploadFrm").append("<table id='quizMaterialUploadTable"+i+"' class='table'>");
					$("#quizMaterialUploadTable"+i).append("<thead id='quizMaterialUploadThead"+i+"'>");
					$("#quizMaterialUploadThead"+i).append("<caption id='quizMaterialUploadCaption"+i+"' style='width:500px;'>");
					$("#quizMaterialUploadCaption"+i).append("<h2>퀴즈 업로드 자료 확인</h2>");
					$("#quizMaterialUploadTable"+i).append("<tr><td id='btnTd'>"
										 /* + "<input type='button' id='btnAdd' value='퀴즈수정' onclick='uploadAddClick()'>" */
										 + "<input type='button' value='뒤로가기' class='btn btn-primary btn-sm' onclick=location.href='/h2k5every/prof/selectquizmaterialclcolist'>"
										 + "<input type='button' value='뒤로가기' class='btn btn-primary btn-sm' onclick=location.href='/h2k5every/prof/selectquizmaterialclcolist?Cl_idnum="+idnum+"&Cl_lv="+lv+"'>"
							 			 + "<input type='button' value='홈으로' class='btn btn-default btn-sm' onclick=location.href='/h2k5every/prof/goTeacherLoginFrm'></td></tr>");
					$("#quizMaterialUploadTable"+i).append("<tbody id='quizMaterialUploadTbody"+i+"'>");
					$("#quizMaterialUploadTbody"+i).append("<tr><td><h1>" + uploadInfo[0].muPbList[i].dp_coname + "&nbsp;-&nbsp;" + (i+1) + "번 퀴즈</h1></td></tr>");
					$("#quizMaterialUploadTbody"+i).append("<tr><td class='muSmall' style='background-color:gray;'><b>교수명&nbsp;</b>"
						 				 + "<input type='text' name='pb_id' placeholder='교수명' value='"+ uploadInfo[0].muPbList[i].pb_id +"' readonly='readonly' style='border-radius: 8px; text-align:center; width:80%;'></td>"
										 + "<td class='muSmall' style='background-color:gray;'><b>회차&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>"
										 + "<input type='text' name='pb_num' placeholder='회차' value='"+ conum +"' readonly='readonly' style='border-radius: 8px; text-align:center;  width:80%;'></td><tr>");
					$("#quizMaterialUploadTbody"+i).append("<tr><td style='background-color:gray;'><b>강의명&nbsp;</b><input type='text' name='cl_clname' value='"+ uploadInfo[0].cl_clname +"' readonly='readonly' style='border-radius: 8px; text-align:center; width:80%;'></td>"
							+ "<td style='background-color:gray;'><b>강좌명&nbsp;</b><input type='text' name='co_name' placeholder='강좌명' value='"+ uploadInfo[0].muPbList[i].dp_coname +"' readonly='readonly' style='border-radius: 8px; text-align:center;  width:80%;'></td></tr>");
					$("#quizMaterialUploadTbody"+i).append("<tr>"
										 + "<td style='width:500px; background-color:gray;' colspan='2'><b>퀴즈&nbsp;&nbsp;&nbsp;&nbsp;</b><input type='text' name='pb_pbname' value='"+uploadInfo[0].muPbList[i].pb_pbname+"' style='border-radius: 8px; text-align:center; width:92.8%;'></td>"
										 + "<td class='muSmall'><input type='hidden' name='pb_pbnumSt' placeholder='문제번호' value='"+uploadInfo[0].muPbList[i].pb_pbnum+"'></td></tr>");
					$("#quizMaterialUploadTbody"+i).append("<tr id='testMaterialUploadTr"+i+"'><td id='quizMaterialUploadTd"+i+"' colspan='2' style='background-color:gray;'><b>보기<br>");
										for( var j = 0; j < uploadInfo[0].muPbList[i].muDpList.length; j++){
					$("#quizMaterialUploadTd"+i).append("<span><label for='dp_pbexmnum1'>&nbsp;&nbsp;"+uploadInfo[0].muPbList[i].muDpList[j].muDpExmList[0].dp_pbexmnum+"&nbsp;&nbsp;</label>"
										 + "<input type='text' style='border-radius: 8px; width:95%; text-align:center;' class='dp_pbexm' name='dp_pbexm' value='"+uploadInfo[0].muPbList[i].muDpList[j].muDpExmList[0].dp_pbexm+"'>"
										 + "</span></td></tr><br>");
										}
					$("#quizMaterialUploadTbody"+i).append("<tr><td colspan='2' style='background-color:gray;'>"
										 + "<b>정답&nbsp; </b>"
										 + "<input type='text' class='pb_pbexplain' name='pb_pbexplain' style='border-radius: 8px; text-align:center; width:93.2%;' value='"+uploadInfo[0].muPbList[i].pb_pbexplain+"'><br>"
										 + "</td></tr>");
					$("#quizMaterialUploadTbody"+i).append("<tr>"
										 + "<td colspan='2' style='background-color:gray;'>"
										 + "<label for='pb_pbanswer'>해설</label><br>"
										 + "<textarea class='pb_pbanswer' name='pb_pbanswer' style='width: 800px; height:500px; border-radius: 8px; '>"+uploadInfo[0].muPbList[i].pb_pbanswer+"</textarea>"
										 + "</td></tr>");
				}
		},
			error : function(err){
				console.log(err);
			}
		});
	});
		
	</script>
</body>
</html>

