<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
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
	      $('#contents_layer').empty();
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
   overflow: scroll
}
video{
width: 300px;
height: 300px;
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
<h1>강좌</h1>
<div>
<table class="table table-hover">
<thead style="background-color:silver;">
<tr>
<th >회차</th>
<th >강좌명</th>
<th>강좌영상</th>
<th>내용</th>
</tr>
</thead>
<tbody id='coTbody'></tbody>
</table>
</div>
<br>
<h1>과제</h1>
<div>
<table class="table table-hover">
<thead style="background-color:silver;">
<tr>
<th>회차</th>
<th>강좌명</th>
<th>과제</th>
<th>제출날짜</th>
<th>제출현황</th>
</tr>
</thead>
<tbody id='hoTbody'>
</tbody>
</table>
<p style="color: red;">과제 클릭시, 첨부파일이 다운로드 됩니다.</p>
</div>

<form action="inserthomeworkpage" method="post">
<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
</form>



 <div id="articleView_layer">
     	<div id="bg_layer"><input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/></div>
      	<div id="contents_layer"><input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/></div>
 </div>
 </section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
<script>


var courseList =${courseList};
console.dir(courseList);
var subvd="";

 if(courseList!=""){
	 $('#contents_layer').empty();
	for(var i=0; i<courseList.length; i++){
		subvd = courseList[i].fbList[0].fl_subvd;
		
		if(subvd=="course"){//강의파일	
			$('#coTbody').append("<tr><td>"+courseList[i].co_num+"회차</td><td>"+courseList[i].co_name+"</td><td onclick=\"openFiles('"+courseList[i].fbList[0].fl_sysname+"')\">"+courseList[i].fbList[0].fl_oriname+"</td><td>"+courseList[i].co_cont+"</td></tr>");																			
		}
		
		$('#hoTbody').append("<tr id='tr"+i+"'><td>"+courseList[i].co_num+"회차</td><td>"+courseList[i].co_name+"</td>");	
		if(courseList[i].fbList.length>1){
			$('#tr'+i).append("<td><a id='a"+i+"' href='/h2k5every/stud/homeworkFiledown?sysFileName="+courseList[i].fbList[1].fl_sysname+"'></a></td><td id='td"+i+"'></td><td><a onclick=\"openAaList('"+courseList[i].co_lv+"','"+courseList[i].co_idnum+"','"+courseList[i].co_num+"')\">상세보기</td></tr>");
			homeworkList(courseList[i].co_num,courseList[i].co_lv,courseList[i].co_idnum,i);
			
		}else if(subvd != "homework" && subvd =="course"){
			 $('#tr'+i).append("<td><a onclick=\"goInsert('"+courseList[i].co_num+"','"+courseList[i].co_lv+"','"+courseList[i].co_idnum+"')\">과제업로드</a></td><td>-</td><td>-</td></tr>");
		 }

	}//for 
 }//forEnd
	
	function goInsert(num,lv,idnum) {
		//console.log(num+lv+idnum);
		$('form').append("<input type='hidden' name='hw_num' value='"+num+"'><input type='hidden' id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>");
		$('form').append("<input type='hidden' name='hw_idnum' value='"+idnum+"'>");
		$('form').append("<input type='hidden' name='hw_lv' value='"+lv+"'>");
		$('form').submit();	
	}
 
 
 
 
	function homeworkList(num,lv,idnum,i) {
		var arr ;
		var allData = { "hw_num": num, "hw_lv": lv, "hw_idnum" : idnum };
		$.ajax({
			url:'rest/homeworkList',
			type:'POST',
			async: false,
			data: allData,
			dataType: 'json',
			beforeSend : function(xhr)
			{
				//이거 안하면 403 error
				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
			success: function(homeworkList) {
				arr = homeworkList;
				
				console.log(homeworkList[0]);
				var fdate =homeworkList[0].hw_date;
				var d = fdate.split(" ");
				$('#td'+i).text(d[0]);
				$('#a'+i).text(homeworkList[0].hw_hwname);
			},
			error: function(err) {
				console.log(err)
				
			}
		});
		return arr;
		
	}

	function openFiles(sysname) {
		$('#articleView_layer').addClass('open');
		//console.log(sysname);
		$('#contents_layer').append("<video controls='controls' src='../video/"+sysname+"'></video>");

	}
	
	var stList= [];
	function openAaList(cl_lv,cl_idnum,co_num) {
		$.ajax({
			url:'rest/aaList?cl_lv='+cl_lv+'&cl_idnum='+cl_idnum,
			type:'GET',
			async: false,
			dataType: 'json',
			beforeSend : function(xhr){
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
			success: function(aaList) {
				if(aaList.length != 0){
				console.log(aaList);
				$('#contents_layer').empty();
				$('#articleView_layer').addClass('open');
				for(var i=0; i<aaList.length; i++){
					stList[i]=aaList[i].aa_id;
				}
				
				sendHW(cl_lv,cl_idnum,co_num);
				
				}else{
					$('#contents_layer').empty();
					$('#articleView_layer').addClass('open');
					$('#contents_layer').append("<p>수강자가 없습니다.</p>");
				}
				
			},
			error: function(err) {
				console.log(err)
				
			}
		});
		 
	}
	
			
			function sendHW(lv, idnum, num) {
		
				$.ajax({
					url:'rest/stHWList?hw_lv='+lv+'&hw_idnum='+idnum+'&hw_num='+num,
					type:'GET',
					async: false,
					dataType: 'json',
					 contentType: "application/x-www-form-urlencoded; charset=UTF-8",

					beforeSend : function(xhr)
					{
						//이거 안하면 403 error
						//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token.val());
					},
					success: function(stHWList) {
						//console.log('hw_lv= '+lv+',hw_idnum= '+idnum+',hw_num= '+num);
						//console.log(stHWList);
						console.log("stHWList: "+stHWList);
						console.log("stList: "+stList);
						var number=0;
						$('#contents_layer').empty();
						$('#contents_layer').append(" <table class='table table-hover'><thead style='background-color:silver;'><tr><th>수강자</th><th>제출여부</th><th>결과</th></tr></thead><tbody id='tb'>");
						if(stHWList.length!=0){
						for(var i in stList){
							for (var j in stHWList){
								if(stList[i]==stHWList[j]){
									//$('#tb').append("<tr><td>"+stHWList[j]+"</td><td>O</td><td><a href='#' id = 'goHwResult' onclick=\"document.getElementById('goHwResult2').submit();\" data-lv='"+lv+" 'data-idnum='"+idnum+" 'data-num='"+num+" 'data-id='"+stHWList[j]+"')\">상세보기</a></td></tr>");
									$('#tb').append("<tr><td>"+stHWList[j]+"</td><td>O</td><td><a onclick=\"goHwResult('"+lv+"','"+idnum+"','"+num+"','"+stHWList[j]+"')\">상세보기</a></td></tr>");
									console.log($('#goHwResult').data('lv'));
									number = i;
								}
							}
							if(number != i){
								$('#tb').append("<tr><td>"+stList[i]+"</td><td>-</td><td>-</td></tr>");
							}
						}
						}
						
						if(stHWList.length==0){
							for(var z=0; z<stList.length; z++){
							$('#tb').append("<tr><td>"+stList[z]+"</td><td>-</td><td>-</td></tr>");
						}
						}
						
						
						
						
						
					},
					error: function(err) {
						console.log(err)
						
					}
				});
				
			}
	
	
function goHwResult(lv, idnum, num, id) {
		console.log(lv, idnum, num, id);
		
		location.href="selectHwResultPage/"+lv+"/"+idnum+"/"+num+"/"+id;
		
		
	} 
	
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