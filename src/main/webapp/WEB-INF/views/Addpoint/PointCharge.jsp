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

div.point_charge {
	border: 1px solid #ccc;
	background-color: #f3f3f3;
	width: 110px;
	float: left;
	margin-inline-start: 20px;
	margin: 3px;
	cursor: pointer;
	line-height: 45px;
	border-radius: 3px;
}

#provision {
	font-size: 15px;
}

#provision1 {
	font-size: 13px;
	text-decoration: underline;
	padding-right: 4px;
}

#chk_box {
	border-radius: 3px;
	width: 30px;
	height: 30px;
}

#phone_space {
	margin-inline-start: 20px;
}

#modal_btn {
	margin-left: 23%;
	color: #ffffff;
	background-color: #034267;
	width: 200px;
	height: 50px;
}

#table1 {
	width: 400px;
	height: 150px;
	background-color: #034267;
	color: #ffffff;
	padding-left: 10px;
	padding-right: 10px;
}

#table2 {
	width: 400px;
	height: 150px;
}

.phone_box {
	border: 1px solid #ccc;
	width: 390px;
	height: 30px;
	border-radius: 3px;
}

.point_charge {
	width: 100%;
	margin-left: 20%;
	background-color: #ffffff;
	color: #6c6c6c;
	line-height: 63px;
	font-weight: 700;
}

.point_charge.active {
	color: #dc0000;
	border: 2px solid #dc0000;
}

.modal_wrap {
	display: none;
	width: 400px;
	height: 400px;
	position: absolute;
	top: 30%;
	left: 40%;
	margin: -250px 0 0 -250px;
	background: #eee;
	z-index: 2;
}

.black_bg {
	display: none;
	position: absolute;
	content: "";
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	top: 0;
	left: 0;
	z-index: 1;
}

.modal_close {
	width: 26px;
	height: 26px;
	position: absolute;
	top: -30px;
	right: 0;
}

