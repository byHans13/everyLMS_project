<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="../resources/js/jquery.serializeObject.js"></script>
    

    <style>
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
						name = '${_csrf.parameterName}' value='${_csrf.token}' >
<h2>${id}</h2>
	
	<table class="cS" id="cS">
				<tr bgcolor="skyblue" height="30">
					<th width="250">수업명</th>
					<th width="250">제목</th>
					<th width="250">작성자</th>
					<td width="250">날짜</td>
					<td width="250">삭제</td>
				</tr>
				<tbody id="tableShow">
					<c:forEach var="CourseBoard" items="${pList}">
						<tr height="25">
							<td align="center">${CourseBoard.cob_idnum}</td>
							<td align="center"><a href='getboardDetail?cob_bonum=${CourseBoard.cob_bonum}'>${CourseBoard.cob_title}</a></td>
							<td align="center">${CourseBoard.cob_id}</td>
							<td align="center">${CourseBoard.cob_date}</td>
							<td align="center"><input type='radio'id="btncheck" value='${CourseBoard.cob_bonum}'></td>
						</tr>
					</c:forEach>
					<!-- 게시판 -->
				</tbody>
			</table>
			<div align="center" id="Paging">${Paging}</div>
			<!-- 페이징 -->
			<button id='delbtn' onclick='dtncheck()'>삭제</button>
			<div class="search">
				<form action="searchClassreviewDetail">
					<select name="selvalue">
						<option value="searchWriter" selected="selected">작성자</option>
						<option value="searchTitle">제목</option>
						<option value="searchCont">내용</option>
					</select> <input type="text" name="search" placeholder="입력하기" />
					<button>검색</button>
				</form>
				<input type="button" onclick="location.href='boardwritehome'" value="글쓰기">
			</div>
	</section>
	<footer>
		<jsp:include page="../h2k5every_footer.jsp" />
	</footer>
	<script>
	function dtncheck(click) {
		var confirm_test = confirm("삭제하시겠습니까??");
		var dtnval = $(":input:radio[id=btncheck]:checked").val();
		var selval = $('#selval').val();
		var page = $('#page').val();
		var sch = $('#searchval').val();
		console.log(page);
		console.log(selval);
		console.log(sch);
			var json = new Object();
			json.cob_bonum = dtnval;
			$.ajax({
				type : 'post',
				dataType : 'json',
				url : 'rest/cobdelete',
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
		if (confirm_test == true) {
			alert("삭제완료.")
			if(selval == null){			
			location.href = "insertcounselboard?search="+sch+"&pageNum="+page+"";
			}else if(selval != null){
			location.href = "searchClassreviewDetail?selvalue="+selval+"&search="+sch+"&pageNum="+page+"";
	}
		} else if (confirm_test == false) {
			alert("삭제가 취소되었습니다.")
		}
	}
			})
			}
	
	</script>
	
						</body>
						</html>
					