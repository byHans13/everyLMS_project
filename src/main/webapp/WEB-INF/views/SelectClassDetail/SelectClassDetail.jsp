<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
<script src = "../ckeditor/ckeditor.js"></script>
</sec:authorize>

<style type="text/css">
table {
	width: 100%;
}

table, td, th {
	border: 1px solid;
	border-collapse: collapse;
	padding: 5px;
}

input[type='text'] {
	width: 98%;
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<header>
		<jsp:include page="../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../h2k5every_aside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
<h3>글쓰기</h3>
	<form action="boardwrite" id="frm" method="post" enctype="multipart/form-data">
		<table>
			<c:forEach var="board" items="${vlist}">
				<tr height="30">
					<td width="100" bgcolor="lightgray" align="center">NUM</td>
					<td colspan="5">${board.b_num}</td>
				</tr>
				<tr height="30">
					<td bgcolor="lightgray" align="center">WRITER</td>
					<td width="150">${board.b_id}</td>
					<td bgcolor="lightgray" align="center">DATE</td>
					<td width="150">${board.b_date}</td>
					<td bgcolor="lightgray" align="center">VIEWS</td>
					<td width="150">${board.b_views}</td>
				</tr>
				<tr height="30">
					<td bgcolor="lightgray" align="center">TITLE</td>
					<td colspan="5">${board.b_title}</td>
				</tr>
				<tr height="30">
					<td bgcolor="lightgray" align="center">CONTENTS</td>
					<td colspan="5">${board.b_contents}</td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<form name="rFrm" id="rFrm">
			<table>
				<tr>
					<td><textarea rows="3" cols="50" name="r_contents"
							id="r_contents"></textarea></td>
					<td><input type="button" value="댓글전송" onclick="replyinsert();"
						style="width: 70px; height: 50px"></td>
			</table>
			<table id="rTable">
				<c:forEach var="reply" items="${rList}">
					<tr height="25" align="center">
						<td width="100">${reply.r_id}</td>
						<td width="100">${reply.r_contents}</td>
						<td width="100">${reply.r_date}</td>
					</tr>
				</c:forEach>
			</table>
		</form>
	</section>
</body>
<script>

</script>
</html>
