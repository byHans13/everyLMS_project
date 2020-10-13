<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>시험 자료 업로드</title>
<!-- Latest compiled and minified CSS -->

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../resources/js/jquery.serializeObject.js"></script>
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
</head>
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
	<input type="hidden" id="token" data-token-name="${_csrf.headerName}"
		name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" id="idnum" name="idnum"
		value="${muList[0].cl_idnum}">
	<input type="hidden" id="lv" name="lv" value="${muList[0].cl_lv}">
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
	var cnt = Number($.urlParam('pb_num'));
	var idnum = $("#idnum").val();
	var lv = $("#lv").val();
	console.log("문제번호 : " + cnt);
	console.log("일련번호 : "+ $("#idnum").val());
	console.log("레벨값 : " + $("#lv").val());
	$(document).ready(function(){
		var FormData = $('#insertTestMaterialUploadFrm').serialize();
		$.ajax({
 			url: 'rest/inserttestmaterialuploadfrmajax?cl_idnum='+idnum+'&cl_lv='+lv + '&pb_num='+(cnt+1),
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
				$("#container").append("<form id='insertTestMaterialUploadFrm' action='inserttestmaterialupload?${_csrf.parameterName}=${_csrf.token}' method='post' encType='multipart/form-data' class='container'>");
				$("#insertTestMaterialUploadFrm").append("<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name='${_csrf.parameterName}' value='${_csfr.token}' />");
				$("#insertTestMaterialUploadFrm").append("<table id='testMaterialUploadTable' class='table'>");
				$("#testMaterialUploadTable").append("<thead id='testMaterialUploadThead'>");
				$("#testMaterialUploadThead").append("<caption id='testMaterialUploadCaption' style='width:500px;'>");
				$("#testMaterialUploadCaption").append("<h2>시험 자료 업로드</h2>");
				$("#testMaterialUploadTable").append("<tr><td id='btnTd'><button id='btnAdd' class='btn btn-primary btn-sm' type='button'  onclick='uploadAddClick()'>문제 추가</button>&nbsp;"
									 + "<input type='button' class='btn btn-primary btn-sm' value='뒤로가기' onclick=location.href='/h2k5every/prof/selecttestmaterialclasslist'>&nbsp;"
									 + "<input type='button' id='btnUploadComplet' class='btn btn-default btn-sm' onclick='uploadComplet()' value='업로드 완료'></td></tr>");
				$("#testMaterialUploadTable").append("<tbody id='testMaterialUploadTbody'>");					
				$("#testMaterialUploadTbody").append("<tr><td><h1>"+(cnt+1)+"번 문제</h1>");
				$("#testMaterialUploadTbody").append("<input type='hidden' name='pb_idnum' value='"+idnum+"'>");
				$("#testMaterialUploadTbody").append("<input type='hidden' name='pb_lv' value='"+lv+"'></td></tr>");
// 				$("#testMaterialUploadTbody").append("<tr class = 'input-group'><td colspan='2' class='muSmall'><span class='input-group-addon'><b>교수명</b></span>"
				$("#testMaterialUploadTbody").append("<tr colspan='2'><td style='background-color:gray;' class='muSmall'><b>교수명&nbsp; </b>"
					 				 + "<input type='text' name='pb_id' placeholder='교수명' value='"+ uploadInfo[0].cl_id +"' readonly='readonly'  style='border-radius: 8px; text-align:center; width:80%;'></td>"
									 + "<td class='muSmall' style='background-color:gray;'><b>총회차&nbsp; </b>"
									 + "<input type='hidden' name='pb_num' value=0>"
									 + "<input type='text' placeholder='총회차' value='"+ uploadInfo[0].cl_lcnum +"' style='border-radius: 8px; text-align:center; width:82%;'  readonly='readonly'></td></tr>");
				$("#testMaterialUploadTbody").append("<tr><td style='background-color:gray;'><b>강의명&nbsp; </b><input type='text' name='cl_clname' placeholder='강의명' value='"+ uploadInfo[0].cl_clname +"' style='border-radius: 8px; text-align:center; width:80%;' readonly='readonly'></td>"
									 + "<td style='background-color:gray;'><b>강좌명&nbsp; </b><select id='selectBoxCoName' style='border-radius: 8px; text-align:center; width:82%;' name='dp_coname'></td></tr>");
									 for(var i=1; i<uploadInfo.length; i++){
				$("#selectBoxCoName").append("<option value='"+uploadInfo[i].co_name+"'>"+uploadInfo[i].co_name+"</option>");
									 }
				$("#testMaterialUploadTbody").append("<tr>"
									 + "<td style='background-color:gray;' colspan='2'><b>&nbsp;&nbsp;문제&nbsp;&nbsp;&nbsp;</b><input type='text' id='pb_pbname' name='pb_pbname' placeholder='문제명' style='width:94%; border-radius: 8px; text-align:center;'></td>"
									 + "<td class='muSmall'><input type='hidden' name='pb_pbnumSt' placeholder='문제번호' value='"+(cnt+1)+"'></td></tr>");
				$("#testMaterialUploadTbody").append("<tr><td colspan='2' style='background-color:gray;'><span>"
									 + "<label for='dp_pbexmnum1'>&nbsp;1번 보기&nbsp;&nbsp;</label>"
									 + "<input type='text' style='border-radius: 8px; width:92%; text-align:center;' id='dp_pbexm1' class='dp_pbexm' name='dp_pbexm' placeholder='보기를 입력해주세요.'>"
									 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='1'><br>"
									 + "<label for='dp_pbexmnum2'>&nbsp;2번 보기&nbsp;&nbsp;</label>"
									 + "<input type='text' style='border-radius: 8px;  width:92%; text-align:center;' id='dp_pbexm2' class='dp_pbexm' name='dp_pbexm' placeholder='보기를 입력해주세요.'>"
									 + "<input type='hidden' class='dp_pbexmnum' name=dp_pbexmnumSt' value='2'><br>"
									 + "<label for='dp_pbexmnum3'>&nbsp;3번 보기&nbsp;&nbsp;</label>"
									 + "<input type='text' style='border-radius: 8px; width:92%; text-align:center;' id='dp_pbexm3' class='dp_pbexm' name='dp_pbexm' placeholder='보기를 입력해주세요.'>"
									 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='3'><br>"
									 + "<label for='dp_pbexmnum4'>&nbsp;4번 보기&nbsp;&nbsp;</label>"
									 + "<input type='text' style='border-radius: 8px; width:92%; text-align:center;' id='dp_pbexm4' class='dp_pbexm' name='dp_pbexm' placeholder='보기를 입력해주세요.'>"
									 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='4'>"
									 + "</span></td></tr>");
				$("#testMaterialUploadTbody").append("<tr><td colspan='2' style='background-color:gray;'>"
									 + "<b>&nbsp;정답 : </b>"
									 + "<label for='pb_pbexplain1'>&nbsp;&nbsp;1번&nbsp;</label>"
									 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='1'>&nbsp;"
									 + "<label for='pb_pbexplain2'>&nbsp;&nbsp;2번&nbsp;</label>"
									 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='2'>&nbsp;"
									 + "<label for='pb_pbexplain3'>&nbsp;&nbsp;3번&nbsp;</label>"
									 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='3'>&nbsp;"
									 + "<label for='pb_pbexplain4'>&nbsp;&nbsp;4번&nbsp;</label>"
									 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='4'>&nbsp;"
									 + "</td></tr>");
				$("#testMaterialUploadTbody").append("<tr>"
									 + "<td colspan='2' style='background-color:gray;'>"
									 + "<label for='pb_pbanswer'>&nbsp;해설</label><br>"
									 + "<textarea  id='pb_pbanswer' class='pb_pbanswer' name='pb_pbanswer' style='width: 800px; height:500px; border-radius: 8px;'></textarea>"
									 + "</td></tr>");
				cnt++;
		},
			error : function(err){
				console.log(err);
			}
		});
	});
		
	function uploadAddClick() {
		var pbname = $("#pb_pbname");
		var pbexm1 = $("#dp_pbexm1");
		var pbexm2 = $("#dp_pbexm2");
		var pbexm3 = $("#dp_pbexm3");
		var pbexm4 = $("#dp_pbexm4");
		var pbexplain = $(":input:radio[name=pb_pbexplain]:checked").val();
		var pbanswer = $(".pb_pbanswer");
		console.log("pbexplain 값 = "+pbexplain);
		if(pbname.val() == '' || pbname.val() == null
			&& pbexm1.val() == '' || pbexm1.val() == null
			&& pbexm2.val() == '' || pbexm2.val() == null
			&& pbexm3.val() == '' || pbexm3.val() == null
			&& pbexm4.val() == '' || pbexm4.val() == null
			&& pbexplain == '' || pbexplain == null
			&& pbanswer.val() == '' || pbanswer.val() == null){
			alert("모든 입력란을 입력해주세요.");
		} else if(pbname.val() == '' || pbname.val() == null){
			alert("문제명을 입력해주세요.");
		} else if(pbexm1.val() == '' || pbexm1.val() == null){
			alert("1번 보기를 입력해주세요.");
		} else if(pbexm2.val() == '' || pbexm2.val() == null){
			alert("2번 보기를 입력해주세요.");
		} else if(pbexm3.val() == '' || pbexm3.val() == null){
			alert("3번 보기를 입력해주세요.");
		} else if(pbexm4.val() == '' || pbexm4.val() == null){
			alert("4번 보기를 입력해주세요.");
		} else if(pbexplain == '' || pbexplain == null){
			alert("정답을 체크해주세요.");
		} else if(pbanswer.val() == '' || pbanswer.val() == null){
			alert("해설을 입력해주세요.");
		} else {

			console.log("문제추가 일련번호 : "+ $("#idnum").val());
			console.log("문제추가 레벨값 : " + $("#lv").val());
			
			var FormData = $('#insertTestMaterialUploadFrm').serialize();
			$.ajax({
				url: 'rest/insertselecttestmaterialuploadfrmajax?cl_idnum='+idnum+'&cl_lv='+lv,
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
					$("#container").append("<form id='insertTestMaterialUploadFrm' action='inserttestmaterialupload?${_csrf.parameterName}=${_csrf.token}' method='post' encType='multipart/form-data' class='container'>");
					$("#insertTestMaterialUploadFrm").append("<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name='${_csrf.parameterName}' value='${_csfr.token}' />");
					$("#insertTestMaterialUploadFrm").append("<table id='testMaterialUploadTable' class='table'>");
					$("#testMaterialUploadTable").append("<thead id='testMaterialUploadThead'>");
					$("#testMaterialUploadThead").append("<caption id='testMaterialUploadCaption' style='width:500px;'>");
					$("#testMaterialUploadCaption").append("<h2>시험 자료 업로드</h2>");
					$("#testMaterialUploadTable").append("<tr><td id='btnTd'><button id='btnAdd' class='btn btn-primary btn-sm' type='button'  onclick='uploadAddClick()'>문제 추가</button>&nbsp;"
										 + "<input type='button' class='btn btn-primary btn-sm' value='뒤로가기' onclick=location.href='/h2k5every/prof/selecttestmaterialclasslist'>&nbsp;"
										 + "<input type='button' id='btnUploadComplet' class='btn btn-default btn-sm' onclick='uploadComplet()' value='업로드 완료'></td></tr>");
					$("#testMaterialUploadTable").append("<tbody id='testMaterialUploadTbody'>");					
					$("#testMaterialUploadTbody").append("<tr><td><h1>"+(cnt+1)+"번 문제</h1>");
					$("#testMaterialUploadTbody").append("<input type='hidden' name='pb_idnum' value='"+idnum+"'>");
					$("#testMaterialUploadTbody").append("<input type='hidden' name='pb_lv' value='"+lv+"'></td></tr>");
					$("#testMaterialUploadTbody").append("<tr colspan='2'><td style='background-color:gray;' class='muSmall'><b>교수명&nbsp; </b>"
						 				 + "<input type='text' name='pb_id' placeholder='교수명' value='"+ uploadInfo[0].cl_id +"' readonly='readonly'  style='border-radius: 8px; text-align:center; width:80%;'></td>"
										 + "<td class='muSmall' style='background-color:gray;'><b>총회차&nbsp; </b>"
										 + "<input type='hidden' name='pb_num' value=0>"
										 + "<input type='text' placeholder='총회차' value='"+ uploadInfo[0].cl_lcnum +"' style='border-radius: 8px; text-align:center; width:82%;'  readonly='readonly'></td></tr>");
					$("#testMaterialUploadTbody").append("<tr><td style='background-color:gray;'><b>강의명&nbsp; </b><input type='text' name='cl_clname' placeholder='강의명' value='"+ uploadInfo[0].cl_clname +"' style='border-radius: 8px; text-align:center; width:80%;' readonly='readonly'></td>"
										 + "<td style='background-color:gray;'><b>강좌명&nbsp; </b><select id='selectBoxCoName' style='border-radius: 8px; text-align:center; width:82%;' name='dp_coname'></td></tr>");
										 for(var i=1; i<uploadInfo.length; i++){
					$("#selectBoxCoName").append("<option value='"+uploadInfo[i].co_name+"'>"+uploadInfo[i].co_name+"</option>");
										 }
					$("#testMaterialUploadTbody").append("<tr>"
										 + "<td style='background-color:gray;' colspan='2'><b>&nbsp;&nbsp;문제&nbsp;&nbsp;&nbsp;</b><input type='text' id='pb_pbname' name='pb_pbname' placeholder='문제명' style='width:94%; border-radius: 8px; text-align:center;'></td>"
										 + "<td class='muSmall'><input type='hidden' name='pb_pbnumSt' placeholder='문제번호' value='"+(cnt+1)+"'></td></tr>");
					$("#testMaterialUploadTbody").append("<tr><td colspan='2' style='background-color:gray;'><span>"
										 + "<label for='dp_pbexmnum1'>&nbsp;1번 보기&nbsp;&nbsp;</label>"
										 + "<input type='text' style='border-radius: 8px; width:92%; text-align:center;' id='dp_pbexm1' class='dp_pbexm' name='dp_pbexm' placeholder='보기를 입력해주세요.'>"
										 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='1'><br>"
										 + "<label for='dp_pbexmnum2'>&nbsp;2번 보기&nbsp;&nbsp;</label>"
										 + "<input type='text' style='border-radius: 8px;  width:92%; text-align:center;' id='dp_pbexm2' class='dp_pbexm' name='dp_pbexm' placeholder='보기를 입력해주세요.'>"
										 + "<input type='hidden' class='dp_pbexmnum' name=dp_pbexmnumSt' value='2'><br>"
										 + "<label for='dp_pbexmnum3'>&nbsp;3번 보기&nbsp;&nbsp;</label>"
										 + "<input type='text' style='border-radius: 8px; width:92%; text-align:center;' id='dp_pbexm3' class='dp_pbexm' name='dp_pbexm' placeholder='보기를 입력해주세요.'>"
										 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='3'><br>"
										 + "<label for='dp_pbexmnum4'>&nbsp;4번 보기&nbsp;&nbsp;</label>"
										 + "<input type='text' style='border-radius: 8px; width:92%; text-align:center;' id='dp_pbexm4' class='dp_pbexm' name='dp_pbexm' placeholder='보기를 입력해주세요.'>"
										 + "<input type='hidden' class='dp_pbexmnum' name='dp_pbexmnumSt' value='4'>"
										 + "</span></td></tr>");
					$("#testMaterialUploadTbody").append("<tr><td colspan='2' style='background-color:gray;'>"
										 + "<b>&nbsp;정답 : </b>"
										 + "<label for='pb_pbexplain1'>&nbsp;&nbsp;1번&nbsp;</label>"
										 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='1'>&nbsp;"
										 + "<label for='pb_pbexplain2'>&nbsp;&nbsp;2번&nbsp;</label>"
										 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='2'>&nbsp;"
										 + "<label for='pb_pbexplain3'>&nbsp;&nbsp;3번&nbsp;</label>"
										 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='3'>&nbsp;"
										 + "<label for='pb_pbexplain4'>&nbsp;&nbsp;4번&nbsp;</label>"
										 + "<input type='radio' class='pb_pbexplain' name='pb_pbexplain' value='4'>&nbsp;"
										 + "</td></tr>");
					$("#testMaterialUploadTbody").append("<tr>"
										 + "<td colspan='2' style='background-color:gray;'>"
										 + "<label for='pb_pbanswer'>&nbsp;해설</label><br>"
										 + "<textarea  id='pb_pbanswer' class='pb_pbanswer' name='pb_pbanswer' style='width: 800px; height:500px; border-radius: 8px;'></textarea>"
										 + "</td></tr>");
					cnt++;
			},
				error : function(err){
					console.log(err);
				}
			});
		}
	}
	
	function uploadComplet() {
		var pbname = $("#pb_pbname");
		var pbexm1 = $("#dp_pbexm1");
		var pbexm2 = $("#dp_pbexm2");
		var pbexm3 = $("#dp_pbexm3");
		var pbexm4 = $("#dp_pbexm4");
		var pbexplain = $(":input:radio[name=pb_pbexplain]:checked").val();
		var pbanswer = $(".pb_pbanswer");
		console.log("pbexplain 값 = "+pbexplain);
		if(pbname.val() == '' || pbname.val() == null
			&& pbexm1.val() == '' || pbexm1.val() == null
			&& pbexm2.val() == '' || pbexm2.val() == null
			&& pbexm3.val() == '' || pbexm3.val() == null
			&& pbexm4.val() == '' || pbexm4.val() == null
			&& pbexplain == '' || pbexplain == null
			&& pbanswer.val() == '' || pbanswer.val() == null){
			alert("모든 입력란을 입력해주세요.");
		} else if(pbname.val() == '' || pbname.val() == null){
			alert("퀴즈명을 입력해주세요.");
		} else if(pbexm1.val() == '' || pbexm1.val() == null){
			alert("1번 보기를 입력해주세요.");
		} else if(pbexm2.val() == '' || pbexm2.val() == null){
			alert("2번 보기를 입력해주세요.");
		} else if(pbexm3.val() == '' || pbexm3.val() == null){
			alert("3번 보기를 입력해주세요.");
		} else if(pbexm4.val() == '' || pbexm4.val() == null){
			alert("4번 보기를 입력해주세요.");
		} else if(pbexplain == '' || pbexplain == null){
			alert("정답을 체크해주세요.");
		} else if(pbanswer.val() == '' || pbanswer.val() == null){
			alert("해설을 입력해주세요.");
		} else {
			$("#insertTestMaterialUploadFrm").submit();
		}
	}
	
	</script>
</body>
</html>

