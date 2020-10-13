<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<title>Insert title here</title>
</head>
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
 table, thead{
    border: 1px solid black;
    margin: auto;
    padding: 1px;
    border-collapse: collapse;
    width: 900px;
    height: 30px;
    text-align: center;
}
th{
    border: 1px solid black;
    margin: auto;
    padding: 1px;
    border-collapse: collapse;
    font-size: large;
    text-align: center;
} 
td{
    border: 1px solid black;
    margin: auto;
    padding: 1px;
    border-collapse: collapse;
    font-size: x-large;
    text-align: center;
}
#articleView_layer {
	display: none;
	position: fixed;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%
}

#articleView_layer.open {
	display: block;
	color: red;
}

#articleView_layer #bg_layer {
	position: absolute;
	top: 0;
	left: 0;
	width: 140%;
	height: 140%;
	background: #000;
	opacity: .5;
	filter: alpha(opacity = 50);
	z-index: 100
}
#certiImg{
	position: absolute;
	top: 30%;
	left: 35%;
	width: 600px;
	height: 600px;
	margin: -150px 0 0 -194px;
	padding: 28px 28px 0 28px;
	border: 2px solid #555;

}
#contents_layer {
	position: absolute;
	top: 40%;
	left: 40%;
	width: 800px;
	height: 800px;
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
#adTitle{
    color: cornflowerblue;
}
</style>
<body>
<h1>SelectLectureConfirm</h1>
<header>
		<%-- <%@ include file="h2k5every_header.jsp"%><!-- 정적인 방식 --> --%>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_adminAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
		<span><hr style="border: solid 2px cornflowerblue;"><h3 id="adTitle">등록대기강의</h3><hr style="border: solid 2px cornflowerblue;"></hrcolor></span>
		<div style="height: 100px;"></div>
		<div id="certiDiv">
			<table id="infoTable">
			<thead>
			<tr>
			 <th>아이디</th>
			 <th>강의명</th>
			 <th>강의기간</th>
			 <th>강의자료</th>
			 <th colspan="2">수락 여부 </th>
			</tr>
			</thead>
			<tbody></tbody>
			</table>
			</div>
		<div id="articleView_layer">
		<div id="bg_layer"></div>
		<div id="contents_layer"></div>
	</div>
	</section>

	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
		<input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
</body>
<script type="text/javascript">
$(document).ready(function() {
	$(function (){
		//모달박스 해제
		var $layerWindow=$('#articleView_layer');
		$layerWindow.find("#bg_layer").on('mousedown',function(evt){
			console.log(evt);
			$layerWindow.removeClass('open');
			location.reload();
		});
		$(document).keydown(function(evt) {
			console.log(evt);
			if(evt.keyCode!=27) return;
			else if($layerWindow.hasClass('open')){
				$layerWindow.removeClass('open');
				location.reload();
			}
		});//keydown End
		}); // ready 함수 //ready 안에 function 집어넣으면 시작하자마자 바로 실행
	   $.ajax({
  			type:'post',
  			url:'rest/selectlectureconfirm',
  			beforeSend : function(xhr)
  			{
  				//이거 안하면 403 error
  				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
  				var $token = $("#token");
  				xhr.setRequestHeader($token.data("token-name"), $token.val());
  			},
  			success: function (json) {
  				if(json != ""){
  				console.log(json);
  				console.log("json[0]", json[0]);
  				for(var i=0;i<json.length;i++){
  					var str = "";
  					str += "<tr><td>"+json[i].mb_id+"</td><td>"+json[i].cl_clname+"</td>";
  					str += "<td>"+json[i].cl_stday+"~"+json[i].cl_fnday+"</td>";
  					str += "<td><a href='#'"+json[i].mb_id+" class='selectClass' value='"+json[i].cl_idnum+","+json[i].co_lv+"'>보러 가기</td>";
  					str += "<td><button class='lectureConfirm' value='"+json[i].cl_idnum+","+json[i].co_lv+"'>"+"확인"
						+"</button></td><td><button id='lectureReject'>"+"거절"+"</button></td></tr>";
				$('tbody').append(str);
  				}
  			
  			}else{
  			   alert("등록 대기 강의가 없습니다.");
  			 $("#certiDiv").css('border','1px solid black');
  			 $("#certiDiv").css('border-collapse','collapse');
  			 $("#certiDiv").css('text-align','center');
  			 $("#certiDiv").css('font-size','50px');
  			 $("#certiDiv").css('color','skyblue');
  			   var str="";
  			   str += "수락할 강의가 없습니다."
  			   $("#certiDiv").html(str);
  		   }
  		
  			},
  			error: function (err) {
  				console.log(err);
  			}
  			
  		});//ajax
	
	   
});
	var datasize;

