<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
	</sec:authorize>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>Insert title here</title>
<script> 

$(function(){     
	//모달박스 해제
	   var $layerWindow=$('#articleView_layer');
	   $layerWindow.find("#bg_layer").on('mousedown',function(evt){
	      console.log(evt);
	      $layerWindow.removeClass('open');
	   }); //on End
	   $(document).keydown(function(evt){
	      console.log(evt);
	      if(evt.keyCode!=27) return;
	      else if($layerWindow.hasClass('open')){
	         $layerWindow.removeClass('open');
	      }
	   }); //keydown End
	   
	});// End
	
</script>

<style>

html, body {
   height: 100%;
   margin: 0
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
   width: 100%;
   height: 100%;
   background: #000;
   opacity: .5;
   filter: alpha(opacity = 50);
   z-index: 100
}

#contents_layer {
   position: absolute;
   top: 40%;
   left: 40%;
   width: 400px;
   height: 400px;
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
  #bg_layer{padding: 50px;} 
        #graph{
            height: 40px;
            background: #ccc; 
            border-radius: 40px;
            width: 300px;
        }
        #graph span{
        display: block;
        padding: 0 10px;
       /*  width: 70%; */
        height: 40px;
        line-height: 40px;
        text-align: right;
        background-color: blueviolet; 
        border-radius: 40px;
        box-sizing: border-box;
        color: #fff;
        animation: stack 2s 1;
        }
        
        aside {
	width: 300px;
	float: left;
}
section {
	width: 1000px;
	float: left;
		position: absolute;
	transform:translate(320px,20px);
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
 
 .button3 {
  background-color: white; 
  color: black; 
  border: 2px solid #f44336;
  margin-top: 8px;
}
.button3:hover {
  background-color: #f44336;
  color: white;
}
 

        
</style>
</head>

<body>
<header>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
<h1>나의 강의 관리</h1>
<div id='comeClass'></div>
<br><br><hr><br><br>
<div id='comeAa'>
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
<p id='comeErr'></p>
</div>

 <div id="articleView_layer">
     				 <div id="bg_layer"></div>
      				<div id="contents_layer"></div>
 			  </div>
 			  
 			  </section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
 			  

<script>
var managerClassList =${manager_classList};
//var sumnum;

if(managerClassList.length !=0){
	console.dir(managerClassList);
	$('#comeClass').append("<table class='table table-hover'><thead style='background-color:silver;'><tr><th>강의명</th><th>난이도</th><th>시작날짜</th><th>종료날짜</th><th>강의계획서</th><th>강좌및과제관리</th><th>수강자관리</th></tr></thead><tbody>");
	for(var i=0; i<managerClassList.length; i++){
		console.log("sumnum= "+managerClassList[i].cl_lcnum);
		//sumnum=managerClassList[i].cl_lcnum;
		var stday =  managerClassList[i].cl_stday.split(" ");
		var fnday = managerClassList[i].cl_fnday.split(" ");
		$('tbody').append("<tr><td>"+managerClassList[i].cl_clname+"</td><td>"+managerClassList[i].cl_lv+"</td><td>"+stday[0]+"</td><td>"+fnday[0]+"</td><td><a onclick=\"openClassPlan('"+managerClassList[i].pc_title+"','"+managerClassList[i].pc_cont+"','"+managerClassList[i].cl_cc+"','"+managerClassList[i].cl_lcnum+"')\">상세보기</a></td><td><a onclick=\"openCoursePage('"+managerClassList[i].cl_lv+"','"+managerClassList[i].cl_idnum+"')\">상세보기</a></td><td><a onclick=\"ajaxaa('"+managerClassList[i].cl_lv+"','"+managerClassList[i].cl_idnum+"','"+managerClassList[i].cl_lcnum+"')\">상세보기</a></td></tr>");
	}                                                                                                                                                                                                
	$('#comeClass').prepend("</tbody></table>");

}else{
	$('#comeClass').append("<p>현재 진행 중인 강의가 없습니다.</p>");
}

function openClassPlan(pc_title,pc_cont,cl_cc,cl_lcnum) {
	 $('#contents_layer').empty();
	 $('#articleView_layer').addClass('open');
	 $('#articleView_layer').addClass('open'); //모달박스 나타남
	    $('#contents_layer').html("<table class='type07'><thead><tr><th>강의계획서</th><th>내용</th></tr></thead>"+
	    		"<tbody><tr><th>개요</th><td>"+pc_title+"</td></tr><tr><th>내용</th><td>"+pc_cont+"LV</td></tr>"+
	    		"<tr><th>관심사</th><td>"+cl_cc+"</td></tr><tr><th>총강좌회차</th><td>"+cl_lcnum+"회차</td></tr></tbody></table>");
	
}
function openCoursePage(cl_lv,cl_idnum) {
	//레벨값,일련번호
	console.log(cl_lv+cl_idnum);
	location.href="selectmanagercoursehomeworkpage/"+cl_idnum;
	

}


function ajaxaa(cl_lv,cl_idnum,cl_lcsum) {
	$.ajax({
		url:'rest/aaList?cl_lv='+cl_lv+'&cl_idnum='+cl_idnum,
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
		success: function(aaList) {
		console.log(aaList);
		$('#ttt').remove();
		$('#comeErr').text("");
		if(aaList.length!=0){
		$('#comeAa').append("<table id='ttt' class='table table-hover'><thead style='background-color:silver;'><tr><th>학생ID</th><th>진도율</th><th>쪽지보내기</th></tr></thead><tbody id='aa'>");
		for(var i=0; i<aaList.length; i++){
			console.log(aaList[i]);
			$('#aa').append("<tr><td>"+aaList[i].aa_id+"</td><td><a onclick=\"openProgress('"+aaList[i].aa_id+"','"+cl_idnum+"','"+cl_lv+"','"+cl_lcsum+"')\">상세보기</a></td><td><a onclick=\"openMsg('"+aaList[i].aa_id+"','"+cl_idnum+"')\">보내기</a></td></tr>");
		}
		$('#comeAa').prepend("</tbody></table>");
		}else{
			$('#comeErr').text("현 수강자가 없습니다.");	
		}
		},
		error: function(err) {
			console.log(err)
			
		}
	});
	
}


function openProgress(id, idnum, lv,cl_lcsum) {
	$.ajax({
		url:'rest/countAt?atd_id='+id+'&atd_idnum='+idnum+'&atd_lv='+lv,
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
		success: function(countAt) {
			var sum = parseInt(cl_lcsum);
			var count =(parseInt(countAt));
			if(count>0){
				count+1;
			}
		console.log(countAt);
		// $('#contents_layer').empty();
		 $('#articleView_layer').addClass('open');
		 var persent =(count/sum)*100;
		 console.log("count:  "+count);
		 console.log("sum:  "+sum);
		 console.log("persent:  "+persent);
		 $('#contents_layer').empty();
		 $('#contents_layer').append(id+"님의 진도율<table><tr><td>"+id+"</td><td></div><div id='graph'><span id='sp'>"+persent+"</span></div></tr></table>");
		 $('#sp').css("width",persent+"%");
		 $('style').append(" @keyframes stack{0%{ width: 0; color: rgba(255, 255, 255, 0);} 50%{ color:  rgba(255, 255, 255, 1); } 100%{  width: "+persent+"%;}}");
		},
		error: function(err) {
			console.log(err)
			
		}
	});
}



function openMsg(aa_id, cl_idnum) {
	
	 $('#articleView_layer').addClass('open');
	 $('#contents_layer').empty();
	 $('#contents_layer').append("<center><h3>"+aa_id+"<br>님 에게 쪽지를 남깁니다.</h3></center>내용입력: <input type='text' name='msg_text' id='msg'><button type='button' class='button3' onclick=\"goMsg('"+aa_id+"')\"'>SEND</button>");
	 $('#contents_layer').append("<input type='hidden' id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>");
}



 function goMsg(aa_id) {
	var msg = $('#msg').val();
	$.ajax({
		url:'rest/sendMsg?receiver='+aa_id+'&msg='+msg,
		type:'GET',
		dataType: 'json',
		beforeSend : function(xhr)
		{
			//이거 안하면 403 error
			//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
		success: function(result) {
			if(result){
			alert('쪽지를 보내는데 성공하셨습니다.');
			}else{
				alert('쪽지를 보내는데 실패하셨습니다. 다시 시도 하세요');
			}
			location.reload();
		},
		error: function(err) {
			console.log(err)
			
		}
	});
	
	$.ajax({
		url:'/h2k5every/prof/rest/sendMsgWeb?receiver='+aa_id+'&msg='+msg,
		type:'GET',
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
		},
		error: function(err) {
			console.log(err)
			
		}
	}); 
	
 }



</script>

</body>
</html>