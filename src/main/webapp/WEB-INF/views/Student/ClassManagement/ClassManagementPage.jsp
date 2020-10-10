<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
header {
	/* background-color: gray; */
	
}

aside {
	/* background-color: blue; */
	width: 300px;
	float: left;
}

section {
	/* background-color: pink; */
	width: 1000px;
	float: left;
}

.menu {
	margin-left: 20px;
	text-align: center;
	width: 200px;
	border: 1px black solid;
	float: left;
}
#modal {
   display: none;
   position: fixed;
   position: absolute;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%
}

#modal.open {
   display: block;
   color: red;
}

#modal #bg_modal {
   position: absolute;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background: #000;
   opacity: .5;
   filter: alpha(opacity = 50);
   z-index: 100
}

#contents_modal {
   position: absolute;
   top: 40%;
   left: 40%;
   width: 600px;
   height: 500px;
   margin: -150px 0 0 -194px;
   padding: 28px 28px 0 28px;
   border: 2px solid #555;
   background: #fff;
   font-size: 12px;
   z-index: 200;
   color: #767676;
   line-height: normal;
   white-space: normal;
   overflow: scroll
}

</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<body>
<script>
/* $(document).ready
(function() {
	//var aut =JSON.parse("${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}");
	var aut= "${aut}";
	var n = aut.indexOf("ROLE_PROF");
	 var id = "${id}";
	if (n == 1){
		$("#goTeacherPage").append("<p style='margin-top: auto;'><b><a href='/h2k5every/prof/goTeacherLoginFrm' style='color: white; '>강사페이지이동</a></b></p>");
	}
 
	test(id);
}); */
</script>
	<header>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_aside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
		<input type='hidden' id='token' data-token-name='${_csrf.headerName}'
		name='${_csrf.parameterName}' value='${_csrf.token}'>
		<div id='modal'>
			<div id='bg_modal'></div>
			<div id='contents_modal'></div>
		</div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
</body>
<script>
var myClassList = ${myClassList};
var myLikeList = ${myLikeList};
var section = $('#section');
var modal = $('#modal');

function startClassManagementPage(){
	section.append("<div id='classList'><h3>수강 중인 과목</h3><br/></div>");	
	section.append("<div id='likeList'><h3>나의 관심 강의</h3><br/></div>");	
	//create myClassList Table 
	var str="<table id='tableCL'><tr><td>강의명</td><td>진도율</td><td>강의실로 이동</td></tr>";
	if(Object.keys(myClassList).length !=0){		
		console.log(myClassList);
		for(var i in myClassList){
			if(myClassList[i].at_atmkCnt ==0){
				var percent=0;
			}else{
				var percent = myClassList[i].at_atmkCnt / myClassList[i].cl_lcnum * 100;		
			}
		str +="<tr><td>"+myClassList[i].cl_clName+"</td>";
		str +="<td>"+percent.toFixed(1)+"%</td>";
		str +="<td><a href='/h2k5every/stud/classHome?cl_idnum="+myClassList[i].cl_idnum+"&cl_lv="+myClassList[i].cl_lv+"'>강의실로 이동</a></td></tr>";
		}
	}else{
		str +="<tr><td colspan='3'>수강 중인 강의가 없습니다.</td></tr>";
	}
	str +="</table>";
	$('#classList').append(str);
	//create myLikeList Table
	str="<table id='tableLL'><tr><td>강의명</td><td>강사명</td><td>강의계획서 보기</td><td>수강신청</td></tr>";
	console.log(Object.keys(myLikeList).length);
	console.log(myLikeList);
	if(Object.keys(myLikeList).length!=0){
		for(var j in myLikeList){
			str+="<tr><td>"+myLikeList[j].cl_clName+"</td>";
			str+="<td>"+myLikeList[j].mb_name+"</td>";
			str+="<td><a href='#'>강의계획서 보기</a></td>";
			str+="<td><a href='#' onclick=\"openBuyPage('"+myLikeList[j].cl_idnum+"', '"+myLikeList[j].cl_lv+"')\">수강신청 하러가기</a></td></tr>";
		}
	}else{
		str +="<tr><td colspan='4'>관심설정한 강의가 없습니다.</td></tr>";
	}
	str +="</table>";
	$('#likeList').append(str);
};//startClassManagementPage END

