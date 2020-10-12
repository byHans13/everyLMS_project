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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="//www.google.com/jsapi"></script>
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
.menu{
    margin-left: 20px;
    text-align:center;
    width: 200px;
    border: 1px black solid;
    float: left;
}
table{
	width: 1100px;
	margin:auto;
 	/* border: 1px solid black;  */
	border-collapse: collapse;
	text-align: center;
}
th, td {
	font-size: 30px;
	/* border: 1px solid black; */
}
td{
	/*  border: 1px solid black;  */
	height: 60px;
}
.b{
	font-size: 30px;
}

</style>
</head>
<body>
<input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	
	<header>
		<%-- <%@ include file="h2k5every_header.jsp"%><!-- 정적인 방식 --> --%>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	
	<div style="height: 50px;"></div>
	
	<section id="section" style="margin-left: 20px;">
		<div style="background-color: #409cff; height: 80px; ">
		<div style="height: 5px;"></div>
			<h1 id="cmt" style="color: white; font-size: 35px;"></h1>
		</div>
		<div style="height: 50px;"></div>
		<div style="width: 1000px; height: 100px; overflow: auto;background-color: #EBF5FF;">
			<div style="width: 120px ; height: 98px; float: left;">
				<div style="width: 118px;height: 2px;"></div>
				<b style="font-size: 24px;">&nbsp;문제번호 : </b>
			</div>
			<div id="pbnum" style="width: 758px ; height: 98px; float: left;">
				<!-- <div style="width: 75px; text-align: center; float: left;"><b class="b">1</b></div> -->
			</div>
			<div style="width: 120px ; height: 98px; float: left;"></div>
		</div>
				
			<div style="height: 50px;"></div>
	<div style="width: 500px; display: inline-block;">	
		<div id="pbview" style=" display: none; ">
			<div id="pbbox"></div><div id="percentage" style="float: left; display: none;"></div>
		</div>

		<br><br>
			<div id="pbview2" style="display: none;">
		</div>
	</div>
	<div style="display: inline-block;">
		<div id="Bnt" style="display: none;">	
			<button type="button" class="btn btn-primary" id="modal_show">선택비율 보기</button>
			<div id="LRbtn" style="display: inline;"></div>
		</div>
	</div>
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-title" id="exampleModalLabel"><b style="font-size: medium;">통계</b></span>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="modalbodyhtml">
              		그래프 띄울곳
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
  

    
	</section>
		
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
<script>

