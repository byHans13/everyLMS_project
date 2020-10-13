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
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" ></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<style>
select {  
  font-family: "Noto Sansf KR", sans-serif;
  font-size: 1rem;
  font-weight: 400;
  line-height: 1.5;
  
  color: #444;
  background-color: #fff;
  
  padding: .6em 1.4em .5em .8em;
  margin: 0;
  
  border: 1px solid #aaa;
  border-radius: .5em;
  box-shadow: 0 1px 0 1px rgba(0,0,0,.04);
}

select:hover {
    border-color: #888;
}

select:focus {
    border-color: #aaa;
    box-shadow: 0 0 1px 3px rgba(59, 153, 252, .7);
    box-shadow: 0 0 0 3px -moz-mac-focusring;
    color: #222;
    outline: none;
}

select:disabled {
  opacity: 0.5;
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
}
#boot {
      background-color: #b3c6ff;
    }
</style>
</head>
<body>
<header>
		<jsp:include page="../h2k5every_header.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../h2k5every_aside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />
    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
	<h2>${id}</h2>
	<select class="celect_box"id="classList" name="classList">
		<option id="color">---------------</option>
		<c:forEach var="Clasc" items="${sList}" varStatus="i">
			<option id="color"value = "${Clasc.cl_clname}">${Clasc.cl_clname}</option>
		</c:forEach>
	</select>
	<div class="container">
	<table class="table table-striped">
		<tr bgcolor="skyblue" height="30" id="boot">
			<th width="150">회차</th>
			<th width="100">수업이름</th>
			<th width="100">수강여부</th>
			<th width="100">퀴즈갯수</th>
		</tr>
		<tbody id="tableShow" > </tbody>
	</table>
	</div>
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
             if(result == 0){
            	 alert("강의 준비중입니다.");
             }else{            	
				for (var i in result) {
					str += "<tr><th>" + result[i].co_num + "</th>";
					str += "<th>" + result[i].co_name + "</th>";
					  if(result[i].atd_atmk == 1){
			               str += "<th>수강완료</th>";                  
			               }else{                  
			               str += "<th>미수강</th>";
			               }
					str += "<th>" + result[i].pb_pbnum +"</th></tr>";
					$("#tableShow").html(str);
             }
         }
				$("#tableShow").append(
						"<button class='btn btn-default'><a href='classHome?cl_idnum="+result[i].cl_idnum+"&cl_lv="+result[i].cl_lv+"'>강의실로 이동</a></button>");
				
         },error : function (request, status, error) {
             alert ( "code :"+ request.status + "\ n"+ "message :"+ request.responseText + "\ n"+ "error :"+ error);}
      });// ajax
   });
$(function() {
	  var select = $("select#color");

	  select.change(function() {
	    var select_name = $(this).children("option:selected").text();
	    $(this).siblings("label").text(select_name);
	  });
	});
</script>



</html>