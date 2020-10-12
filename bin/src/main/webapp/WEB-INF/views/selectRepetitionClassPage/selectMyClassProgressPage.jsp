<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<style>
.cS {
	text-align: center;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	position: absolute;
	padding: 5px 10px;
}

#goselectclasshome{
text-align: center;
	top: 70%;
	left: 700px;
	transform: translate(-50%, -50%);
	position: absolute;
	padding: 5px 10px;
}
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
	position: absolute;
	transform:translate(300px,0px);
}

</style>
</head>
<body>
<header>
		<jsp:include page="../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../h2k5every_aside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />
    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>${id}</h2>
	<select id="classList" name="classList"
		style="width: 70px; height: 50px">
		<c:forEach var="Clasc" items="${sList}" varStatus="i">
			<option value = "${Clasc.cl_clname}">${Clasc.cl_clname}</option>
		</c:forEach>
	</select>
	<table class="cS" style="margin:auto; text-align:center;">
		<tr bgcolor="skyblue" height="30">
			<th width="150">회차</th>
			<th width="100">수업이름</th>
			<th width="100">수강여부</th>
			<th width="100">퀴즈여부</th>
		</tr>
		<tbody id="tableShow"> </tbody>
	</table>
	</section>
	<footer>
		<jsp:include page="../h2k5every_footer.jsp" />
	</footer>
</body>


<script type="text/javascript">
$('#classList').change(function() {
      var select_sub = $('#classList').val();
      var json = new Object();
      json.cl_clName = select_sub;
      console.log(select_sub);
      $.ajax({
         type:'post',
         dataType:'json',
         url:'rest/selectClassListAjax',
         beforeSend : function(xhr)
			{
				//이거 안하면 403 error
				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
         contentType:'application/json; charset=UTF-8', 
         data: JSON.stringify(json),
         success:function(result){
             console.log(result);
             
             $('#cl_idnum').children('a').remove();
             str = "";
				for (var i in result) {
					str += "<tr><th>" + result[i].co_num + "</th>";
					str += "<th>" + result[i].co_name + "</th>";
					str += "<th>" + result[i].at_atmk+"</th>";
					str += "<th>" + result[i].pb_pbnum +"</th></tr>";
					$("#tableShow").html(str);
         }
				$("#tableShow").append(
						"<button name='goselectclasshome' style='margin:auto; float:right;'><a href='selectClassHomePage?cl_idnum="+result[i].cl_idnum+"'>강의들으러가기</a></button>");
         },error : function (request, status, error) {
             alert ( "code :"+ request.status + "\ n"+ "message :"+ request.responseText + "\ n"+ "error :"+ error);}
      });// ajax
   });

</script>



</html>