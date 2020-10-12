<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title id='title'></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../resources/js/jquery.serializeObject.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>

<style>
		.totalDiv{
			padding-top: 100px;
            margin:5px;
            border:1px solid black;
            width:1900px;
            height:700px;
            text-align:center;
        }
        .courseVideo{
            border:1px solid black;
            width:1496px;
            height:700px;
            float: left;
        }
        .memoDiv{
            border:1px solid black;
            width:400px;
            height:700px;
            float: left;
            text-align:center;
        }
</style>
</head>
<body>
	<!-- 처음에 올 때 값 회원 아이디, 강좌값 가능  -->
	<div id='totalDiv' class='totalDiv'>
		<div id='courseVideo' class='courseVideo'>
			<video
			id='Lecture' 
			src=''
			width='1500px' 
			height='700px' 
			controls
			controlsList="nodownload"
			autoplay>
			해당 브라우저는 video를 지원하지 않습니다.</video>
		</div>
		<div id='memoDiv' class='memoDiv'>
			<form id='memoFrm' class='memoFrm' name='memoFrm'>
				<input type='hidden' id='token' data-token-name='${_csrf.headerName}' 
						name = '${_csrf.parameterName}' value='${_csrf.token}' >
				<div id='classIdnum'> 
				</div>
			<textarea
			 id='memoZone' name='mo_contents' class='memoZone' 
			 cols='45' 
			 rows='30' 
			 placeholder='메모장입니다.저장을 하시면 "나의메모장"에서 다시 보실 수 있습니다.'></textarea>
			<input type='button' id='memoInsertBtn' value='작성' onclick='insertMemo()'>
			</form>
		</div>

	</div>
