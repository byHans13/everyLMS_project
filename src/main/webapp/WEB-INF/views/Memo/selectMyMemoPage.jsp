<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<style>
.cS {
	text-align: center;
	top: 30%;
	left: 50%;
	transform: translate(-50%, -50%);
	position: absolute;
	padding: 5px 10px;
}

#memoobj {
	top: 55%;
	left: 50%;
	transform: translate(-50%, -50%);
	position: absolute;
	padding: 5px 10px;
	border-style: solid
}

#updatemymemo {
	top: 90%;
	left: 75%;
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
}
</style>
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
    <input type="hidden" name = "id" id="id" value="${id}" />
	<table>
		<tr>
			<td width="600px"><select name="questType" id="questType">
					<option>----------</option>
					<c:forEach var="Clasc" items="${sList}" varStatus="i">
			<option value = "${Clasc.cl_idnum}">${Clasc.cl_clname}</option>
		</c:forEach>
			</select>
				<button id="clickmymemo" onclick="clickmymemo()">검색</button></td>
		</tr>
	</table>
	<table class="cS" id="cS">
		<tr bgcolor="skyblue" height="30">
			<th width="150">강의명</th>
			<th width="200">강좌명<select id="clname" name="clname"><option
						value="">-------------</option></select></th>
			<th width="150">강의날짜</th>
			<th width="150">메모보기</th>
		</tr>
		<tbody id="tableShow">
			<tr class="cm_tr">
				<th width="150" align=center id="cm_name"></th>
				<th width="150" align=center id="cm_clname"></th>
				<th width="150" align=center id="cm_date"></th>
				<th width="150" align=center id="cm_memo"></th>
			</tr>
		</tbody>
	</table>
	<table>
		<tr>
			<td id="memojang"><textarea rows="20" cols="90" name="memoobj" id="memoobj"> </textarea></td>
		</tr>
	</table>
	<button id="updatemymemo" onclick="updatemymemo()">수정하기</button>
	</section>
	<footer>
		<jsp:include page="../h2k5every_footer.jsp" />
	</footer>
</body>
<script type="text/javascript">
	function clickmymemo(click) {
		var select_sub = $('#questType').val();
		var json = new Object();
		json.cl_idnum = select_sub;
		console.log(json);
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'rest/clickmymemo',
			beforeSend : function(xhr)
   			{
   				//이거 안하면 403 error
   				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
   				var $token = $("#token");
   				xhr.setRequestHeader($token.data("token-name"), $token.val());
   			},
			contentType : 'application/json; charset=UTF-8',
			data : JSON.stringify(json),
			success : function(click) {
				console.log(click);
				$('#clname').children('option').remove();
				$.each(click, function(i) {
					$("#clname").append(
							"<option value='"+click[i].co_name+"'>"
									+ click[i].co_name + "</option>");
				})

			}
		})
	}
	$('#clname').change(
			function() {
				var select_id = $('#id').val()
				var select_sub = $('#clname').val();
				var select_idnum = $('#questType').val();
				var json = new Object();
				json.mo_id = select_id;
				json.co_name = select_sub;
				json.cl_idnum = select_idnum;
				console.log(json);
				$.ajax({
					type : 'post',
					dataType : 'json',
					url : 'rest/memolist',
					beforeSend : function(xhr)
		   			{
		   				//이거 안하면 403 error
		   				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
		   				var $token = $("#token");
		   				xhr.setRequestHeader($token.data("token-name"), $token.val());
		   			},
					contentType : 'application/json; charset=UTF-8',
					data : JSON.stringify(json),
					success : function(result) {
						console.log(result);
						$("#memoobj").val('');
				     	str = "";
						for (i = 0; i < result.length; i++) {
							str += "<th>" + result[i].cl_clname + "</th>";
							str += "<th>" + result[i].co_name + "</th>";
							str += "<th>" + result[i].cl_stday + "</th>";							
							str += "<th ><a href='#;' onclick=\"viewmemo('"
									+ result[i].mo_contents + "')\">메모 보기</a></th>"
									str += "<th><input type='hidden' name='mo_num'id='mo_num' value="+result[i].mo_num+"></th>"
							$("#tableShow").html(str);
						}
						for ( var i in result) {
							$('#memoObj')
									.append(
											'<tr><td>' + result[i].mo_contents
													+ '<td><tr>');
						}
					},
					error : function(request, status, error) {
						alert("code :" + request.status + "\ n" + "message :"
								+ request.responseText + "\ n" + "error :"
								+ error);
					}

				});// ajax
			});
	function viewmemo(memo) {
		console.log(memo);

		$("#memoobj").val(memo);
	}
	function updatemymemo(click) {
		var confirm_test = confirm("수정하시겠습니까?");
		if (confirm_test == true) {
			alert("수정되었습니다.");
			var select_mo_num = $('#mo_num').val();
			var select_mo_id = $('#id').val();
			var select_mocontents = $('#memoobj').val();
			var json = new Object();
			json.mo_num = select_mo_num;
			json.mo_contents = select_mocontents;
			json.mo_id = select_mo_id;
			console.log(json);
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : 'rest/updatemymemo',
				beforeSend : function(xhr)
	   			{
	   				//이거 안하면 403 error
	   				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
	   				var $token = $("#token");
	   				xhr.setRequestHeader($token.data("token-name"), $token.val());
	   			},
				contentType : 'application/json; charset=UTF-8',
				data : JSON.stringify(json),
				success : function(click) {
					console.log("click");
				}
			})
		} else if (confirm_test == false) {
			alert("수정을 취소합니다.")
		}
	}
</script>
</html>