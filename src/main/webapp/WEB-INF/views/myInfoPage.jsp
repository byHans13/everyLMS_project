<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
.menu{
    margin-left: 20px;
    text-align:center;
    width: 200px;
    border: 1px black solid;
    float: left;
}
</style>
<style>
        #myInfo {
            width: 1000px;
            height: 600px;
            display: block;
            color: black;

        }

        #myin {
            width: 100%;
            border: 1px solid #8A0886;
            border-collapse: collapse;
        }

        #myin .tdd {
            border-top: 1px solid #8A0886;
        }

        #myin th {
            border: 1px solid #8A0886;
        }

        #myin td {
            padding: 10px;
        }
    </style>
</head>
<body>
<script>
</script>
<header>
	<jsp:include page="h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
</header>
<aside>
	<jsp:include page="h2k5every_aside.jsp" />
</aside>
<section id="section" style="margin-left: 20px;">
		<div id='myinfo' >
		<center><div id='basic' style="display: block;"></div></center>
		<center><div id='gosms' style="display: none;"></div></center>
		<center><div id='updateInfo' style="display: none;"></div></center>
		</div>
		<a href='/h2k5every/stud/goLoginFrm'><button>홈으로</button></a>
</section>
<footer>
	<jsp:include page="h2k5every_footer.jsp" />
</footer>
	
<script>
</script>

<script>
var myInfo = ${myInfo};

console.dir(myInfo);
if(myInfo.length == 0){
	alert('회원정보를 가져올 수 없습니다. 다시 시도해 주세요.');
	location.href = 'goLoginFrm';
	
}else{
	
	$('#basic').append("<p><b>"+myInfo[0].mb_id+"</b>의 정보입니다.</p>"+
			"<center><table id='myin'>"+
			"<tr><th rowspan='4'>이름</th></tr>"+
			"<tr><td class='tdd'>"+myInfo[0].mb_name+"</td></tr>"+
			"<tr><td style='font-size: 13px;'> 이름이나 생년월일, 성별 등의 정보가 변경되었다면 본인확인을 통해 정보를 수정할 수 있습니다.<br> 본인확인은 휴대전화를 통해 가능합니다. 정보가 일치 않다면, 휴대전화수정을 진행 후 수정해주세요.</td></tr>"+
			"<tr><td><button onclick='info("+myInfo[0].mb_phone+")'>수정하기</button></td></tr>"+
			"<tr><th rowspan='4'>휴대전화</th></tr>"+
			"<tr><td class='tdd' id='updatePhone'>"+myInfo[0].mb_phone+"</td></tr>"+
			"<tr><td style='font-size: 13px;'> 아이디, 비밀번호 찾기 등 본인확인이 필요한 경우 또는 유료 결제 등 으로부터 알림을 받을 때 사용할 휴대전화입니다.</td></tr>"+
			"<tr><td id='ss'><button onclick='phonebtn()' id='bb'>수정하기</button></td></tr>"+
			"<tr><th rowspan='4'>계정이메일</th></tr>"+
			"<tr><td class='tdd' id='updateEmail'>"+myInfo[0].mb_email+"</td></tr>"+
			"<tr><td style='font-size: 13px;'>서비스의 변경/종료 등 대부분 안내에 사용할 이메일 주소입니다.</td></tr>"+
			"<tr><td id='kk'><button onclick='emailbtn()' id='ee'>수정하기</button></td></tr>"+
			"<tr><th rowspan='4'>보유포인트</th></tr>"+
			"<tr><td class='tdd'>"+myInfo[0].mb_point+"POINT</td></tr>"+
			"<tr><td style='font-size: 13px;'>강의등록시 차감되는 포인트 입니다.</td></tr>"+
			"<tr><td><button>충전하기</button></td></tr></table></center>");
}

function info(phone) {
	var go = confirm("기존 전화번호랑 일치하나요? 맞으면 '확인'  틀리면 '취소'를 눌러주세요");
	if(go){
		$('#basic').css('display','none');
		$('#gosms').css('display','block');
		$('#gosms').append("<p><b>myInfo.mb_id</b>의 휴대전화 번호입니다.</p>"+
				"<input type='text' readonly value='"+myInfo[0].mb_phone+"' id='phoneNum'>"+
				"<p style='font-size: 10px;'>'인증하기' 버튼을 클릭해주세요.</p>"+
				"<button onclick='send()'>인증하기</button><br>");
		
	}else{
		alert('전화번호를 수정합니다.');
		phonebtn();
	}
	
}


