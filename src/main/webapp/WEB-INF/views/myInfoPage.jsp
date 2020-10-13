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
</style>
<style>
table.type10 {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    margin: 20px 10px;
}
table.type10 thead th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
    background: #e7708d;
    margin: 20px 10px;
}
table.type10 tbody th {
    width: 150px;
    padding: 10px;
}
table.type10 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
}
table.type10 .even {
    background: #fdf3f5;
}
    </style>
    <style>
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
	$('#basic').append("<table class='type10'><thead><tr><th>"+myInfo[0].mb_id+"님의 정보</th><th>내용</th></tr></thead><tbody>"+
			"<tr><th>이름</th><td>"+myInfo[0].mb_name+"<p style='font-size: 13px;'>이름이나 생년월일, 성별 등의 정보가 변경되었다면 본인확인을 통해 정보를 수정할 수 있습니다.<br> 본인확인은 휴대전화를 통해 가능합니다. 정보가 일치 않다면, 휴대전화수정을 진행 후 수정해주세요.</p>"+
			 "<button onclick='info("+myInfo[0].mb_phone+")'>수정하기</button></td></tr>"+
			 "<tr><th class='even'>휴대전화</th><td class='even'><p id='updatePhone'>"+myInfo[0].mb_phone+"</p>"+
			   "<p style='font-size: 13px;'>아이디, 비밀번호 찾기 등 본인확인이 필요한 경우 또는 유료 결제 등 으로부터 알림을 받을 때 사용할 휴대전화입니다.</p>"+
			   "<button onclick='phonebtn()' id='bb'>수정하기</button><p id='ss'></p></td></tr>"+ 
			"<tr><th>계정이메일</th><td><p id='updateEmail'>"+myInfo[0].mb_email+"</p><p  style='font-size: 13px;'>서비스의 변경/종료 등 대부분 안내에 사용할 이메일 주소입니다.</p>"+
			"<button onclick='emailbtn()' id='ee'>수정하기</button><p id='kk11'></p></td></tr>"+
			"<tr><th class='even'>보유포인트</th><td class='even'><p>"+myInfo[0].mb_point+"POINT</p>"+
			   "<p style='font-size: 13px;'>강의등록시 차감되는 포인트 입니다.</p>"+
			   "<button>충전하기</button></td></tr></tbody></table>");
}

function info(phone) {
	var go = confirm("기존 전화번호랑 일치하나요? 맞으면 '확인'  틀리면 '취소'를 눌러주세요");
	if(go){
		$('#basic').css('display','none');
		$('#gosms').css('display','block');
		$('#gosms').append("<table class='type07'><thead><tr><th>"+myInfo[0].mb_id+"의 정보수정</th><th>내용</th></tr></thead><tbody>"+
				"<tr><th>휴대전화 번호</th><td id='phoneNum'>"+myInfo[0].mb_phone+"</td></tr>"+
				"<tr><th>인증하기</th><td><button onclick='send()'>인증하기</button></td></tr></tbody></table>");
	
		
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
       url:"sendSms?to="+$("#phoneNum").text()+"&num="+number,
     success:function(sms){
    	 console.log($("#phoneNum").text());
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
	$('#updateInfo').append("<table class='type07'><thead><tr><th>"+myInfo[0].mb_id+"의 정보수정</th><th>내용</th></tr></thead><tbody>"+
			"<tr><th>이름</th>"+
			"<td><input type='text' id='name'  value='"+myInfo[0].mb_name+"' style='border: solid 1px #fff;' required='required'></td></tr>"+
			"<tr><th>성별</th>"+
			"<td><input type='text' value='"+myInfo[0].mb_gender+"' style='border: solid 1px #fff;' required='required' disabled='disabled'></td></tr>"+
			"<tr><th>학력</th>"+
			"<td><input type='text' value='"+myInfo[0].mb_loe+"' style='border: solid 1px #fff;' required='required' id='loe'></td></tr>"+
			"<tr><th>생년월일</th>"+
			"<td><input type='text' value='"+myInfo[0].mb_rrn+"' style='border: solid 1px #fff;' required='required' id='loe' required='required'></td></tr>"+
			" <tr><th>수정</th>"+
			"<td><button onclick='upbtn()'>수정하기</button><p>*성별과 생년월일은 변경 할 수 없습니다.*</p></td></tr></tbody></table>");
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
		$('#kk11').append("<button onclick='goupemailbtn()'>이메일 수정</button>");
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