.modal_close>a {
	display: block;
	width: 100%;
	height: 100%;
	background: url(https://img.icons8.com/metro/26/000000/close-window.png);
	text-indent: -9999px;
}

#modal_css {
	margin-left: 80px;
	margin-top: 80px;
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
			name='${_csrf.parameterName}' value='${_csrf.token}' />
		<form action="PointCharge">
		<input type="hidden" name="onechk" value='${onechk}'>
		<h2 id="id" style="text-align: left;">${hidid}</h2>
			<div
				style="width: 400px; margin-left: 25%; border: 1px solid #034267;">
				<table id="table1">
					<tr>
						<td>충전금액</td>
						<td id="onechk" style="text-align: right;">${onechk}</td>
					</tr>
					<tr>
						<td>총 금액</td>
						<td id="resultpt" style="text-align: right;">${resultpt}</td>
					</tr>

					<tr>
						<td>결제일자</td>
						<td style="text-align: right;"><script type="text/javascript">
							let today = new Date();
							document.write(today.toLocaleDateString());
						</script></td>
					</tr>
				</table>

				<table id="table2">
					<tr>
						<td>
							<div class="point_charge active"
								style="text-align: center; margin-left: 12px;" value="SKT"
								onclick="selectPoint(this)">
								<dd>SKT</dd>
							</div>
							<div class="point_charge"
								style="text-align: center; margin-left: 12px;" value="KT"
								onclick="selectPoint(this)">
								<dd>KT</dd>
							</div>
							<div class="point_charge"
								style="text-align: center; margin-left: 12px;" value="LGU+"
								onclick="selectPoint(this)">
								<dd>LGU+</dd>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type='text' placeholder="-없이 핸드폰 번호입력"
							name="phonearea" class="phone_box"> <input type="button"
							id="modal_btn" onclick="send()" value="인증번호받기" /></td>
					</tr>
					<tr>
						<td><input type='checkbox' id="chk_box" name="chk_box"> <a
							id="provision" style="text-align: center;"> 개인정보 수집 · 이용에
								동의합니다.(필수)</a></td>
					</tr>
					<tr style="text-align: center;">
						<td><a id="provision1" style="text-align: center;"
							onclick="detailview()">자세히보기</a>></td>
					</tr>
					<tr>
						<td><input type='checkbox' id="chk_box"name="chk_box"> <a
							id="provision" style="text-align: center;">이용약관에 동의합니다.(필수)</a></td>

					</tr>
					<tr style="text-align: center;">
						<td><a id="provision1"
							onclick="detailuseview()"> 자세히보기</a>></td>
					</tr>
				</table>
				<div class="black_bg"></div>
				<div class="modal_wrap">
					<div class="modal_close">
						<a href="#">close</a>
					</div>
					<table id="modal_css" style="align: center;">
						<tr>
							<td><h2 style="text-align: center; margin-right: 50px;">핸드폰
									결제창</h2></td>
						</tr>
						<tr>
							<td><div id="gosms" style="text-align: center;"></div></td>
					</table>
				</div>
				<input type="hidden" id="hidid" name="hidid" value="${id}" /> <input
					type="hidden" id="resultpt" name="resultpt" value="${resultpt}" />
				<button id="btn-danger" class="btn btn-danger"
					style="margin-left: 40%;">완료</button>
			</div>
			<div id="detailview" style="text-align: center;"></div>
		</form>
	</section>
	<footer>
		<jsp:include page="../h2k5every_footer.jsp" />
	</footer>
</body>
<script>
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
	};
	function detailview() {
		$('#detailview').empty();
		$('#detailview')
				.append(
						"<tr></tr><tr><td>2019. 7. 1. 부터 개정 시행되는 특정 금융거래정보의 보고 및 이용 등에 관한 법률에 따라 전자금융업자는 고객에 대한 신원확인을 하여야 합니다.</td></tr>")
		$('#detailview')
				.append(
						"<tr><td>고객 본인의 직업/업종, 거래목적, 자금원천, 실지명의 확인을 위한 본인확인 서류정보를 수집합니다.</td></tr>")
		$('#detailview')
				.append(
						"<tr><td>(단,기본 배송지 설정 동의 시, 입력한 주소지 정보는 주문/결제/이벤트 참여를 위한 기본 배송지로 저장됩니다.<h3 onclick='closeview()'>닫기</h3></td></tr>")
	}
	function detailuseview() {
		$('#detailview').empty();
		$('#detailview')
				.append(
						"<tr></tr><tr><td>이 약관은 (주)k5h2k5가 운영하는 인터넷사이트를 통하여 제공하는 전자상거래 서비스와 관련하여 회사와 회원(제2조에 정합니다)의 권리와 의무, 책임사항 및 회원의 서비스 이용절차에 관한 사항을 규정함을 목적으로 합니다. </td><tr>")
		$('#detailview')
				.append(
						"<tr><td>이 약관은 PC 통신, 스마트폰(안드로이드폰, 아이폰 등) 앱, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 준용됩니다.<h3 onclick='closeview()'>닫기</h3></td></tr>");
	}
	function closeview() {
		$('#detailview').empty();
	}
	window.onload = function() {

		function onClick() {
			document.querySelector('.modal_wrap').style.display = 'block';
			document.querySelector('.black_bg').style.display = 'block';
		}
		function offClick() {
			document.querySelector('.modal_wrap').style.display = 'none';
			document.querySelector('.black_bg').style.display = 'none';
		}

		document.getElementById('modal_btn').addEventListener('click', onClick);
		document.querySelector('.modal_close').addEventListener('click',
				offClick);

	};

	function send() {
		$("#gosms").empty()
		var number; //모르는 숫자 보내는것.
		number = Math.floor(Math.random() * 100000) + 100000;
		if (number > 100000) {
			number = number - 10000;
		}
		$
				.ajax({
					url : "sendSms?to=" + $("#PhoneNum").val() + "&num="
							+ number,
					success : function(sms) {
						if (sms != '1') {
							alert("해당 휴대폰으로 인증번호에 실패하셨습니다. 다시시도해주십시오");
						} else if (sms == '1') {
							alert("해당 휴대폰으로 인증번호를 발송했습니다");
							number = number;
							$('#gosms')
									.append(
											"<input type='text' placeholder='인증번호' id='f'><tr><input type='button' onclick='gonum("
													+ number
													+ ")'; value='확인'></tr>");

						}
					},
					error : function(err) {
					}

				});
	}
</script>



</html>