$(document).on("click"," .selectClass",function(){
	var aaa=$(this).attr('value');
	console.log(aaa);
	var str=aaa.split(",");
	var cl_idnum=str[0];
	var co_lv=str[1];
	console.log(cl_idnum);
	console.log(co_lv);
	$('#articleView_layer').addClass('open');
	$.ajax({
		type:'post',
		url:'rest/selectlecturedata?cl_idnum='+cl_idnum+'&co_lv='+co_lv,
		//data:data, //spring에서 bNum 받아와야함
		dataType:'json', //생략가능
		beforeSend : function(xhr)
			{
				//이거 안하면 403 error
				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
		success:function(data){
			datasize=data.length;
			console.log(data);
				var str="";
				str += "<table><tr><td >강의명</td><td>"+data[0].cl_clname+"</td>";
				str += "<td>강의 Point</td><td>"+data[0].cl_pt+"</td></tr>";
				str += "<tr><td>강의 기간 </td><td>"+data[0].cl_stday+"~"+data[0].cl_fnday+"</td>";
				str += "<td>분야</td><td>"+data[0].cl_cc+"</td></tr>";
			for(var i=0; i<data.length;i++){
				str += "<tr><td>회차 번호</td><td>"+data[i].co_num+"</td>";
				str += "<td>강의 이름</td><td class='lectureVideo' value='"+i+"'>"+data[i].co_name+" 클릭시 재생</td></tr>";
				str += "<tr id='ltv"+i+"' style= 'display: none ' > <td colspan='4'   ><video autoplay controls src='../video/"+data[i].fl_sysname+"'>형식에 맞지 않았습니당.</video></td></tr>";
				str += "<tr ><td colspan='4'>강좌 설명</td></tr><tr><td colspan='4'>";
				str += data[i].co_cont+"</td></tr>";
				}		
				str +="</table>";
				$("#contents_layer").html(str);
		},
		error:function(err){
			console.log(err);
		}
		});//ajax end	
});// end
$(document).on("click"," .lectureVideo",function(){
	    var aaa=$(this).attr('value');
			$("#ltv"+aaa).css('display','table-row');
	    $("#ltv"+aaa).click(function(){
	    	$("#ltv"+aaa).css('display','none');
	    });
	
});


$(document).on("click",".lectureConfirm",function(){
	var aaa=$(this).attr('value');
	console.log(aaa);
	var str=aaa.split(",");
	var cl_idnum=str[0];
	var co_lv=str[1];
	console.log(cl_idnum);
	console.log(co_lv);
	$.ajax({
		type:'post',
		url:'rest/selectlectureconfirmyes?cl_idnum='+cl_idnum+'&co_lv='+co_lv,
		//data:data, //spring에서 bNum 받아와야함
		dataType:'json', //생략가능
		beforeSend : function(xhr)
			{
				//이거 안하면 403 error
				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
		success:function(data){
			console.log(data);
			alert("수락이 완료되었습니다.");
			location.reload();
		},
		error:function(err){
			console.log(err);
		}
		});//ajax end
	
	
});



</script>
</html>