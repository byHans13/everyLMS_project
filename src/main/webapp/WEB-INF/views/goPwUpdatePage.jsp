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
 <style>
        hr{
          background-color:#FFD9FA;
          height:1px;
          width: 800px;
          float: left;
        }
        p{
		 font-size: 20px;
		         
        }
        a{
          text-decoration:none;
        }
 </style>
</head>
<body>
	<a href="/h2k5every/"><img src="upload/h2k5_mainLogo.PNG" id="mainlogo" width="200"></a>
	<h1 align="center" style="font-size:50px;"><font color="navy"><b>오픈플랫폼</b></font></h1><br>
	
	<div style="margin-left: 550px;">
	<h3>비밀번호 변경</h3>
	<span style="font-size: 13px;">비밀번호를 변경해 주세요. 다른 아이디나 사이트에서 사용한 적 없는 안전한 비밀번호로 변경해 주세요.</span>
	<hr>
	<form action="PwUpdate" onsubmit="return check();" method="post">
	    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
		<div id="idlist" >
		</div>
		<div>
			<table>
				<tr>
					<td>비밀번호 입력: <input type="password" style="width:170px" id="pw" name="mb_pw" maxlength="12" placeholder="새 비밀번호"></td>
				</tr>
				<tr>
					<td>비밀번호 확인: <input type="password" style="width:170px" id="checkpw" maxlength="12" placeholder="새 비밀번호 확인"></td>
				</tr>
			</table>			
		</div>
	<hr>
	<br>
	<br>
		<button style="width: 400px; height: 50px; font-size: 35px; color:white;
										 background-color: #C98AFF; border: 1px #5D5D5D;">확인</button>
</form>
</div>
<script>
$(document).ready
(function() {
	
	var msg= '${msg}';
		
	if(msg!=""){
		alert(msg);
	}
	
	var idList = ${idList};
	console.log(idList);
	console.log(idList.length);

	if(idList.length>0){
		for(var i=0; i<idList.length; i++ ){
			$("#idlist").append("<p><b>아이디 : "+idList[i]+"</b></p>");
			$("#idlist").append("<input type='hidden' name='mb_id' value='"+idList[i]+"'>");
		}
	}
});


	function check() {
		
		var re = /^[a-zA-Z0-9]{4,12}$/;

		var pw = document.getElementById("pw");
		var checkpw = document.getElementById("checkpw");
		
		if(!pwCheck(re,pw,"패스워드는 4~12자의 영문 대소문자와 숫자로만 입력")) {
	          return false;
	      }
		if(checkpw.value==""){
			alert("변경할 비밀번호를 한번 더 입력해주세요.");
			checkpw.focus();
			return false;
		}
		
		if(pw.value!=checkpw.value){
			alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
			checkpw.value = "";
			checkpw.focus();
			return false;
		}
	}
	
	function pwCheck(re, what, message) {
	       if(re.test(what.value)) {
	           return true;
	       }
	       alert(message);
	       what.value = "";
	       what.focus();
	       return false;
	   }
</script>

</body>
</html>