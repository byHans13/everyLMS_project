
'5'
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	  <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<style>
table,tr{
    border: 1px solid black;
    margin: auto;
    padding: 1px;
    border-collapse: collapse;
    width: 750px;
    height: 30px;
}
td{
    border: 1px solid black;
    margin: auto;
    padding: 1px;
    border-collapse: collapse;
    font-size: x-large;
}
</style>
<body>
	<h1>Register to Profession</h1>
	<form enctype="multipart/form-data" action="register?${_csrf.parameterName }=${_csrf.token}" id="register" method="post">
		<input type="hidden" id="token" data-token-name="${_csrf.headerName}"
			name="${_csrf.parameterName}" value="${_csrf.token}" />
		<table>
			<tr>
				<td>아이디 :</td>
				<td>${mList[0].mb_id }<br></td>
			</tr>
			<tr>
				<td>이메일 :</td>
				<td>${mList[0].mb_email }<br></td>
			</tr>
			<tr>
				<td>핸드폰</td>
				<td>${mList[0].mb_phone }<br>
				</td>
			</tr>
			<tr>
				<td>학력</td>
				<td>${mList[0].mb_loe }<br>
				</td>
			</tr>
			<tr>
			<td>
			인증번호 적기 : 
			</td>
			<td>
			<input type="text" name="ct_prof"><input type="button" value="인증번호 확인">
			</td>
			</tr>
			<tr>
			<td>프로필 올리기</td>
			<td> <input type="file" id="profileFile" name="files1">
			<input type="hidden" id="fileCheck1" name="fileCheck1" value="0">
			<input type="hidden" id="ctf_check1" name="ctf_check1" value="0"></td>
			
			
			</tr>
			<tr>
			<td>교수 인증서 올리기</td>
			<td><input type="file" id="profCerti" name="files2">
			<input type="hidden" id="fileCheck2" name="fileCheck2" value="0">
			<input type="hidden" id="ctf_check2" name="ctf_check2" value="1">
			</tr>
			<tr>
				<td>강사 이력 적기</td>
				<td><textarea rows="4" cols="50" name="ct_cont"></textarea></td>
			</tr>
		</table>
		<input type="hidden" name="ct_id" value="${mList[0].mb_id }">
		<input type="hidden" name="ct_id" value="${mList[0].mb_id }">

		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button>등록하러 가기</button>

	</form>

</body>

<script>
	console.log('${mList}');
	$('#reset').on('click',function(){
		$('#fileCheck1').val(0);
		$('#fileCheck2').val(0);
	});
		$('#profileFile').on('change',function(){
			console.dir(this);
			console.dir(this.value);
			if($(this).val()==''){
				console.log("empty");
				$('#fileCheck1').val(0);  //첨부안됨
			}else{
				console.log("not empty");
				$('#fileCheck1').val(1); //첨부됨
			}
			console.log($('#fileCheck1').val());
		});
		$('#profCerti').on('change',function(){
			console.dir(this);
			console.dir(this.value);
			if($(this).val()==''){
				console.log("empty");
				$('#fileCheck2').val(0);  //첨부안됨
			}else{
				console.log("not empty");
				$('#fileCheck2').val(1); //첨부됨
			}
			console.log($('#fileCheck2').val());
		});
		$(document).ready
		(function() {
			
		var ctf_check=[];
		ctf_check.push({ctf_check : $('#ctf_check1').val()});
		ctf_check.push({ctf_check : $('#ctf_check2').val()});
		console.log(ctf_check);
		var aaa=JSON.stringify(ctf_check);
		console.log(aaa);
		//document.getElementById("ctf_check").value=ctf_check;
		document.getElementById("ctf_check").value=aaa;
		
			
		});
</script>
</html>