function openBuyPage(idnum, lv){
	modal.addClass('open');
	var m_contents=$('#contents_modal');
	var obj = {"cl_idnum":idnum, "cl_lv":lv};
	$.ajax({
		type:'get',
		url: "rest/selectBuyClass",
		data:obj,
		dataType:'json',
		success:function(json){
			if(Object.keys(json).length!=0){				
				m_contents.append("<h3>강의 구매<h3>");
				m_contents.append("<p>강의명: "+json.cb.cl_clName+"</p>");
				m_contents.append("<p>학습레벨: lv"+json.cb.cl_lv+"</p>");
				m_contents.append("<p>강수: "+json.cb.cl_lcnum+"강</p>");
				m_contents.append("<p>수강기간: "+json.cb.cl_stDay.substring(0,10)+" ~ "+json.cb.cl_fnDay.substring(0,10)+"</p>");
				m_contents.append("<p>강의가격: <input type='text' value='"+json.cb.cl_pt+"' readonly> point</p>");
				m_contents.append("<p>나의 보유 포인트: <input type='text' value='"+json.mb.mb_point+"' readonly> point</p>");
				var deductPoint = json.mb.mb_point - json.cb.cl_pt;
				m_contents.append("<p>차감 후 남는 포인트: <input type='' value='"+deductPoint+"' readonly> point</p><br/>");
				var booleanPoint = deductPoint>=0;
				m_contents.append("<input type='checkbox'id='mustChk'/><b> 위 상품 정보 및 거래 조건을 확인하였으며, 구매 진행에 동의합니다.(필수)</b>");
				m_contents.append("<p id='err'></p>");
				m_contents.append("<input type='button' value='구매하기' onclick=\"insertBuyClass('"+json.cb.cl_idnum+"','"+json.cb.cl_lv+"','"+json.cb.cl_pt+"','"+booleanPoint+"')\">");
			}else{
				alert("구매하기창 불러오기에 실패했습니다.");
			}
		},error: function(err){
			console.log(err);
		}
	});//ajaxEND
};//openBuyPage END
modal.find('#bg_modal').on('mousedown',function(evt){
	console.log(evt);
	modal.removeClass('open'); 
});// modal mousesdown end
$(document).keydown(function(evt){
	if(evt.keyCode !=27){
		return;
	}else if (modal.hasClass('open')){
		modal.removeClass('open');
	}
}); //modal esc END

function insertBuyClass(idnum, lv, point, bool){
	var obj= {"cl_idnum":idnum,"cl_lv":lv, "cl_pt":point};
	console.log(obj);
	var chkbox = $("input:checkbox[id=mustChk]").is(":checked");
	if(chkbox == true){
		if(bool == 'true'){
			$.ajax({
				type:'post',
				url:'rest/insertBuyClass',
				data:obj,
				dataType:'json',
				beforeSend : function(xhr){
					var $token = $("#token");
					xhr.setRequestHeader($token.data("token-name"), $token.val());
				},
				success: function(json){
					console.log(json);
					if(json == true){
						alert("수강신청이 완료되었습니다.");
						location.replace("selectMyClassManagementPage");
					}else{
						alert("수강신청에 실패했습니다. 관리자에게 문의해주세요.");
						location.replace("selectMyClassManagementPage");
					}
				},error: function(err){
					console.log(err);
					alert("err: 수강신청 오류 강의정보 오류");
				}
			});
		}else{
			if(confirm("포인트가 부족합니다. 포인트 구매창으로 이동하시겠습니까?")){
				alert("페이지 구현 중!");
			}else{
				alert("창을 종료합니다.");
				modal.removeClass('open');
			}
		}
	}else{
		$('#err').attr("style","color:red");
		$('#err').html("체크 후 구매하기를 진행하실 수 있습니다.");
	}
};// function insertBuyClass END

function test(id) {
	$.ajax({
		type:'get',
		url:'rest/selectConcern',
		datatype:'json',
		success: function (json) {
			for(var i=0; i<json.length; i++){
				$('#menu').append("<div class='menu'><p>"+json[i]+"</p></div>");
			}
			startClassManagementPage();
		},
		error: function (err) {
			startClassManagementPage();
		}
	});
} 
</script>

</html>