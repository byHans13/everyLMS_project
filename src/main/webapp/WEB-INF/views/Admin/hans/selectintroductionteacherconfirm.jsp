<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    request.setCharacterEncoding("UTF-8");
%>
      <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>

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
    width: 750px;
    height: 30px;
    text-align: center;
}
th{
    border: 1px solid black;
    margin: auto;
    padding: 1px;
    border-collapse: collapse;
    font-size: x-large;
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
</head>
<body>
<script>
$(document).ready
(function() {
	var id = "${id}";
	console.log(id);
	 if (id != ""){
		$("#goAdminLoginPage").append("<p style='margin-top: auto;'><b><a href='goTeacherLoginFrm' style='color: white; '>강사페이지이동</a></b></p>");
	} 
	
});</script>
	<header>
		<%-- <%@ include file="h2k5every_header.jsp"%><!-- 정적인 방식 --> --%>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_adminAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
		<span><hr style="border: solid 2px cornflowerblue;"><h3 id="adTitle">강사 등록 대기자<hr style="border: solid 2px cornflowerblue;"></h3></span>
		<div style="height: 100px;"></div>
		<div id="certiDiv">
			<table id="infoTable">
			<thead>
			<tr>
			 <th>아이디</th>
			 <th>강사소개서</th>
			 <th>강사자격증</th>
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
var ct_id=[];
$(document).ready(function() {
	$(function (){
		//모달박스 해제
		var $layerWindow=$('#articleView_layer');
		$layerWindow.find("#bg_layer").on('mousedown',function(evt){
			console.log(evt);
			$layerWindow.removeClass('open');
		});
		$(document).keydown(function(evt) {
			console.log(evt);
			if(evt.keyCode!=27) return;
			else if($layerWindow.hasClass('open')){
				$layerWindow.removeClass('open');
			}
		});//keydown End
		}); // ready 함수 //ready 안에 function 집어넣으면 시작하자마자 바로 실행
	   $.ajax({
  			type:'get',
  			url:'rest/selectprofconfirm',
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
  				console.log(json[0].ct_prof);
  				for(var i=0; i<json.length;i++){
  				ct_id[i]=json[i].ct_id;
  				var ct_prof=json[i].ct_prof;
  				console.log("ct_prof",ct_prof);
  				console.log(ct_id);
  				//$('tbody').append("<tr><td>"+json[i].ct_id+"</td>"+"<td><a href='#"+json[i].ct_id+"'class='intro' id="+json[i].ct_id+" onclick='selectIntroduction("+ct_id+")' value='"+json[i].ct_id+"'>"+json[i].ct_id+" 님의 강사소개서"+"</a></td>"+"<td><a href='#'><input type='hidden' id='ct_id"+i+"' name='ctf_check1' value='0'>"+json[i].ct_prof+"</a></td>"+"<td><button>"+"확인"+"</button></td><td><button>"+"거절"+"</button></td></tr>");
  			 	$('tbody').append("<tr><td>"+json[i].ct_id+"</td>"+"<td><a href='#"+json[i].ct_id+"' class='intro' id="+json[i].ct_id
  						+" value='"+json[i].ct_id+","+json[i].ct_prof+"'>"+json[i].ct_id+" 님의 강사소개서"+"</a></td>"+"<td><a href='#"
  						+json[i].ct_id+"' class='certi'  value='"+json[i].ct_id+","+json[i].ct_prof+"'><input type='hidden' id='ct_id"+i
  						+"' name='ctf_check1' value='0'>"+json[i].ct_prof+"</a></td>"+"<td><button id='certiConfirm' value='"+json[i].ct_id+","+json[i].ct_prof+"'>"+"확인"
  						+"</button></td><td><button id='certiReject'>"+"거절"+"</button></td></tr>");
  				$('#ct_id'+i).val(ct_id);
  				console.log("ct_id",$('#ct_id'+i).val()); 
  				
  				
  				}
  			}else{
  			   alert("강사 지원자가 없습니다.");
  			 $("#certiDiv").css('border','1px solid black');
  			 $("#certiDiv").css('border-collapse','collapse');
  			 $("#certiDiv").css('text-align','center');
  			 $("#certiDiv").css('font-size','50px');
  			 $("#certiDiv").css('color','skyblue');
  			   var str="";
  			   str += "수락할 대상이 없습니다."
  			   $("#certiDiv").html(str);
  		   }
  		
  			},
  			error: function (err) {
  				console.log(err);
  			}
  			
  		});
	
	   
});

$(document).on("click","#certiConfirm",function(){
	var aaa=$(this).attr('value');
	console.log(aaa);
	var str=aaa.split(",");
	var mb_id=str[0];
	var ct_prof=str[1];
	console.log(mb_id);
	console.log(ct_prof);
	$.ajax({
		type:'post',
		url:'rest/insertyesconfirm?mb_id='+mb_id+'&ct_prof='+ct_prof,
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
			reloadStart();
		
		},
		error:function(err){
			console.log(err);
		}
		});//ajax end
	
		
		
	
});

function reloadStart(){
	location.reload();
}






$(document).on("click",".certi",function(){
	var aaa=$(this).attr('value');
	console.log(aaa);
	var str=aaa.split(",");
	var mb_id=str[0];
	var ct_prof=str[1];
	console.log(mb_id);
	console.log(ct_prof);
	$('#articleView_layer').addClass('open');
	$.ajax({
		type:'post',
		url:'rest/selectcertification?mb_id='+mb_id+'&ct_prof='+ct_prof,
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
			str = "";
			str += "<div><img id='certiImg' src='../profCerti/"+data[0].ctf_sysname+"'> </div>";
			$("#contents_layer").html(str);
		
		},
		error:function(err){
			console.log(err);
		}
		});//ajax end
		
});





$(document).on("click",".intro",function(){
	var aaa=$(this).attr('value');
	console.log(aaa);
	var str=aaa.split(",");
	var mb_id=str[0];
	var ct_prof=str[1];
	console.log(mb_id);
	console.log(ct_prof);
	$('#articleView_layer').addClass('open');
	$.ajax({
		type:'post',
		url:'rest/selectintroduction?mb_id='+mb_id+'&ct_prof='+ct_prof,
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
			console.log(data[0].mb_email);
			console.log(data.length);
			console.log("howo",data[0].cc_cc.length);
			for(var i=0; i<data.length;i++){
			var str="";
			str += "<table><tr><td rowspan='3'colspan='2' ><img src=\"../profCerti/"+data[i].ctf_sysname+"\""+"></td>";
			str += "<td>강사 수강증 번호</td><td>"+data[i].ct_prof+"</td></tr>";
			str += "<tr><td>아이디 </td><td>"+data[i].mb_id+"</td></tr><tr><td>이름</td><td>"+data[i].mb_name+"</td></tr>";
			str += "<tr><td>이메일</td><td>"+data[i].mb_email+"</td><td>핸드폰번호</td><td>"+data[i].mb_phone+"</td></tr>";
			str += "<tr><td>학력</td><td>"+data[i].mb_loe+"</td><td>분야</td><td>";
			for(var j=0;j<data[i].cc_cc.length;j++){
				str += " "+data[i].cc_cc[j]+" ";
			}
			str += "</td><tr><td colspan='4'>강의 이력</td></tr><tr><td colspan='4'>"+data[i].ct_cont+"</td></tr></table>";
			$("#contents_layer").html(str);
			}
		},
		error:function(err){
			console.log(err);
		}
	});//ajax end 
	
});	

	
	
	


</script>
</html>