var qlist=${qlist};
var dtlist=${dtlist};
var co_name='${co_name}';
var pbmaxnum= qlist.length;
var dtmaxnum= dtlist.length;
var arr1=null; 
var arr2=null; 
	console.log(qlist);
	console.log(dtlist);
	console.log(pbmaxnum);
	console.log(dtmaxnum);
	
	$("#cmt").html(co_name+" -정답률");
	
	 for(var i=0; i<pbmaxnum; i++){
		 $("#pbnum").append("<div style='width: 75px; text-align: center; float: left;'>"+
		 					"<button type='button' class='btn btn-primary' onclick='pbnumclick("+i+")'><b class='b'>"+(i+1)+"</b></button></div>");
	 }
	 /* 선택비율 및 정답률 오답률 그래프 */
	 var pb_idnum;
	 var pb_pbnum;	 
	 
	 
	 function pbnumclick(a) {
		$("#pbview").css("display","block");
		$("#pbbox").html("");
		$("#pbview2").html("");
		$("#pbview2").css("display","block");
		
		console.log(a);
		
		if((a+1)==pbmaxnum){
			/* $("#Bnt").append("<button id='gobackbtn' type='button' class='btn btn-primary' onclick='pbnumclick("+(a+1)+")'>다음</button>"); */		
			$("#LRbtn").html("");
			$("#nextbtn").css("display","none");
			$("#LRbtn").append("<button id='gobackbtn' type='button' class='btn btn-primary' onclick='pbnumclick("+(a-1)+")'>이전</button>");		
		}
		else if(a==0){
			$("#LRbtn").html("");						
			$("#gobackbtn").css("display","none");						
			$("#LRbtn").append("<button id='nextbtn' type='button' class='btn btn-primary' onclick='pbnumclick("+(a+1)+")'>다음</button>");		
		}else if(a!=0 && (a+1)!=pbmaxnum){
			$("#LRbtn").html("");
			$("#LRbtn").append("<button id='gobackbtn' type='button' class='btn btn-primary' onclick='pbnumclick("+(a-1)+")'>이전</button>");
			$("#LRbtn").append("<button id='nextbtn' type='button' class='btn btn-primary' onclick='pbnumclick("+(a+1)+")'>다음</button>");
		}
		
		var cnt =a+1; 
		pb_idnum = qlist[a].pb_idnum;
		pb_pbnum = qlist[a].pb_pbnum;
		
		console.log("a의 값 :"+a);
		console.log("문제지문 :"+qlist[a].pb_pbname);				
		$("#pbbox").append("<h1>"+qlist[a].pb_pbname+"</h1><br><br>");
		console.log("문제답 :"+qlist[a].pb_pbexplain);
		$("#pbview2").append("<h1>정답 : "+qlist[a].pb_pbexplain+"</h1>");
			
		for(var i=0; i<dtmaxnum;i++) {
			
			if(cnt==dtlist[i].dp_pbnum){
				console.log("문제번호 :"+dtlist[i].dp_pbnum);
				console.log("문제보기번호 :"+dtlist[i].dp_pbexmnum);
				console.log("문제보기 :"+dtlist[i].dp_pbexm);
				$("#pbbox").append("<h2>"+dtlist[i].dp_pbexmnum+".  "+dtlist[i].dp_pbexm+"</h2>");
				
			}
	}	
	 $("#Bnt").css("display","block");
	 Percentage(pb_idnum,pb_pbnum);
}

	 
	 function Percentage(pb_idnum,pb_pbnum) {
		 	
		 	
			console.log(pb_idnum);
			console.log(pb_pbnum);
			
			var pbexmcnt=0;
			
			$.ajax({
				type:'post',
				url:'rest/selectPercentage?pbidnum='+pb_idnum+"&pbnum="+pb_pbnum,
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
					var maxcnt=json.length;
					var	answercnt=2;
					for(var i=0; i<dtlist.length;i++){
						
						if(pbexmcnt<dtlist[i].dp_pbexmnum){
							pbexmcnt = dtlist[i].dp_pbexmnum
							console.log("문제번호 길이  :"+pbexmcnt);
						}
					}
					//pb_answerchk
					for(var i=0; i<answercnt; i++){
						window['awnum'+i] = 0;
						window['awnm'+i] = i+'률';
						for(var j=0; j<json.length;j++){
							if(i==json[j].pb_answerchk){
							eval("awnum"+i+"++");
							
							}
						}
					}
					var	awname0 = awnm0.replace( /0/gi, '오답');
					var	awname1 = awnm1.replace( /1/gi, '정답');
					
					
					for(var j=0;j<pbexmcnt;j++){
						
						window['pbnum'+j] = 0;
						window['pbname'+j] = (j+1)+"번";
						for(var i=0; i<maxcnt;i++){
							if(j+1==json[i].pb_pbstudent){
							eval("pbnum"+j+"++");
							
							}
						}
						
					}
					var Arr1= new Array(pbexmcnt)
					var Arr2= new Array(pbexmcnt)
					
					for(var i=0;i<Arr1.length;i++){
						Arr1[i]= Math.round((eval("pbnum"+i)/maxcnt)*100);
						Arr2[i]= eval("pbname"+i);
						
					}
					console.log(Arr1);
					console.log(Arr2);
					var gg1=0;
					var gg2=0;
					var arr=new Array(1);
					for(var i=0;i<arr.length;i++){
						arr[i]=new Array(pbexmcnt+1);
						arr[0][0]=["번호","퍼센트"];
						for(var j=1;j<arr[0].length;j++){
								arr[i][j]=[Arr2[gg1++], Arr1[gg2++]];
						}
					}
					gg1=1;
					gg2=1;
					
					Awrr1= new Array(answercnt);
					Awrr2= new Array(answercnt);
					
					
					for(var i=0;i<Awrr1.length;i++){
						Awrr1[i]= Math.round((eval("awnum"+i)/maxcnt)*100);
						Awrr2[i]= eval("awname"+i);
					}
					
					var awrr=new Array(1);
					for(var i=0;i<awrr.length;i++){
						awrr[i]=new Array(answercnt+1);
						awrr[0][0]=["백분율", "%"]
						for(var j=1;j<awrr[0].length;j++){
							awrr[i][j]= [Awrr2[gg1--],Awrr1[gg2--]];
						}
					}
					
					arr1=arr;
					arr2=awrr;
						console.log(awrr);
						console.log(arr1);
					//choesPercentage
				 
						console.log(awname0+Math.round((awnum0/maxcnt)*100));
						console.log(awname1+Math.round((awnum1/maxcnt)*100));
					
						console.log(pbname0+Math.round((pbnum0/maxcnt)*100));
						console.log(pbname1+Math.round((pbnum1/maxcnt)*100));
						console.log(pbname2+Math.round((pbnum2/maxcnt)*100));
						console.log(pbname3+Math.round((pbnum3/maxcnt)*100));
						
						//Math.round();
					
				},
				error: function (err) {
					console.log(err);
				}
				
			});// ajax 이용 백분률 구성
			
}
	 
 	$("#modal_show").click(function() {
		console.log(arr1);
		console.log(arr1[0]);
		
		var jsonStr1 =JSON.stringify(  arr1[0] );
		var jsonStr2 =JSON.stringify(  arr2[0] );
		
		$("#exampleModal").modal("show");
		//ajax로 html이용 페이지 불러오기  
			$.ajax({
				type:'get',
				url:'rest/ansserPercentage',
				data:{choice:jsonStr1,answer:jsonStr2},
				datatype:'html', 
				beforeSend : function(xhr)
				{
					//이거 안하면 403 error
					//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
					var $token = $("#token");
					xhr.setRequestHeader($token.data("token-name"), $token.val());
				},
				
				success: function (data) {
					console.log(data);
					$('#modalbodyhtml').html(data);
					$('#modalbodyhtml').append("<input type='hidden' id='token'  data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />");
					
				},
				error: function (err) {
					console.log(err);
				}
				
		 	});  
		
	}); 
	     
 	$("#close_modal").click(function() {
		$("#exampleModal").modal("hide");
	});			

</script>
</body>
</html>