</body>
<script>
	
	var video = document.getElementById('Lecture');
	var lInfo = ${LectureInfo};
	var atmk = ${atmk};
	var rt =${restTime}
	lectureStart();
	function lectureStart(){
		console.log(rt);
		$('#classIdnum').html("");
		if(rt==null){
			$('#Lecture').attr("src","../video/"+lInfo[0].fl_sysname); 														
		}else{
			if(rt.rt_restTime != 0){
				if(rt.rt_duration != rt.rt_restTime){
					var min = parseInt(rt.rt_restTime/60);
					var second = parseInt(rt.rt_restTime%60);
					if(min>0){
						var time = min+"분 "+second+"초";
					}else{
						var time = second+"초";
					}
					if(confirm(time+"까지 시청하셨습니다. 이어보시겠습니까?")){
						$('#Lecture').attr("src","../video/"+lInfo[0].fl_sysname+"#t="+rt.rt_restTime); 								
					}else{
						$('#Lecture').attr("src","../video/"+lInfo[0].fl_sysname); 														
					}
				}else{
					if(atmk!=1){
						if(confirm("퀴즈를 풀어야 출석이 인정됩니다. 이동하시겠습니까?")){
							courseQuiz();
						}else{
							alert("강의를 종료하겠습니다.");
							window.close();
						}
					}else{
						alert("atmk=1일경우 다시 처음부터 실행");
						$('#Lecture').attr("src","../video/"+lInfo[0].fl_sysname); 																			
					}
				}
			}else{
				$('#Lecture').attr("src","../video/"+lInfo[0].fl_sysname); //element로 들어간거 확인						
			}
		}
		for(var i in lInfo){
			$('#title').html(lInfo[i].cl_clname+"-"+lInfo[i].fl_num+"강");
			$('#classIdnum').append("<p>강의명: "+lInfo[i].cl_clname+"</p>");
			$('#classIdnum').append("<p>"+lInfo[i].fl_num+"강: "+lInfo[i].co_name+" - 메모장</p>");
			$('#classIdnum').append("<input type='hidden' id='idnum'name='mo_idnum' value='"+lInfo[0].fl_idnum+"'>");
			$('#classIdnum').append("<input type='hidden' id='num' name='mo_num' value='"+lInfo[0].fl_num+"'>");
			$('#classIdnum').append("<input type='hidden' id='lv' name='mo_lv' value='"+lInfo[0].fl_lv+"'>");
		}//for 강의 정보 출력 위한.. 
		selectMemo();
	}//function lectureStart() END
	
	function selectMemo(){
		var obj = $('#memoFrm').serializeObject();
		$.ajax({
			type: 'post',
			url: 'rest/selectMemoForStart',
			data: obj,
			dataType: 'json',
			beforeSend : function(xhr)
			{
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
			success: function(json){
				if(json!=""){
					if(confirm("이전에 저장하신 메모가 있습니다. 출력하시겠습니까?")){
						for(var i in json){
							$('#memoZone').html(json[i].mo_contents);
						}	
					}else{//confirm ==false;
						return;
					}	
				}else{// json ==null
					return;
				}
			},error: function(err){
				console.log(err);
			}
		});//selectMemo ajax END
	}//function selectMemo() END
	
	function insertMemo(){
	var $confirm = confirm("저장하신 값은 덮어쓰기 됩니다. 저장하시겠습니까? ");
	if($confirm == true){	
	var obj = $('#memoFrm').serializeObject();
	$.ajax({
		type: 'post',
		url: 'rest/insertMemoAjax',
		data: obj,
		dataType: 'json',
		async: false,
		beforeSend : function(xhr){
			var $token = $("#token");
			xhr.setRequestHeader($token.data("token-name"), $token.val());
		},
		success: function(json){
			if(json!=null){
				alert("저장에 성공하였습니다.");
			}else{
				alert("저장에 실패했습니다.");
			}
		}, error: function(err){
			console.log(err);
		}
	});//memo Insert ajax END
	}else{
		return;
	}//confirm 
	}//function insertMemo() END
	
	
	video.addEventListener("ended", function(event){	
		if(atmk != 1){
			console.log($('#num').val())
			if($('#num').val()==0){//오리엔테이션의 경우 바로 출석해주려고
				var obj={
					"pb_idnum":$('#idnum').val(),
					"pb_num":$('#num').val(),
					"pb_lv":$('#lv').val()
				};
			console.log(obj);
				$.ajax({
					type:'post',
					url:'rest/insertOrientationAtmk',
					data:obj,
					dataType:'json',
					beforeSend : function(xhr){
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token.val());
					}, 
					success: function(json){
						if(json){
							if(confirm("강의가 종료되었습니다. 나가시겠습니까?")){
								if($('#memoZone').val()!=""){
									insertMemo();		
									window.close();					
								}else{
									window.close();
								}
							}else{
								return;
							}
						}else{
							alert("출석이 되지 않았습니다. 확인 후 관리자에게 문의해주세요.");
						}
					},error: function(err){
						console.log(err);
					}
				});				
			}else{	
				if(confirm("퀴즈를 풀어야 출석이 인정됩니다. 이동하시겠습니까?")){
					courseQuiz();
				}else{
					if(confirm("강의가 종료되었습니다. 나가시겠습니까?")){
						if($('#memoZone').val()!=""){
							insertMemo();		
							window.close();					
						}else{
							window.close();
						}
					}else{
						return;
					}
				}
			}
		}else{
			if(confirm("강의가 종료되었습니다. 나가시겠습니까?")){
				insertMemo();		
				window.close();	
			}else{
				return;
			}
		}
		
		
	});// video END 
	
	$(window).on("beforeunload", function(){
		var obj={
			"rt_idnum":$('#idnum').val(),
			"rt_lv":$('#lv').val(),
			"rt_num":$('#num').val(),
			"rt_restTime":parseInt(video.currentTime),
			"rt_duration":parseInt(video.duration)
		};
		$.ajax({ 
			type:'post',
			url:"rest/insertRestTimeAjax",
			data:obj,
			dataType:'json',
			//async: false,
			beforeSend : function(xhr){
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
			success: function(json){
				console.log(json);
			}, error: function(err){
				console.log(err);
			}
		});
		console.log(obj);
		return "dwqdq";
	});// window beforeunload END
	
	function courseQuiz(){
		var classGson = ${LectureInfo};
		var idnum = classGson[0].fl_idnum;
		var lv = classGson[0].fl_lv;
		var num = classGson[0].fl_num;
    	window.open("selectCourseQuiz?ef_idnum="+idnum+"&ef_lv="+lv+"&ef_num="+num,'_blank','width=800, height=600, top=200, left=200'); 

	}//function courseQuiz() END
</script>
</html>