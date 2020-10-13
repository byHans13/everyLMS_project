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
table,th,td{
border: 1px solid black;
border-collapse: collapse;
}

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
   /* overflow: scroll */
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

img{
	width: 100px;
	height: 100px;
}
table{
	text-align: center;
}
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
			    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
			    <div id='classOpen'></div>
				<div id='main' style="display: none"></div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>


<div id="articleView_layer">
     <div id="bg_layer"></div>
     <div id="contents_layer"></div>
</div>

<script>
var cl ='${cl_ct}';
var cl_ct = parseInt(cl);
console.log(cl_ct);
openClass(cl_ct);




function openClass(cl_ct) {
	console.log("cl_ct: "+ cl_ct);
	if(cl_ct=='1'){
		$('#classOpen').append("<p style='text-align:center;'>관리자가 검토중입니다.</p>");
	}
	$.ajax({
		url:'rest/classListVal?cl_ct='+cl_ct+'&${_csrf.parameterName }=${_csrf.token}',
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
		success: function(classList) {
			if(classList.length !=0){
			$("#classOpen").append('<table style="border: solid 1px;" class="table table-hover">');
			$('table').append('<thead style="background-color:silver;"><tr><th>강의명</th><th>강의 시작일</th><th>강의 종료일</th><th>강의 회차</th><th>강의 가격</th><th>관심분야</th><th>강의 계획서</th><th>썸네일</th><th>MY강좌</th></tr></thead><tbody>');
			for(var i=0; i<classList.length; i++){
				console.log("classList[i].pi_pisysname: "+ classList[i].pi_pisysname);
				var st = classList[i].cl_stday.split(" ");
				var fn = classList[i].cl_fnday.split(" ");
				if(classList[i].pc_title==undefined){
				 $('tbody').append("<tr><td>"+classList[i].cl_clname+"</td><td>"+st[0]+"</td><td>"+fn[0]+"</td><td>"+classList[i].cl_lcnum+"</td><td>"+classList[i].cl_pt+"</td><td>"+classList[i].cl_cc+"</td><td><a id='go"+i+"'>쓰기</a></td>"
				 +"<td><img src=\"../picture/"+classList[i].pi_pisysname+"\"></td><td>강의계획서를 작성후에 볼 수 있습니다.</td></tr></tbody></table>");
				 $('#go'+i).attr("href","insertplanclasspage/"+classList[i].cl_idnum+"/"+classList[i].cl_clname+"/"+classList[i].cl_lcnum+"/"+classList[i].cl_lv);
				
				}else{
					//console.log(classList[i].pc_cont);
					$('tbody').append("<tr><td>"+classList[i].cl_clname+"</td><td>"+st[0]+"</td><td>"+fn[0]+"</td><td>"+classList[i].cl_lcnum+"</td><td>"+classList[i].cl_pt+"</td><td>"+classList[i].cl_cc+"</td><td><a href='#' onclick=\"articleView('"+classList[i].cl_clname+"','"+classList[i].cl_lv+"','"+classList[i].pc_title+"','"+classList[i].pc_cont+"','"+classList[i].cl_lcnum+"','"+classList[i].cl_idnum+"')\">보기</a></td>"+"<td><img src=\"../picture/"+classList[i].pi_pisysname+"\"></td><td><a href='coursePage/"+classList[i].cl_lv+"/"+classList[i].cl_idnum+"/"+classList[i].cl_lcnum+"'>보기</a></td></tr></tbody></table>");	     
						}//end
				} 
			}else if(classList.length ==0){
				$('#classOpen').append("<p style='text-align:center;'>강의가 존재하지 않습니다.</p>");
			}
		},
		error: function(err) {
			console.log(err)
			
		}
	});
}


function articleView(clname, lv, title, cont, lcnum, idnum){
	var pc_cont = cont.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
	var clNumber = parseInt(lcnum);
	console.log(clNumber);
	   $('#articleView_layer').addClass('open'); //모달박스 나타남
		    $('#contents_layer').html("<table class='type07'><thead><tr><th>타이틀</th><th>내용</th></tr></thead>"+
		    		"<tbody><tr><th>강의명</th><td>"+clname+"</td></tr><tr><th>강의레벨</th><td>"+lv+"LV</td></tr>"+
		    		"<tr><th>제목</th><td>"+title+"</td></tr><tr><th>내용</th><td>"+pc_cont+"</td></tr>"+
		    		"<tr><th>MY강좌</th><td><a href='coursePage/"+lv+"/"+idnum+"/"+lcnum+"'>보기</a></td></tr>"+
		    		"<tr><th>계획서 수정</th><td><a id='uppc' onclick=\"updateplan('"+clname+"','"+lv+"','"+title+"','"+cont+"','"+lcnum+"','"+idnum+"')\">수정</a></td></tr></tbody></table>");
		    
	}//end
	
	
	function updateplan(clname, lv, title, cont, lcnum, idnum) {
		var plandata = {
				clname : clname,
				lv : lv,
				title : title,
				cont : cont,
				lcnum : lcnum,
				idnum : idnum };
		
		var obj = JSON.stringify(plandata);
					
		console.log(typeof(obj));
		console.log(obj);
		location.href="updateplanclasspage/"+obj+"/";
		
		
	}
	
	$('#htmlNowClass').click(function() {
		$('#main').css('display','inline');
		$('#selDiv').css('display','none');
		//classuploadmanagerpage
		$.ajax({
			url:'classuploadmanagerpage',
			type:'GET',
			//async: false,
			dataType: 'html',
			beforeSend : function(xhr)
			{
				//이거 안하면 403 error
				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
			success: function(classuploadmanagerpage) {
				$('#main').empty();
				$('#main').append(classuploadmanagerpage);
				$('#main').append("<input type='hidden' id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>");
				
			},
			error: function(err) {
				console.log(err)
				
			}
		});
		
	});
	
	
	$('#insertClass').click(function() {
		$('#main').css('display','inline');
		$('#selDiv').css('display','none');
		$.ajax({
			url:'classUploadPage',
			type:'GET',
			//async: false,
			dataType: 'html',
			beforeSend : function(xhr)
			{
				//이거 안하면 403 error
				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
			success: function(classUploadPage) {
				$('#main').empty();
				$('#main').append(classUploadPage);
				$('#main').append("<input type='hidden' id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>")
				
			},
			error: function(err) {
				console.log(err)
				
			}
		});
		
	});




</script>




<script>
function test(id) {
	$.ajax({
		type:'get',
		url:'rest/selectConcern',
		datatype:'json',
		beforeSend : function(xhr)
		{
			//이거 안하면 403 error
			//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
		success: function (json) {
			console.log(json);
			console.log(json.length);
		
			for(var i=0; i<json.length; i++){
				$('#menu').append("<div class='menu'><p>"+json[i]+"</p></div>");
			}
			
		},
		error: function (err) {
			console.log(err);
		}
		
	});
} 

	$(function() {
		var id= "${id}";
		console.log(id);
		test();
		
	});
	
	
	$(function() {
		var msg= "${msg}";
		console.log("msg: "+msg);
		if(msg!=""){
			alert(msg);
		}
	});
	

	
</script>

</body>
</html>