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
table.type11 {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: center;
    line-height: 1.5;
    margin: 20px 10px;
}
table.type11 th {
    width: 155px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
    background: black ;
}
table.type11 td {
    width: 155px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #eee;
}
table.type05 {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    margin: 20px 10px;
}
table.type05 th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #efefef;
}
table.type05 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<body>
<script>
$(document).ready
(function() {
	//var aut =JSON.parse("${sessionScope.SPRING_SECURITY_CONTEXT.authentication.authorities}");
	var aut= "${aut}";
	var n = aut.indexOf("ROLE_PROF");
	 var id = "${id}";
	if (n == 1){
		$("#goTeacherPage").append("<p style='margin-top: auto;'><b><a href='/h2k5every/prof/goTeacherLoginFrm' style='color: white; '>강사페이지이동</a></b></p>");
	}
 
	test(id);
});
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
console.log(myLikeList);
function startClassManagementPage(){
	section.append("<div id='classList'><h3>수강 중인 과목</h3><br/></div>");	
	section.append("<div id='likeList'><h3>나의 관심 강의</h3><br/></div>");	
	//create myClassList Table 
	var str="<table id='tableCL' class='type11'><thead><tr><th>강의명</th><th>진도율</th><th>강의실로 이동</th></thead></tr>";
		str+="<tbody>";
	if(Object.keys(myClassList).length !=0){		
		console.log(myClassList);
		for(var i in myClassList){
			if(myClassList[i].at_atmkCnt ==0){
				var percent=0;
			}else{
				var percent = (myClassList[i].at_atmkCnt-1) / myClassList[i].cl_lcnum * 100;		
			}
		str +="<tr><td>"+myClassList[i].cl_clName+"</td>";
		str +="<td>"+percent.toFixed(1)+"%</td>";
		str +="<td><a href='/h2k5every/stud/classHome?cl_idnum="+myClassList[i].cl_idnum+"&cl_lv="+myClassList[i].cl_lv+"'>강의실로 이동</a></td></tr>";
		}
	}else{
		str +="<tr><td colspan='3'>수강 중인 강의가 없습니다.</td></tr>";
	}
	str +="</tbody></table>";
	$('#classList').append(str);
	//create myLikeList Table
	str="<table id='tableLL' class='type11'><thead><tr><th>강의명</th><th>강사명</th><th>강의계획서 보기</th><th>수강신청</th></tr></thead>";
	console.log(Object.keys(myLikeList).length);
	console.log(myLikeList);
	str+="<tbody>";
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
	str +="</tbody></table>";
	$('#likeList').append(str);
};//startClassManagementPage END

function openBuyPage(idnum, lv){
	modal.addClass('open');
	var m_contents=$('#contents_modal');
	var str="";
	m_contents.html("");
	var obj = {"cl_idnum":idnum, "cl_lv":lv};
	$.ajax({
		type:'get',
		url: "rest/selectBuyClass",
		data:obj,
		dataType:'json',
		success:function(json){
			if(Object.keys(json).length!=0){				
				m_contents.append("<h3>강의 구매<h3>");
				str +="<table class='type05' id='buyTable'>";
				str +="<tr><th>강의명</th><td>"+json.cb.cl_clName+"</td></tr>";
				str +="<tr><th>학습레벨</th><td>"+json.cb.cl_lv+"</td></tr>";
				str +="<tr><th>강수</th><td>"+json.cb.cl_lcnum+"</td></tr>";
				str +="<tr><th>수강기간</th><td>"+json.cb.cl_stDay.substring(0,10)+" ~ "+json.cb.cl_fnDay.substring(0,10)+"</td></tr>";
				var date = new Date();
				str +="<tr><th>Today</th><td>"+date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+"</td></tr>";
				str +="<tr><th>강의가격</th><td><input type='text' value='"+json.cb.cl_pt+"' readonly> point</td></tr>";
				str +="<tr><th>나의 보유 포인트</th><td><input type='text' value='"+json.mb.mb_point+"' readonly> point</td></tr>";
				var deductPoint = json.mb.mb_point - json.cb.cl_pt;
				var booleanPoint = deductPoint>=0;
				str +="<tr><th>차감 후 나의 포인트</th><td><input type='text' value='"+deductPoint+"' readonly> point</td></tr>";
				str +="</table>";
				str +="<input type='checkbox'id='mustChk'/><b> 위 상품 정보 및 거래 조건을 확인하였으며, 구매 진행에 동의합니다.(필수)</b>";
				str +="<p id='err'></p>";
				str +="<input type='button' value='구매하기' onclick=\"insertBuyClass('"+json.cb.cl_idnum+"','"+json.cb.cl_lv+"','"+json.cb.cl_pt+"','"+booleanPoint+"')\">";
				m_contents.append(str);
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
	if(confirm("구매중입니다. 나가시겠습니까?")){
		modal.removeClass('open');			
	}
});// modal mousesdown end
$(document).keydown(function(evt){
	if(evt.keyCode !=27){
		return;
	}else if (modal.hasClass('open')){
		if(confirm("구매중입니다. 나가시겠습니까?")){
			modal.removeClass('open');			
		}
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
		beforeSend : function(xhr){
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},		
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