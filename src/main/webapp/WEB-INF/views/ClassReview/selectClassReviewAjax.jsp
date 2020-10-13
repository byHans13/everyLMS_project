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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.min.js"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.css" />
</head>
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
	box-shadow: 0 1px 0 1px rgba(0, 0, 0, .04);
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

div>#paging {
	text-align: center;
}

#boot {
	background-color: #b3c6ff;
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
		<input type='hidden' id='token' data-token-name='${_csrf.headerName}'
			name='${_csrf.parameterName}' value='${_csrf.token}' /> <input
			type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<form action="reviewselectbtn">
			<table>
				<tr>
					<td width="600px"><select name="search" id="search">
							<option>강의명</option>
							<c:forEach var="Clasc" items="${sList}" varStatus="i">
								<option value="${Clasc.cl_clname}">${Clasc.cl_clname}</option>
							</c:forEach>
					</select>
						<button>검색</button> <!-- 셀렉박스 -->
				</tr>
			</table>
		</form>
		<input type='hidden' value='${Clasc.cl_clname}' id="searchval">
		<div class="container">
			<table class="table table-striped">
				<tr id="boot"align="center">
					<td width="150">수업명</td>
					<td width="150">제목</td>
					<td width="250">작성자</td>
					<td width="250">종강날짜|삭제</td>
				</tr>
				<tbody id="tableShow">
					<c:forEach var="Clasc" items="${cList}">
						<tr height="25">
							<td align="center">${Clasc.cl_clname}</td>
							<td align="center"><a
								href='SelectClassDetail?cob_bonum=${Clasc.cob_bonum}'>${Clasc.cob_title}</a></td>
							<td align="center">${Clasc.cob_id}</td>
							<td align="center">${Clasc.cl_fnday }|<input type='checkbox'
							name="dtncheck" id="btncheck" value='${Clasc.cob_bonum}'
							onclick="doOpenCheck(this)"><input type='hidden' value='${Clasc.cl_clname}'id="schval"></td>
						</tr>
					</c:forEach>
					<!-- 게시판 -->
				</tbody>
			</table>
		</div>
		<div align="center" id="Paging">${Paging}</div>
		<!-- 페이징 -->
		<button class="btn btn-default pull-right" onclick="dtncheck()">삭제</button>
		<div class="search">
			<form action="searchClassreviewDetail">
				<select name="selvalue">
					<option value="searchWriter" selected="selected">작성자</option>
					<option value="searchTitle">제목</option>
					<option value="searchCont">내용</option>
				</select> <input type="text" name="search" placeholder="입력하기" />
				<button>검색</button>
			</form>
		</div>
	</section>
	<footer>
		<jsp:include page="../h2k5every_footer.jsp" />
	</footer>
</body>
<script type="text/javascript">
	function doOpenCheck(chk) {
		var obj = document.getElementsByName("dtncheck");
		console.log(obj);
		for (var i = 0; i < obj.length; i++) {
			if (obj[i] != chk) {
				obj[i].checked = false;
			}
		}
	}
	function dtncheck(click) {
		var confirm_test = confirm("삭제하시겠습니까??");
		var dtnval = $(":input:checkbox[id=btncheck]:checked").val();
		var selval = $('#selval').val();
		var page = $('#page').val();
	   var sch = $('#schval').val();
		console.log(sch);
		var searval = $('#searval').val();
		var json = new Object();
		json.cob_bonum = dtnval;
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : 'rest/cobdelete',
			beforeSend : function(xhr) {
				//이거 안하면 403 error
				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
			contentType : 'application/json; charset=UTF-8',
			data : JSON.stringify(json),
			success : function(data) {
				console.log(data);
				if (confirm_test == true) {
					alert("삭제완료.")
					if (selval == null) {
						location.href = "reviewselectbtn?search=" + sch	+ "&pageNum=" + page + "";
					} else if (selval != null) {
						location.href = "searchClassreviewDetail?selvalue="
								+ selval + "&search=" + searval + "&pageNum="
								+ page + "";
					}
				} else if (confirm_test == false) {
					alert("삭제가 취소되었습니다.")
				}
			}
		})
	}
</script>
</html>