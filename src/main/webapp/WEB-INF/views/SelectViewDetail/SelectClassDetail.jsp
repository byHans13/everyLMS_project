<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src = "../ckeditor/ckeditor.js"></script>
<style type="text/css">
#boot {
      background-color: #b3c6ff;
    }

textarea {
	width: 98%;
	resize: none;
}
      header {
	/* background-color: gray; */
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
	transform:translate(300px,0px)
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
			<input type='hidden' id='token' data-token-name='${_csrf.headerName}'
			name='${_csrf.parameterName}' value='${_csrf.token}' /> <input
			type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="container">
		<table  class="table table-striped">
			<c:forEach var="CourseBoard" items="${cblist}">
				<tr height="30">
					<td width="100" id="boot" align="center"><h2>강의일련번호</h2></td>
					<td><h2>${CourseBoard.cob_idnum}</h2><input type="hidden" id="cobidnum" value="${CourseBoard.cob_idnum}"></td>
					<td width="100" id="boot" align="center"><h2>강의회차</h2></td>
					<td><h2>${CourseBoard.cob_num}</h2><input type="hidden" id="cobnum" value="${CourseBoard.cob_num}"><input type="hidden" id="coblv" value="${CourseBoard.cob_lv}"></td>
				</tr>
				<tr height="30">
					<td id="boot" align="center"><h2>아이디</h2></td>
					<td width="150"><h2>${CourseBoard.cob_id}</h2></td>
					<td id="boot" align="center"><h2>날짜</h2></td>
					<td width="150"><h2>${CourseBoard.cob_date}</h2></td>
				</tr>
				<tr>
					<td id="boot" style="text-align:center;" width="100" ><h2>TITLE</h2></td>
					<td colspan="5"width="150"style="text-align:center;"><h2>${CourseBoard.cob_title}</h2></td>
				</tr>
				<tr height="30">
					<td id="boot" align="center" colspan="5"><h2>CONTENTS</h2></td>
				</tr>
				<tr>
					<td colspan="5" rowspan="15" style="text-align: center;height=100%;"><h2>${CourseBoard.cob_cont}</h2></td>
					</tr>
			</c:forEach>
		</table>
		</div>
		<div class="container">
			<table id="rTable" class="table table-striped"Style="margin-left: 30px;">
				<c:forEach var="Reply" items="${rList}">
					
				</c:forEach>
			</table>
		</div>
 	<form name="rFrm" id="rFrm">
			<table>
				<tr>
					<td width="120%"align="left"><textarea rows="3"cols="50" name="cr_reply"
							id="cr_reply"></textarea></td>
					<td><input type="button" class="btn btn-danger" value="댓글전송" onclick="replyinsert();"
						style="width: 100; height: 50px;"></td>
			</table>
		</form> 
	</section>
</body>
<script>
$(function(){
	commentList();
});

function commentList(){
	var cob_bonum ='<%=(String) session.getAttribute("cob_bonum")%>';
	var id ='<%=(String) session.getAttribute("id")%>';
	var json = new Object();
	 json.cob_bonum = cob_bonum;
	 console.log(json);
		$.ajax({
			type : 'POST',
			url : 'rest/replyselect',
			beforeSend : function(xhr)
   			{
   				//이거 안하면 403 error
   				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
   				var $token = $("#token");
   				xhr.setRequestHeader($token.data("token-name"), $token.val());
   			},
			contentType : 'application/json; charset=UTF-8',
			data : JSON.stringify(json),
			success : function(data) {
				console.log(data);
				var rlist = '';
				for (var i = 0; i < data.length; i++) {
					rlist += '<tr height="25" align="center">'
						+ '<td width="100"><h2>' + data[i].cr_id  + '</h2></td>'
						+ '<td width="200"><h2>' + data[i].cr_reply   + '</h2></td>'
						+ '<td width="100"><h2>' + data[i].cr_date
						+ '</h2></td></tr>';
				}
				console.log("1=", data);
				$('#rTable').html(rlist);
				$('#r_contents').val('');
				$('#r_contents').focusin();
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
function replyinsert(){
	var cr_bonum ='<%=(String) session.getAttribute("cob_bonum")%>';
	var cr_idnum = $('#cobidnum').val();
		var cr_lv= $('#coblv').val();
			var cr_num= $('#cobnum').val();
	var cr_id ='<%=(String) session.getAttribute("id")%>';
		var cr_Reply = $('#cr_reply').val();
		var json = new Object();
		json.cr_idnum = cr_idnum;
		json.cr_lv = cr_lv;
		json.cr_num = cr_num;
		json.cr_id = cr_id;
		json.cr_bnum = cr_bonum;
		json.cr_Reply = cr_Reply;
		console.log(json);
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'rest/replyinsert',
			beforeSend : function(xhr)
   			{
   				//이거 안하면 403 error
   				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
   				var $token = $("#token");
   				xhr.setRequestHeader($token.data("token-name"), $token.val());
   			},
			contentType : 'application/json; charset=UTF-8',
			data : JSON.stringify(json),
			success : function(data) {
				if (data == 1) {
					$('#rTable').val('');
					$('#cr_reply').val('');
					commentList();
				}
			}
		});
	}
</script>
</html>