function send() {
	 var number;
	  number = Math.floor(Math.random() * 100000) + 100000;
   if(number>100000){
      number = number - 10000;
   }
   $.ajax({
	   //
	  // var to = $("#phoneNum").val('01023829403');
       url:"sendSms?to="+$("#phoneNum").val()+"&num="+number,
     success:function(sms){
			if(sms!='1'){
				alert("해당 휴대폰으로 인증번호에 실패하셨습니다. 다시시도해주십시오");
			}else if(sms=='1'){
				alert("해당 휴대폰으로 인증번호를 발송했습니다");
				number=number;
				$('#gosms').append("<input type='text' placeholder='인증번호' id='f'><button onclick='gonum("+number+")'>확인</button>");
			}
       },
       error: function(err) {
		}
       
    });
}

function gonum(number) {
	var mynum = $('#f').val();
	console.log("mynum: "+mynum);
	console.log("number: "+number);
	if(mynum==number){
		alert("휴대폰 인증에 성공하셨습니다.");
		update();
	}else{
		alert("휴대폰 인증번호가 일치하지 않습니다. 다시시도해주십시오");
	}
}

function update() {
	$('#basic').css('display','none');
	$('#gosms').css('display','none');
	$('#updateInfo').css('display','block');
	$('#updateInfo').append("<p><b>myInfo.mb_id</b>의 개인정보 수정입니다.</p>"+
			"<table><tr><th>이름</th><td><input type='text' value='"+myInfo[0].mb_name+"' id='name'></td></tr>"+
			"<tr><th>성별</th><td><input type='text' value='"+myInfo[0].mb_gender+"' readonly></td></tr>"+
			"<tr><th>학력</th><td><input type='text' value='"+myInfo[0].mb_loe+"'  id='loe'></td></tr>"+
			"<tr><th>생년월일</th><td><input type='text' value='"+myInfo[0].mb_rrn+"' readonly></td></tr>"+
			"<tr><th></th><td><button onclick='upbtn()'>수정하기</button></td></tr></table><br>*성별과 생년월일은 변경 할 수 없습니다.*");
}


	function upbtn() {
		var name = $('#name').val();
		var loe = $('#loe').val();
		console.log("name: "+name);
		console.log("loe: "+loe);
		 $.ajax({
		      url:"rest/updateMyinfo?name="+name+"&loe="+loe,
		     success:function(result){
		    	 console.log("res: "+result);
					if(result=="ok"){
						console.log("r: "+result);
						alert("정보 수정에 성공하셨습니다.");
						location.reload();
					}else{
						console.log("re: "+result);
						alert("정보 수정에 실패하셨습니다.");
					}
		       },
		       error: function(err) {
				}
		       
		    });
	}
	
	function phonebtn() {
		$('#updatePhone').text("");
		$('#updatePhone').append("<input type='number' id='upPhone'>");
		$('#upPhone').focus();
		$('#bb').remove();
		$('#ss').append("<button onclick='goupphonebtn()'>번호 수정</button>");
	}
	
	function goupphonebtn() {
		var phone = $('#upPhone').val();
		 $.ajax({
		      url:"rest/goupphone?phone="+phone,
		     success:function(result){
		    	 console.log("result: "+result);
					if(result){
						//console.log("r: "+result);
						alert("번호수정에 성공하셨습니다.");
					}else{
						//console.log("re: "+result);
						alert("번호 수정에 실패하셨습니다.");
					}
					location.reload();
		       },
		       error: function(err) {
				}
		       
		    });
		
	}
	
	function emailbtn() {
		$('#updateEmail').text("");
		$('#updateEmail').append("<input type='text' id='upEmail'>");
		$('#upEmail').focus();
		$('#ee').remove();
		$('#kk').append("<button onclick='goupemailbtn()'>이메일 수정</button>");
	}
	
	function goupemailbtn() {
		var email = $('#upEmail').val();
		 $.ajax({
		      url:"rest/goupemailbtn?email="+email,
		     success:function(result){
		    	 console.log("result: "+result);
					if(result){
						//console.log("r: "+result);
						alert("이메일수정에 성공하셨습니다.");
					}else{
						//console.log("re: "+result);
						alert("이메일 수정에 실패하셨습니다.");
					}
					location.reload();
		       },
		       error: function(err) {
				}
		       
		    });
		
	}
	
	








</script>

</body>
</html>