<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>아이디 비밀번호찾기</title>
<style>
	.inpbtn{
		font-size: 30px;
		color:white;
		background-color: #C98AFF;
		border: 1px #5D5D5D;
	}
	.wep{
		margin-left: 550px;
	}
  	hr{
        background-color:#FFD9FA;
        height:1px;
        width: 800px;
        float: left;
    }	
</style>
</head>
<script>
$(document).ready
(function() {
	
	var msg= '${msg}';
	
	if(msg!=""){
		alert(msg);
	}
	
});
</script>
<body>
	<a href="/h2k5every/"><img src="upload/h2k5_mainLogo.PNG" id="mainlogo" width="200"></a>
	<h1 align="center" style="font-size:50px;"><font color="navy"><b>오픈플랫폼</b></font></h1>
	<div style="margin-left: 750px;">
		<input class="inpbtn" style="width: 200px; height: 50px;" type="button" onclick="click1()" value="아이디찾기"> 
		<input class="inpbtn" style="width: 200px; height: 50px;" type="button" onclick="click2()" value="비밀번호찾기">
	</div>
	<br><br>
	<div id="id" class="wep">
	<b>본인 확인 이메일로 인증</b><br>
	<span style="font-size: 13px;">본인 확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</span>
	<br>
	<hr>
	<br>
	
		<div>
		<h3>아이디 찾기</h3>
		<br>
		<form action="idChecknumConfirm" onsubmit="return check();" method="post">
		<input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
		    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
			<table>
				<tr>
					<td>이름:</td>
					<td><input type="text" id="e_name" name="e_name"></td>
				</tr>
				<tr>
					<td>이메일:</td>
					<td><input type="text" id="e_email" name="e_email">  <input type="button" onclick="checkNumSend()" value="인증번호발송"></td>
				</tr>
				<tr>
					<td>인증번호:</td>
					<td><input type="text" id="checknum" name="e_checknum"> <input type="submit" value="인증번호확인"></td>
				</tr>
			</table>
		<div id="dice"></div>
		</form>
		<br><hr>
		</div>
	</div>
	
	
	
	<div id="pw" class="wep" style="display: none">
		<b>본인 확인 이메일로 인증</b><br>
	<span style="font-size: 13px;">본인 확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</span>
	<br>
	<hr>
	<br>
	
		<div>
		<h3>비밀번호 찾기</h3>
		<br>
		<form action="pwChecknumConfirm" onsubmit="return check2();" method="post">
		   <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
			<table>
				<tr>
					<td>아이디:</td>
					<td><input type="text" id="e_id" name="e_id"></td>
				</tr>
				<tr>
					<td>이메일:</td>
					<td><input type="text" id="e_email1" name="e_email"> <input type="button" onclick="checkNumSend1()" value="인증번호발송"></td>
				</tr>
				<tr>
					<td>인증번호:</td>
					<td><input type="text" id="checknum1" name="e_checknum"> <input type="submit" value="인증번호확인"></td>
				</tr>
			</table>
		<div id="dice1"></div>
		</form>
		<br><hr>
		</div>
	</div>
	
<script>

	var dice = 0;
	
	var checknum = document.getElementById("checknum");
	var ename = document.getElementById("e_name");
	var eemail = document.getElementById("e_email");
	var eemail1 = document.getElementById("e_email1");
	var eid = document.getElementById("e_id");

	function check() {
		
	       if(ename.value=="") {
	           alert("이름을 입력해 주세요.");
	           ename.focus();
	           return false;
	       }
		
	    if(eemail.value==""){
	    	alert("등록한 이메일을 입력 하세요.");
	    	eemail.focus();
		 	return false;
	    }   
	       
		if(dice==0){
		 	alert("인증번호를 받으세요.");
		 	return false;
		}
		
		if(checknum.value==""){
		 	alert("인증번호를 입력 하세요.");
		 	checknum.focus();
		 	return false;
		}
	}
	
	function check2() {
		
        if(eid.value=="") {
            alert("아이디를 입력해 주세요.");
            eid.focus();
            return false;
        }

	    if(eemail1.value==""){
	    	alert("등록한 이메일을 입력 하세요.");
	    	eemail.focus();
		 	return false;
	    }   

		if(dice==0){
		 	alert("인증번호를 받으세요.");
		 	return false;
		}
		
		if(checknum1.value==""){
		 	alert("인증번호를 입력 하세요.");
		 	checknum.focus();
		 	return false;
		}
	}eemail1
	
	function checkNumSend1() {
		$.ajax({
			type:'post',
			url:'rest/checkNumSend?email='+eemail1.value,
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
				for( i in json){
					alert("인증번호가 발송 되었습니다.");
					console.log(json[i]);
					for(j in json[i]){
					console.log(json[i][j]);
					$("#dice1").append("<input type='hidden' name='e_checknum2' value='"+json[i][j]+"'>");
					}
				}
				dice = 1;
			},
			error: function (err) {
				console.log(err);
			}
			
			
		});
	}
	
	function checkNumSend() {
		$.ajax({
			type:'post',
			url:'rest/checkNumSend?email='+eemail.value,
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
				for( i in json){
					alert("인증번호가 발송 되었습니다.");
					console.log(json[i]);
					for(j in json[i]){
					console.log(json[i][j]);
					$("#dice").append("<input type='hidden' name='e_checknum2' value='"+json[i][j]+"'>");
					}
				}
				dice = 1;
			},
			error: function (err) {
				console.log(err);
			}
			
			
		});
	}	
	
	function click1() {
		$("#pw").css("display","none");
		$("#id").css("display","block");
	}
	
	function click2() {
		$("#id").css("display","none");
		$("#pw").css("display","block");
	}

</script>
</body>
</html>