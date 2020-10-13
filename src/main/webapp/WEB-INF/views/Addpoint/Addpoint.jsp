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
	top: 40%;
	left: 50%;
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

tr {
	border: 1px solid #444444;
}

ul {
	display: block;
	list-style-type: disc;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
	padding-inline-start: 40px;
}

.charge_row {
	width: 771px;
	margin: 5px;
	cursor: pointer;
	line-height: 45px;
	text-align: right;
	vertical-align: top;
}

#charge_btn {
	border: none;
	color: #ffffff;
	background-color: #dc0000;
	width: 200px;
	height: 50px;
	border-radius: 5px;
}

.phone_row {
	border: 1px solid #ccc;
	background-color: #f3f3f3;
	width: 771px;
	height: 182px;
	margin: 5px;
	cursor: pointer;
	line-height: 45px;
	text-align: center;
	vertical-align: middle;
}

.point_charge_row {
	display: -ms-flexbox;
	display: flex;
	margin-top: 15px;
	overflow-x: auto;
	overflow-y: auto;
}

.point_charge_row ul {
	list-style: none;
	display: -ms-flexbox;
	display: flex;
	margin: 0;
	padding: 0;
}

#point_btn {
	position: absolute;
	background-color: #dc0000;
	top: 110%;
	right: 50%;
	text-align: center;
}

.point_charge.active {
	color: #dc0000;
	border: 2px solid #dc0000;
}

dd {
	display: block;
	height: 30px;
	text-align: center;
}

.point_charge {
	border: 1px solid #ccc;
	background-color: #f3f3f3;
	width: 144px;
	height: 182px;
	margin: 5px;
	cursor: pointer;
	line-height: 45px;
}

#pointBox {
	width: 100%;
	margin-left height: 63px;
	background-color: #ffffff;
	color: #6c6c6c;
	line-height: 63px;
	font-weight: 700;
}

#wonBox {
	font-size: 20px;
	display: block;
	text-align: center;
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
		<input type="hidden" id="hidid" name="hidid" value="${id}" /> <input
			type="hidden" id="hidmypt" name="hidmypt" value="${Point}" />
		<h2 style="text-align: right;" id="getpt">나의 포인트 =${Point}</h2>
		<form action="Payment">
			<h2>${id}</h2>
			<dl>
				<dt style="margin-left: 30%;">충전 페이지 입니다.^ㅁ^+</dt>
				<div class="point_charge_row">
					<ul>
						<li>
							<div class="point_charge" name="onechk" value="5000"
								onclick="selectPoint(this)">
								<div id="pointBox">
									<dd>5,000 Point</dd>
								</div>
								<div id="wonBox">5,000 원</div>
							</div>
						</li>

						<li>
							<div class="point_charge" name="onechk" value="20000"
								onclick="selectPoint(this)">
								<div id="pointBox">
									<dd>20,000 Point</dd>
								</div>
								<div id="wonBox">10,000 원</div>
							</div>
						</li>

						<li>
							<div class="point_charge" name="onechk" value="50000"
								onclick="selectPoint(this)">
								<div id="pointBox">
									<dd>50,000 Point</dd>
								</div>
								<div id="wonBox">30,000 원</div>
							</div>
						</li>

						<li>
							<div class="point_charge" name="onechk" value="80000"
								onclick="selectPoint(this)">
								<div id="pointBox">
									<dd>80,000 Point</dd>
								</div>
								<div id="wonBox">50,000 원</div>
							</div>
						</li>

						<li>
							<div class="point_charge" name="onechk" value="150000"
								onclick="selectPoint(this)">
								<div id="pointBox">
									<dd>150,000 Point</dd>
								</div>
								<div id="wonBox">100,000 원</div>
							</div>
						</li>
					</ul>
				</div>
			</dl>
			<div class="phone_row">
				<h2 id="result_pt"></h2>
				결제하기 버튼을 누르시면 휴대폰 결제 창으로 넘어갑니다.
			</div>
			<div id="boxbox">
				<hr style="width: 500px;">
				<div style="margin-left:25%" class="col-sm-3">
					<button class="btn btn-primary btn-block">제출</button>
				</div>
			</div>
		</form>
	</section>
	<footer>
		<jsp:include page="../h2k5every_footer.jsp" />
	</footer>
</body>


<script type="text/javascript">
	function selectPoint(obj) {
		var target_point = $(obj).attr('value');
		$(".point_charge").each(function(idx, val) {
			var compare_point = $(val).attr('value');
			if (target_point == compare_point) {
				$(val).addClass('active');
			} else {
				$(val).removeClass('active');
			}
		})
		$('#result_pt').empty();
		var select_sub = $('#hidid').val();
		var json = new Object();
		json.pt_id = select_sub;
		$
				.ajax({
					type : 'post',
					dataType : 'json',
					url : 'rest/selectMyPointAjax',
					beforeSend : function(xhr) {
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token
								.val());
					},
					contentType : 'application/json; charset=UTF-8',
					data : JSON.stringify(json),
					success : function(date) {
						console.log(date);
						console.log(target_point);
						target_point = Number(target_point);
						var result = date + target_point;
						$('#result_pt').append(
								"<h2>" + target_point + "원+" + date + "원="
										+ result + "원</h2>");
						$('#result_pt')
								.append(
										"<input type='hidden' name='onechk' value="+target_point+">");
						$('#result_pt')
								.append(
										"<input type='hidden' name='resultpt' value="+result+">");
						}
					})
				}
</script>



</html>