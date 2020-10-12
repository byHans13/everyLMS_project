<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>아이디 찾기</title>
 <style>
        hr{
          background-color:#FFD9FA;
          height:1px;
          width: 800px;
          float: left;
        }
        p{
		 font-size: 50px;
		         
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
    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<h3>아이디 찾기</h3>
	<br>
	<hr>
		<div id="idlist" >
			<h1>${List}</h1>
		</div>
	<hr>
	<br>
	<br>
		<a href="gologinpage">
		<button type="button" style="width: 400px; height: 50px; font-size: 35px; color:white;
										 background-color: #C98AFF; border: 1px #5D5D5D;">로그인</button>
		</a>
		<a href="gomemberjoinpage">
			<button type="button" style="width: 400px; height: 50px; font-size: 35px; color:white;
										 background-color: #C98AFF; border: 1px #5D5D5D;">회원가입</button>
		</a>	
</div>
<script>
$(document).ready
(function() {
	
	var idList = ${idList};
	console.log(idList);
	console.log(idList.length);

	if(idList.length>0){
		for(var i=0; i<idList.length; i++ ){
			$("#idlist").append("<p><b>아이디 : "+idList[i]+"</b></p>");
		}
	}
});
</script>
</body>
</html>