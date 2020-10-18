<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>H2K5 - 회원가입</title>
</head>
<body>
	<header>
		<h1>
			<a href="/h2k5every/"><img src="upload/h2k5_mainLogo.PNG" id="mainlogo" width="200"></a>
			<a href="gomemberjoinpage" style="text-decoration: none;">회원가입</a>
		</h1>
		<h1>창의적인 교육 H2K5 회원가입을 환영합니다.</h1>
		<p>H2K5회원으로 가입하시면 H2K5가 제작한 강의 및 다양한 교육 콘텐츠 서비스를 제공 받으실 수 있습니다.</p>
	</header>
	<div id="contents_body" class="contents step_agree_new lang_ko">
	<form action="gomainjoinpage" method="post" class="frmbox" name="joinForm" id="joinForm">
	<h2>이용약관 (필수)</h2>
		    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="termsDiv" style="border:1px solid gray; overflow:auto; overflow-y:scroll; height:250px; width:1200px;">
			<h3> 제1장 총칙</h3><br/>
			<font>제1조 (목적)</font><br/>
			① 이 약관은 온라인강의컨텐츠(H2K5, 이하 "공사"라 합니다)가 제공하는 H2K5 온라인 서비스(이하 "서비스"라 합니다)를 이용함에 있어 공사와 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.<br/> 
			② 이 약관은 공사가 제공하는 서비스(*.h2k5.co.kr, www.h2k5i.co.kr, www.h2k5lang.co.kr, www.h2k5e.co.kr, www.h2k5math.co.kr, www.h2k5sw.kr)의 이용에 적용되는 것이며, 제휴사에서 제공 중인 서비스는 이 약관 외에 별도 기본 약관이 적용됩니다.<br/><br/> 
			<font>제2조 (약관의 효력 및 변경)</font><br/>
			① 이 약관은 공사에서 제공하는 서비스에 공지하거나 전자우편 등의 기타 방법을 통하여 이를 공지함으로써 효력을 발생합니다.<br/> 
			② 공사가 약관을 변경할 경우에는 적용일자 및 변경사유를 명시하여 현행약관과 함께 서비스초기화면에 그 적용일자 10일(이용자에게 불리하거나 중대한 사항의 변경은 30일) 전부터 적용일로부터 10일까지 공지하고, 기존 회원에게는 변경될 약관, 적용일자 및 변경사유(변경될 내용 중 중요사항에 대한 설명을 포함한다)를 전자우편주소로 발송합니다.<br/>
			③ 회원은 변경된 약관에 동의하지 않을 경우 탈퇴를 요청할 수 있으며, 변경된 약관의 효력 발생일로부터 10일 이후에도 거부의사를 표시하지 아니하고 서비스를 계속 사용할 경우 약관의 변경 사항에 동의한 것으로 간주됩니다.<br/><br/> 
			<font>제3조 (약관 외 준칙)</font><br/>
			① 이 약관은 공사가 제공하는 개별 서비스에 관한 이용 안내와 함께 적용됩니다.<br/> 
			② 본 약관에 명시되지 아니한 사항에 대해서는 전기통신기본법, 전기통신사업법, 정보통신망 이용촉진 등에 관한 법률 및 기타 관련 법령 및 공사가 정한 서비스 이용 안내에 따릅니다.<br/><br/> 
			<font>제4조 (용어의 정의)</font><br/> 
			① 이 약관에서 사용하는 주요한 용어의 정의는 다음과 같습니다.<br/>
			1. 이용자: 공사와 서비스 이용계약을 체결하여 회원제 서비스를 이용하는 자를 말합니다.<br/>
			2. 이용자번호(ID): 이용자 식별과 이용자의 서비스 이용을 위하여 이용계약 체결 시 이용자가 선정하고 공사가 부여하는 문자와 숫자의 조합을 말합니다.<br/>
			3. 비밀번호: 이용자 자신의 비밀을 보호하기 위하여 이용자 자신이 설정한 문자와 숫자의 조합을 말합니다.<br/>
			4. 단말기: 서비스 제공을 받기 위해 이용자가 설치한 개인용 컴퓨터 및 모뎀 등을 말합니다.<br/>
			5. 서비스 이용: 이용자가 단말기를 이용하여 공사가 제공하는 정보를 이용하는 것<br/>
			6. 인터넷 서비스: 전 세계의 컴퓨터 네트워크들과 연결되어 제공하는 전자 우편, 파일전송, 원격 로그인, 웹 등의 서비스<br/>
			7. 이용계약: 서비스 이용과 관련하여 공사와 이용자 간에 체결 하는 계약을 말합니다.<br/>
			8. H2K5머니: H2K5머니는 유료서비스 및 상품을 이용 혹은 구입할 수 있도록 만들어진 사이버머니를 말합니다.<br/>
			9. 충전: 신용카드, 휴대폰, 계좌이체 등 공사가 정한 결제수단과 방법을 이용하여 H2K5머니를 일정량 확보하는 행위를 말하며 현금1원당 H2K5머니 1원이 충전됩니다.<br/> 
			② 이 약관에 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계법령 및 서비스별 안내에서 정하는 바에 의합니다. <br/><br/>
			<h3>제2장 서비스 이용 계약 체결</h3><br/>
			<font>제5조 (이용자의 종류)</font><br/>
			① H2K5 온라인 서비스를 이용하는 이용자는 공사가 제공하는 인터넷 서비스에 가입한 모든 회원을 말합니다.<br/> 
			<font class="protectUser">② 회원은 공사가 제공하는 모든 무료 서비스 이용이 가능하며, 유료 서비스의 경우 소정의 금액을 지불하면 이용이 가능합니다. (부분적으로 재가입이 필요한 제휴 서비스일 경우 해당 서비스는 공사와 체결한 이용계약 범위에서 제외됩니다.)</font><br/><br/> 
			<font>제6조 (이용 계약의 성립)</font><br/> 
			① 서비스 가입 신청 시 본 약관을 읽고 "동의" 버튼을 누르면 이 약관에 동의하는 것으로 간주됩니다.<br/> 
			② 이용자가 유료 서비스를 이용할 경우 제1항에 동의한 후 공사에 이용요금(회비)을 납부함으로써 이용계약이 성립되며, 공사가 이를 확인하여 인증 처리 한 후 이메일 또는 기타 방식의 공지화면으로 서비스이용이 가능함을 통보합니다.<br/> 
			③ 이용계약은 서비스 이용 신청자의 이용약관 동의 후 이용 신청에 대하여 공사가 승낙함으로써 성립합니다. <br/><br/>
			<font>제7조 (이용 신청)</font><br/>
			① 회원으로 가입하여 서비스를 이용하기를 희망하는 자는 공사가 요청하는 소정의 가입신청 양식에서 요구하는 사항을 기록하여 신청합니다.<br/> 
			② 만 14세 미만의 어린이는 부모 등 법정 대리인의 동의를 얻은 후에 서비스 이용을 신청하여야 합니다. 또한 미성년자가 유료 서비스를 이용하고자 하는 경우에도 이와 같습니다.<br/><br/> 
			<font>제8조 (이용 신청의 승낙)</font><br/>
			① 공사는 제7조에 따른 이용신청에 대하여 특별한 사정이 없는 한 접수 순서대로 신청을 승낙합니다.<br/> 
			② 공사는 다음 각 호에 해당하는 경우 이용신청에 대한 승낙을 제한할 수 있고, 그 사유가 해소될 때까지 승낙을 유보할 수 있습니다.<br/>
			1. 서비스 관련 설비에 여유가 없는 경우<br/>
			2. 기술상 지장이 있는 경우<br/>
			3. 기타 공사의 사정상 필요하다고 인정되는 경우<br/> 
			③ 공사는 다음 각 호에 해당하는 사항을 인지하는 경우 동 이용계약 신청을 승낙하지 아니할 수 있습니다.<br/>
			1. 본인의 실명으로 신청하지 않은 경우<br/>
			2. 다른 사람의 명의를 사용하여 신청한 경우<br/>
			3. 이용 신청 시 필요 사항을 허위로 기재하여 신청한 경우<br/>
			4. 사회의 안녕과 질서 혹은 미풍양속을 저해할 목적으로 신청한 경우<br/>
			5. 14세 미만 아동이 법정대리인(부모 등)의 동의를 얻지 아니한 경우<br/>
			6. 이용자의 귀책사유로 인하여 승인이 불가능하거나 기타 규정한 제반 사항을 위반하며 신청하는 경우<br/>
			7. 기타 공사가 정한 이용 신청 요건이 미비 된 경우 <br/>
			④ 제2항 또는 3항에 의하여 이용신청의 승낙을 유보하거나 승낙하지 아니하는 경우, 공사는 이를 이용신청자에게 알려야 합니다. 다만, 공사의 귀책사유 없이 이용신청자에게 통지할 수 없는 경우는 예외로 합니다.<br/><br/> 
			<font>제9조 (개인정보의 보호 및 사용)</font><br/>
			① 공사는 이용자의 개인정보를 보호하고 존중합니다.<br/> 
			② 공사는 이용자가 서비스를 이용함에 있어서 온라인상에서 공사에게 제공한 개인정보가 보호 받을 수 있도록 최선을 다하고 있습니다. 이에 통신비밀보호법, 전기통신사업법, 정보통신망이용촉진 등에 관한 법률, 공공기관의 개인정보보호에 관한 법률 등 정보통신 서비스 제공자가 준수하여야 할 관련법규를 바탕으로 개인정보보호정책을 만들어 이를 준수하고 있습니다. 자세한 사항은 공사의 개인정보보호정책을 참고하시기 바랍니다.<br/> 
			③ 공사는 이용 신청 시 이용자가 제공하는 정보, 커뮤니티 활동, 각종 이벤트(방송 포함) 참가를 위하여 이용자가 제공하는 정보, 그리고 기타 서비스 이용 과정에서 수집되는 정보 등을 통하여 이용자에 관한 정보를 수집하며, 이용자의 개인정보는 본 이용계약의 이행과 본 이용계약상의 서비스 제공을 위한 목적으로 사용됩니다. <br/>
			④ 공사는 서비스 제공과 관련하여 취득한 이용자의 신상정보를 본인의 승낙 없이 제3자에게 누설 또는 배포할 수 없으며 상업적 목적으로 사용할 수 없습니다. 다만, 다음의 각 호에 해당하는 경우에는 그러하지 아니합니다.<br/>
			1. 정보통신서비스의 제공에 따른 요금 정산을 위하여 필요한 경우<br/>
			2. 통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 알아 볼 수 없는 형태로 가공 하여 제공하는 경우<br/>
			3. 관계 법령에 의하여 수사상 목적으로 정해진 절차와 방법에 따라 관계기관의 요구가 있는 경우<br/>
			4. 다른 법률에 특별한 규정이 있는 경우<br/>
			5. 정보통신윤리위원회의 요청이 있는 경우 <br/>
			⑤ 공사는 서비스를 통해 이용자의 컴퓨터에 쿠키를 전송할 수 있습니다. 이용자는 쿠키 수신을 거부하거나 쿠키 수신에 대해 경고하도록 브라우저 설정을 변경할 수 있습니다.<br/><br/> 
			<font>제10조 (계약 사항의 변경)</font><br/>
			① 회원은 개인정보관리를 통해 언제든지 본인의 개인정보를 열람하고 수정할 수 있습니다. 다만, 서비스 관리를 위해 필요한 회원의 성명, 성별, 아이디 등은 수정이 불가능합니다.<br/> 
			② 회원은 이용신청 시 기재한 사항이 변경되었을 경우 온라인으로 수정을 해야 하며 회원정보를 변경하지 아니하여 발생되는 문제의 책임은 회원에게 있습니다. <br/><br/>
			<h3>제3장 계약 당사자의 의무</h3><br/>
			<font>제11조 (공사의 의무) </font><br/>
			① 공사는 다음 각 호의 사유가 발생한 경우를 제외하고 계속적, 안정적으로 서비스를 제공하기 위하여 최선을 다하여 노력합니다.<br/>
			1. 서비스용 설비의 보수, 정기점검 또는 공사로 인한 부득이한 경우<br/>
			2. 전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지한 경우<br/>
			3. 전시, 사변, 천재지변 또는 이에 준 하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우<br/>
			4. 설비 장애 또는 이용 폭주 등으로 인하여 서비스 이용에 지장이 있는 경우 <br/>
			② 공사의 귀책사유로 연속 1일 이상 이용 중지나 장애가 발생하는 경우 온라인 유료 콘텐츠 이용기간을 연장해준다, 단, 천재지변 등 불가항력이나 이용자에 대한 서비스 개선을 목적으로 한 설비 점검 및 보수 시에는 합리적인 시간 내에서 사업자의 사전 고지가 있는 경우, 이용중지 또는 장애발생 시간에 산입하지 아니합니다.<br/> 
			③ 공사는 콘텐츠하자 등에 의한 이용자피해보상의 기준․범위․방법 및 절차에 관한 사항을 콘텐츠이용자보호지침에 따라 처리합니다.<br/> 
			④ 공사는 이용자에 의해 제기되는 의견이나 불만이 정당하다고 객관적으로 인정될 경우에는 적절한 절차를 거처 즉시 처리하여야 합니다. 다만, 즉시 처리가 곤란한 경우는 이용자에게 그 사유와 처리 일정을 알려주어야 합니다.<br/> 
			⑤ 공사는 이용자의 정보를 철저히 보안 유지하며, 서비스를 운영하거나 개선하는 데에만 사용하고, 이외의 다른 목적으로 타 기관 및 개인에게 제공하지 않습니다. 단, 다음 각 호에 해당하는 경우에는 그러하지 아니합니다.<br/>
			1. 관계 법령에 의하여 수사상의 목적으로 관계기관으로부터 요청이 있는 경우<br/>
			2. 정보통신윤리위원회의 요청이 있는 경우<br/>
			3. 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우<br/> <br/>
			<font>제12조 (이용자의 의무)</font><br/>
			① 이용자는 관계 법령, 본 약관의 규정, 이용안내 및 서비스 상에 공지한 주의사항, 공사가 통지하는 사항을 준수하여야 하며, 기타 공사의 업무에 방해되는 행위를 하여서는 안됩니다.<br/> 
			② 이용자는 공사의 사전 동의 없이 서비스를 이용하여 어떠한 영리행위도 할 수 없으며, 법에 저촉되는 자료를 배포 또는 게재할 수 없습니다.<br/> 
			③ 이용자는 자신의 ID와 비밀번호를 유지 관리할 책임이 있으며 자신의 ID와 비밀번호를 사용하여 발생하는 모든 결과에 대해 전적인 책임이 있습니다. 또한 자신의 ID와 비밀번호가 자신의 승낙 없이 사용되었을 경우 즉시 공사에 통보하여야 합니다.<br/> 
			④ 이용자는 서비스와 관련하여 다음 사항을 하여서는 안 됩니다.<br/>
			1. 서비스를 이용하여 얻은 정보를 공사의 사전 승낙 없이 복사, 복제, 변경, 번역, 출판, 방송 기타의 방법으로 사용하거나 이를 타인에게 제공하는 행위<br/>
			2. 공공질서 및 미풍양속에 위반되는 저속, 음란물을 게재 또는 음란사이트를 링크하거나 ,유포 등 사회질서를 해치는 행위<br/>
			3. 타인의 명예를 훼손하거나 모욕하는 행위, 타인의 지적재산권 등의 권리를 침해하는 행위<br/>
			4. 해킹 또는 컴퓨터 바이러스를 유포하는 일, 타인의 의사에 반하여 광고성 정보 등 일정한 내용을 지속적으로 전송하는 행위<br/>
			5. 다른 이용자 ID를 부정 사용하는 행위<br/>
			6. 다른 사용자의 개인 정보를 수집, 저장하는 행위<br/>
			7. 공사 직원, 운영자 등을 포함한 타인을 사칭하는 행위<br/>
			8. 서비스를 통해 전송된 콘텐츠의 발신인을 위조하는 행위<br/>
			9. 타인을 스톡(stalk)하거나, 괴롭히는 행위<br/>
			10. 서비스의 운영에 지장을 주거나 줄 우려가 있는 일체의 행위<br/>
			11. 본 약관을 포함하여 기타 공사가 정한 제반 규정 또는 이용 조건을 위반하는 행위<br/>
			12. 범죄와 결부된다고 객관적으로 판단되는 행위<br/>
			13. 기타 관계 법령에 위배되는 행위 <br/><br/>
			<font>제13조 (양도 금지) </font><br/>
			이용자는 서비스의 이용권한, 기타 이용 계약상 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없습니다.<br/><br/> 
			<h3>제4장 서비스 이용</h3><br/>
			<font>제14조 (서비스 이용 범위) </font><br/>
			이용자는 공사를 통해 가입 시 발급된 ID 하나로 H2K5 인터넷서비스에서 제공하는 서비스를 이용할 수 있습니다. 단, 별도로 공사가 아닌 제휴사에서 제공하는 콘텐츠의 경우 아니한 경우도 있습니다.<br/> <br/>
			<font>제15조 (서비스 이용 시간)</font><br/> 
			① 공사는 이용자의 이용신청을 승낙한 때부터 즉시 서비스를 개시합니다.<br/> 
			② 서비스의 이용 시간은 공사가 업무 및 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로 합니다. 단 공사는 시스템 정기점검, 증설 및 교체를 위해 공사가 정한 날이나 시간은 그러하지 아니하며, 이때에는 공지사항이나 전자우편 등의 방법으로 이용자에게 안내합니다.<br/> 
			③ 공사는 일부 서비스의 경우 이용가능시간을 별도로 지정할 수 있습니다. 다만 이 경우 그 내용을 공지사항이나 전자우편 등의 방법으로 안내합니다.<br/><br/> 
			<font>제16조 (정보의 제공)</font><br/> 
			공사는 이용자가 서비스 이용 중 필요가 있다고 인정되는 다양한 정보를 공지사항이나 전자우편 등의 방법으로 이용자에게 제공할 수 있습니다.<br/> <br/>
			<font>제17조 (요금 및 유료 콘텐츠 등)</font><br/>
			① 공사가 제공하는 서비스는 기본적으로 무료를 원칙으로 합니다. 단, 유료 서비스 및 유료 정보에 대해서는 해당 정보에 명시된 요금을 지불하여야 사용 가능합니다.<br/> 
			② VOD/AOD 콘텐츠의 유료화 범위와 가격표는 별도 공지하며, 온라인 강좌 등 기타 유료 콘텐츠의 이용 요금 및 결제 방식은 해당 서비스에 명시된 규정에 따릅니다.<br/> 
			③ H2K5머니를 이용하는 방법, 환불, 사용 등은 공사에서 별도로 정한 H2K5머니 정책에 따르며, H2K5머니를 사용하고자 하는 회원은 H2K5머니 정책에 따라야 합니다.<br/><br/> 
			<font>제18조 (결제 취소 및 환불 규정)</font><br/> 
			① 공사는 부득이한 사정으로 유료서비스를 지속할 수 없을 경우, 이용자가 잔여 이용요금을 요구할 경우, 이용자가 지정하는 구좌로 환불합니다. 단, 잔여이용료 환불 시 이는 공사가 규정한 환불 정책에 따릅니다.<br/> 
			② 요금 선납 이용자가 유료서비스 이용신청을 취소하고자 하는 경우에는 취소 사유를 명기하여 본인이 직접 고객센터로 전화나 문의 게시판을 통하여 취소 신청할 수 있습니다. <br/>
			③ 취소 또는 환불 신청을 받은 공사는 각 서비스의 각 인터넷서비스에 명기된 환불 정책에 따라 취소 또는 환불 신청에 응할 수 있습니다. 단, 공사는 다음 각 호에 해당하는 경우 이용자의 환불신청을 승낙하지 아니 할 수 있습니다.<br/>
			1. 이용자의 실수로 이용기간 내에 서비스를 이용하지 못한 경우<br/>
			2. 환불관련 제비용이 잔여이용료를 초과할 경우<br/>
			3. 서비스에서 탈퇴한 후, 환불을 요구할 경우<br/>
			4. 단시간 또는 일회성으로 이용할 수 있는 콘텐츠(한편보기, 24시간 자유이용권)<br/>
			5. 구입한 상품 또는 온라인 콘텐츠 등에 특별한 하자가 없는데도 불구하고 상습적인 환불요청 또는 계약 취소 등으로 공사의 업무를 방해하는 경우. 단, 당해 회원의 계약취소 및 환불비율이 공사의 평균 계약취소 및 환불율보다 50%이상 높을 경우에는 상습적인 것으로 인정될 수 있음<br/>
			6. 기타 정당한 환불사유로 판명되지 않은 경우<br/>
			④ 공사는 이용자로부터 해제 또는 해지 통보를 받은 경우 3영업일 이내에 온라인콘텐츠에 대한 대금을 환급합니다. 단, 실물 상품의 경우에는 각 인터넷서비스에 명기된 환불 정책을 따르며, 상품 수취 확인 후에 3영업일 이내에 대금을 환급합니다.<br/> 
			⑤ 사업자는 이용대금의 결제와 동일한 방법으로 결제 대금을 환불해야하며 동일한 방법으로 환불이 불가능할 때에는 이를 사전에 고지하여야 합니다.<br/> 
			⑥ 공사가 제공하는 서비스 중 유료로 파일을 다운로드 받는 상품의 경우, 다운로드 즉시 회수가 불가능하며 상품가치가 사용자에게 전달되는 상품이므로 원칙적으로 환불이 불가합니다.<br/> 
			⑦ 공사는 과오금이 발생한 경우 이용대금 결제와 동일한 방법으로 결제대금 전액을 환불하여야합니다. 다만 동일한 방법으로 환불이 불가능할 때에는 이를 사전에 고지합니다. 또한 공사는 회원이 주장하는 과오금에 대해 환불을 거부할 경우에 정당하게 이용대금이 부과되었음을 입증할 책임을 집니다.<br/> 
			⑧ 공사의 책임있는 사유로 과오금이 발생한 경우 사업자는 수수료 등에 관계없이 과오금 전액을 환불하여야하며, 이용자의 책임 있는 사유로 과오금이 발생한 경우, 공사가 과오금을 환불하는 데 소용되는 비용은 합리적인 범위내에서 이용자가 부담합니다. <br/>
			⑨ 공사는 과오금의 환불절차를 콘텐츠이용자보호지침에 따라 처리합니다.<br/><br/> 
			<font>제19조(실물상품의 반품 및 교환, 환불)</font><br/>
			① 교재 등 실물상품을 취소하실 경우에는 결제 후 30일 이내에 상품 개봉 전(훼손 전) 상태로 본인이 배송비를 부담하여 반송처로 보내주시면, 상품 반송이 확인된 후 3영업일 이내에 환불해드립니다. 단, 다음 각 호의 경우에는 구매자가 반품 또는 교환을 요청할 수 없습니다.<br/> 
			1. 구입한 교재를 훼손하거나 사용한 경우<br/>
			2. 시간의 경과에 의하여 재판매가 곤란할 정도로 상품의 가치가 현저히 감소한 경우<br/>
			② 반품 또는 교환에 필요한 왕복 배송비 기타 필요한 비용은 귀책사유가 있는 쪽에서 부담합니다.<br/>
			③ 교환에 소요되는 비용은 물품하자의 경우에는 공사가 왕복 배송비를 부담하나 구매자의 변심에 의한 경우에는 구매자가 부담합니다.<br/>
			④ 교환신청을 하더라도 공사에 교환할 물품의 재고가 없는 경우 교환이 불가능하며, 이 경우 반품으로 처리됩니다.<br/>
			⑤ 실물 상품의 반품 및 교환에 따른 환불은 제18조 (결제 취소 및 환불 규정)에 따른다.<br/><br/>
			<font>제20조 (이용자의 게시물) </font><br/>
			공사는 이용자가 게시하거나 등록하는 서비스내의 내용물이 다음 각 호에 해당한다고 판단되는 경우에 사전통지 없이 삭제할 수 있으며, 공사에 의한 삭제 조치 이후에도 동일한 건으로 게시물 정책을 위반할 경우 게시판 이용을 제한할 수 있습니다.<br/>
			1. 다른 회원 또는 제3자를 비방하거나 중상모략으로 명예를 손상시키는 내용인 경우<br/>
			2. 공공질서 및 미풍양속에 위반되는 내용을 유포하거나 링크시키는 경우<br/>
			3. 범죄적 행위에 결부된다고 객관적으로 인정되는 내용일 경우<br/>
			4. 공사의 저작권, 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우<br/>
			5. 공사에서 규정한 게시기간이나 용량을 초과한 경우<br/>
			6. 영리를 목적으로 하는 광고일 경우<br/>
			7. 공사에서 규정한 게시물 원칙에 어긋나거나, 게시판 성격에 부합되지 않는 경우<br/>
			8. 기타 관계법령에 위배된다고 판단되는 경우 <br/><br/>
			<font>제21조 (게시물의 저작권) </font><br/>
			① 게시물에 대한 권리와 책임은 게시자에게 있으며, 공사는 게시자의 동의 없이는 게시물을 영리적 목적으로 사용할 수 없습니다. 단, 비영리적인 경우에는 그러하지 아니하며 또한 공사는 서비스 내의 게재권을 갖습니다.<br/> 
			② 회원은 서비스를 이용하여 얻은 정보를 임의 가공, 판매하는 행위, 기타 방법에 의하여 서비스에 게재된 자료를 상업적으로 사용하거나 제3자에게 이용할 수 없습니다. <br/>
			③ 공사는 이용자가 게시하거나 등록하는 서비스 내의 내용물, 게시 내용에 대해 제20조 각 호에 해당된다고 판단되는 경우 사전통지 없이 삭제하거나 이동 또는 등록 거부할 수 있습니다.<br/><br/> 
			<font>제22조 (서비스 제공의 중지 및 제한) </font><br/>
			<font class ="protectUser">① 무료 서비스의 경우, 공사는 공사의 필요에 따라 언제든지 본 서비스의 전부 또는 일부를 수정하거나 중단 할 수 있으며, 이 경우 공사는 공지사항 또는 전자우편 등을 통하여 이용자에게 즉시 이를 고지합니다.</font> 
			<font class="protectUser">② 공사는 다음 각 호에 해당하는 경우 서비스 제공을 중지할 수 있습니다.<br/>
			1. 서비스용 설비의 보수 또는 공사로 인한 부득이한 경우<br/>
			2. 전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지했을 때<br/> 
			</font>
			<font class="protectUser">③ 공사는 국가비상사태, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 서비스 이용에 지장이 있는 때에는 서비스 제공을 중지하거나 제한할 수 있고, 공사가 적절하다고 판단하는 사유에 기하여 현재 제공되는 서비스를 완전히 중단할 수 있습니다.</font> 
			<font class="protectUser">④ 공사는 서비스의 제공에 필요한 경우 정기점검을 실시할 수 있으며, 정기점검시간은 서비스제공화면에 공지한 바에 따릅니다.</font><br/><br/>
			<font>제23조 (광고게재 및 광고주와의 거래) </font><br/>
			① 공사가 이용자에게 서비스를 제공할 수 있는 서비스 투자기반의 일부는 광고게재를 통한 수익으로부터 나옵니다. 서비스를 이용하고자 하는 자는 서비스 이용 시 노출되는 광고게재에 대해 동의하는 것으로 간주됩니다.<br/> 
			② 공사는 본 서비스 상에 게재되어 있거나 본 서비스를 통한 광고주의 판촉활동에 이용자가 참여하거나 교신 또는 거래의 결과로서 발생하는 손실 또는 손해에 대해 책임을 지지 않습니다.<br/><br/> 
			<h3>제5장 H2K5머니 정책</h3><br/>
			<font>제24조 (H2K5머니 충전방법) </font><br/>
			① H2K5머니의 충전은 1회 최소 1,000원에서 최대 300,000원까지 충전할 수 있으며, 충전을 통한 누적금액은 300,000원까지만 가능합니다.<br/> 
			② H2K5머니는 공사가 정한 결제수단과 방법을 이용하여 충전이 가능하며 고객이 지정하신 지불수단에 따라 자체의 사용제한 금액이 있을 수 있습니다. 또한 회원은 각 결제수단을 제공하는 각서비스사의 결제 또는 이용 규정에 따릅니다.<br/> 
			③ 공사는 H2K5머니의 충전금액에 대해 회원에게 이자를 지급하지 아니합니다.<br/> 
			④ H2K5머니의 충전금액에는 부가가치세(VAT)가 포함되어 있습니다.<br/><br/> 
			<font>제25조 (H2K5머니 이용자격) </font><br/>
			① 공사는 다음 각 호에 해당하는 H2K5머니 결제 승인 신청에 대해서는 승인하지 아니하거나 추후 해당 승인을 취소할 수 있습니다.<br/>
			1. 결제한 요금을 납부하지 아니하거나 납부자 확인이 불가능한 경우<br/>
			2. 이용자의 귀책사유로 H2K5머니의 결제 승인이 불가능하다고 판단되는 경우<br/>
			3. 타인의 결제 정보 등을 도용하거나 부정한 방법으로 거래하는 경우<br/>
			4. 타인의 명의나 개인정보를 도용하여 서비스를 이용하는 경우 <br/>
			5. H2K5머니 서비스에 대한 권리를 제3자에게 양도하거나 이전하는 경우<br/>
			6. 결제 수단을 악용하여 불법적인 행위를 하는 경우 <br/>
			7. 기타 본 약관 기타 공사의 이용약관, 관련 법령 등을 위반하는 경우<br/> 
			② 공사는 다음 각 호에 해당하는 경우 이용신청에 대한 승인 제한 사유가 해소될 때까지 승인을 제한하거나 유보할 수 있습니다.<br/>
			1. 서비스 설비가 부족하여 모든 이용자에게 만족스러운 서비스를 제공할 수 없다고 판단될 경우<br/>
			2. 서비스 제공과 관련하여 기술상 지장이 있는 경우<br/>
			3. 각 결제수단의 제공업체의 장애, 점검 등으로 결제수단에 장애가 발생하여 결제서비스 제공이 불가능한 경우<br/> 
			③ 회원이 회원을 자진탈퇴 할 경우 H2K5머니 보유 잔액은 본 약관 제27조 (H2K5머니의 환불) 조항에 따라 환불 받으실 수 있으며, 환불 받지 않고 회원탈퇴를 하실 경우 H2K5머니는 자동 소멸됩니다.<br/><br/> 
			<font>제26조 (H2K5머니 사용 및 차감)</font><br/>
			① H2K5머니는 공사가 제공하는 각종 유료서비스를 이용하거나 디지털 콘텐츠를 사용하는데 지불수단으로 이용됩니다. H2K5머니를 이용하여 제공되는 각종 유료 서비스 및 디지털콘텐츠는 본 약관 제12조에서 정한바와 같이 공사가 정한 범위 내에서 본 서비스 상에서 본인이 직접 이용하는 것에 한정합니다. 이를 초과하는 이용방법은 영리 또는 비영리를 구분하지 않고 엄격히 금지되며, 제3자에게로의 일체의 복제, 전송, 배포는 금지됩니다.<br/> 
			② H2K5머니는 공사가 제공하는 서비스 중 www.h2k5.co.kr에서 방송 프로그램 VOD/AOD 콘텐츠 구매시에 사용이 가능하며, 제휴사가 운영하는 서비스 및 상품에 대해서는 사용이 불가합니다.<br/> 
			③ H2K5머니를 이용하여 공사가 제공하는 각종 서비스를 이용하거나 디지털 콘텐츠를 사용하는 경우, 해당 서비스나 디지털 콘텐츠가 회원의 특정한 목적이나 필요를 충족시킨다는 보장이 없습니다.<br/> 
			④ H2K5머니는 공사가 제공하는 유료서비스 및 디지털콘텐츠의 이용을 위해서 H2K5머니로 결제하는 시점에서 즉시 차감됩니다.<br/> 
			⑤ 회원이 보유한 H2K5머니에 대해 최종사용일로부터 5년 동안 사용내역이 없는 경우 금액에 관계없이 사용 및 환불이 불가능하며, 잔액은 공사가 임의 처리할 수 있습니다.<br/> 
			⑥ 공사의 책임 있는 사유로 H2K5머니를 이용해 구매한 유료콘텐츠가 손상, 훼손, 분실, 삭제되었을 경우, 공사는 즉시 해당 유료콘텐츠를 정상적으로 이용 가능한 상태로 원상에 복원하되, 그와 같은 복원이 불가능하거나 곤란한 경우에는 제18조(결제 취소 및 환불규정)에 따라 보상해드립니다.<br/> <br/>
			<font>제27조 (H2K5머니의 환불)</font><br/> 
			① 해지(환불)를 원하는 회원은 공사의 취소 사유를 명기하여 본인이 직접 고객센터로 전화나 문의 게시판을 통하여 해지(환불)신청을 하여야 합니다.<br/> 
			② 해지(환불)에 대한 사항은 제18조 결제 취소 및 환불 규정을 따릅니다.<br/> 
			③ 이용자가 이용하고 남은 H2K5머니 잔액에 대해 환불을 요청할 경우, 공사는 H2K5 머니 잔액에서 결제대행수수료 등 기타 제반 비용으로 잔액의 10%에 해당하는 환불수수료를 공제한 금액을 환불합니다. 단, 다음 각 호에 해당되는 H2K5머니는 환불이 불가능합니다. 1. 각종 이벤트등을 통해 공사가 무료로 제공한 H2K5머니<br/>
			2. 회원이 타인의 명의를 도용하였거나 타인의 결제 정보를 도용하는 등 부정한 방법으로 이용계약을 체결하거나 대금을 결제한 사실이 인정되는 경우<br/>
			3. 환불대상금액이 1,000원 미만인 경우(전액 결제대행수수료, 송금수수료로 처리됩니다.)<br/> 
			④ 제3항에도 불구하고, 다음 각 호에 해당하는 경우, H2K5머니 잔액을 전액 환불합니다.<br/>
			1. 공사의 책임 있는 사유로 인하여 서비스를 정상적으로 이용하지 못하였음이 인정되는 경우 다만, 회원의 책임 있는 사유로 과오금이 발생한 경우, 공사가 과오금을 환불하는 데 소요되는 비용은 합리적인 범위 내에서 회원이 부담하여야 합니다.<br/>
			2. 회원이 이용할 수 있는 서비스가 전무하며 그에 대한 책임이 전적으로 공사에 있을 경우 <br/>
			⑤ 공사는 과오금의 환불절차를 콘텐츠이용자보호지침에 따라 처리합니다. <br/><br/>
			<font>제28조 (미성년자의 H2K5머니 사용)</font><br/>
			① 법률에서 정한 미성년자에 해당되는 회원은 유료서비스 이용전 최초 회원 가입시 공사가 정한 방법으로 법정대리인의 동의를 받아야 합니다. 일단, 최초 H2K5회원 가입시 동의를 받은 회원은 각각의 H2K5머니 사용에도 동의를 받은 것으로 간주합니다.<br/> 
			② 위 1항의 동의절차를 받지 않은 미성년자는 H2K5머니 이용 및 충전에 제한을 받을 수 있습니다. <br/><br/>
			<h3>제6장 계약 해지 및 서비스 이용 제한</h3><br/>
			<font>제29조 (청약철회와 계약 해지 및 이용 제한)</font><br/> 
			① 공사와 콘텐츠의 이용에 관한 계약을 체결한 이용자는 수신확인의 통지를 받은 날로부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 공사가 다음 각 호중 하나의 조치를 취한 경우에는 이용자의 청약철회권이 제한될 수 있습니다.<br/>
			1. 청약의 철회가 불가능한 콘텐츠에 대한 사실을 표시사항에 포함한 경우<br/>
			2. 시용상품을 제공한 경우<br/>
			3. 한시적 또는 일부이용 등의 방법을 제공한 경우<br/> 
			② 이용자는 다음 각 호의 사유가 있을 때에는 당해 콘텐츠를 공급받은 날로부터 3월 이내 또는 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 콘텐츠이용계약을 해제․해지할 수 있습니다.<br/>
			1. 이용계약에서 약정한 콘텐츠가 제공되지 않는 경우<br/>
			2. 제공되는 콘텐츠가 표시․광고 등과 상이하거나 현저한 차이가 있는 경우<br/>
			3. 기타 콘텐츠의 결함으로 정상적인 이용이 현저히 불가능한 경우 <br/>
			③ 제1항의 청약철회와 제2항의 계약해제․해지는 이용자가 전화, 전자우편 또는 모사전송으로 공사에 그 의사를 표시한 때에 효력이 발생합니다.<br/> 
			④ 공사는 제3항에 따라 이용자가 표시한 청약철회 또는 계약해제․해지의 의사표시를 수신한 후 지체 없이 이러한 사실을 이용자에게 회신합니다.<br/> 
			⑤ 회원이 이용 계약을 해지하고자 하는 때에는 회원 본인이 직접 서비스 내 회원탈퇴 메뉴를 이용하여 가입해지를 해야 합니다.<br/> 
			<font class="protectUser">⑥ 공사는 회원이 서비스 이용내용에 있어서 본 약관 제12조 내용을 위반하거나, 다음 각 호에 해당하는 경우 사전 통지 없이 이용 계약을 해지하거나 또는 기간을 정하여 서비스 이용을 중지할 수 있습니다.<br/>
			1. 공공질서 및 미풍양속에 반하는 경우<br/>
			2. 범죄적 행위에 관련되는 경우<br/>
			3. 국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을 계획 또는 실행할 경우<br/>
			4. 타인의 ID 및 비밀번호를 도용한 경우<br/>
			5. 가입한 이름이 실명이 아닌 경우<br/>
			6. 타인의 명예를 손상시키거나 불이익을 주는 경우<br/>
			7. 같은 사용자가 다른 ID로 이중 등록을 한 경우<br/>
			8. 공사 직원 및 운영자 등을 포함한 타인을 사칭하기 위해 ID 및 별명을 사용할 경우<br/>
			9. 서비스에 위해를 가하는 등 건전한 이용을 저해하는 경우<br/>
			10. 구입한 상품 또는 온라인 콘텐츠 등에 특별한 하자가 없는데도 불구하고 상습적인 환불 요청 또는 계약취소 등으로 공사의 업무를 방해하는 경우<br/>
			11. 기타 관련 법령이나 공사가 정한 이용 조건에 위배되는 경우<br/>
			</font>
			⑦ 공사의 해제, 해지 및 이용제한에 대하여 이용자는  이의신청을 할 수 있습니다. 이용자가 자신의 고의나 과실이 없었음을 입증한 경우, 공사는 서비스의 이용을 재개하고, 이용제한 기간만큼 이용기간을 연장하는 조치를 취합니다.<br/> 
			⑧ 회원이 서비스를 이용하는 도중, 연속하여 1년 동안 서비스를 이용하기 위해 공사의 서비스에 로그인한 기록이 없는 경우 공사는 회원의 회원자격을 상실시킬 수 있습니다.<br/><br/>
			<h3>제7장 환불 정책 안내</h3><br/>
			H2K5를 이용하시는 회원님들께 감사의 말씀을 드리며, 환불과 관련한 규정을 아래에 안내합니다. <br/>
			<br/>
			결제 취소 및 환불 접수는 아래의 환불 신청 항목을 정확하게 알려주셔야 환불신청에 대해 정상적으로 접수가 됩니다. <br/>
			정상적으로 접수된 환불 신청 건에 한하여, 환불 접수일자를 기준으로 아래 환불 규정에 따라 처리해드립니다. <br/>
			환불 신청 시, 기재한 내용이 부정확한 경우 환불접수가 되지 않으며, 이로 인하여 회원이 요청한 환불 건에 대해 부분 환불 또는 환불 불가가 될 수 있습니다.<br/>
			* 환불 신청 항목 : 아이디/ 이름 / 환불 받으려는 과정명 / 연락처 / e-mail / 결제방법 / 환불사유 <br/>
			- 환불 신청 시 이용문의 게시판을 이용할 경우, 개인정보 노출의 위험이 있으니, 1:1 메일 문의 또는 고객센터 유선 연락 후 환불을 진행해 주시기 바랍니다.<br/>
			- 환불 시 '수강'의 기준은 동영상 시청 및 학습창 접속 이력으로 처리됩니다. 실제 동영상을 끝까지 재생하지 않더라도 수강 이력에 포함되오니 이 점 유의하여 주시기 바랍니다. <br/>
			- H2K5는 전자상거래 등에서의 소비자보호에 관한 법률, 콘텐츠산업진흥법, 콘텐츠이용자보호지침(문화체육관광부 고시) 등 관련 법령을 준수하며, 관련 법령에서 정한 내용을 우선으로 합니다.<br/>
			- 이용자는 H2K5의 법 적용에 오류가 있을 경우 시정을 요청할 수 있고, 이 경우 H2K5는 관련 법령 및 유관 기관의 유권해석 등에 따라 처리합니다.<br/>
			<br/>
			<font>제30조 (청약철회 등)</font><br/>
			① 이용자는 다음 각 호의 기간 이내에 당해 계약에 관한 청약의 철회 또는 계약의 해제(이하 "청약철회 등"이라고 합니다)를 할 수 있습니다. <br/>
			1. 계약내용에 관한 서면을 교부 받은 날로부터 7일. 단, 그 서면을 교부받은 때보다 콘텐츠의 공급이 늦게 이루어진 경우에는 콘텐츠의 공급을 받거나 공급이 개시된 날부터 7일<br/>
			2. 계약내용에 관한 서면을 교부 받지 아니한 경우, H2K5의 주소 등이 기재되지 아니한 서면을 교부 받은 경우 또는 H2K5의 주소 변경 등의 사유로 제1호의 기간 이내에 청약철회 등을 할 수 없는 경우에는 그 주소를 안 날 또는 알 수 있었던 날로부터 7일<br/>
			② 다음 각 호의 어느 하나에 해당하는 경우에 이용자는 H2K5의 의사에 반하여 제1항에서 정한 청약철회 등을 할 수 없습니다. 다만, 제2호부터 제4호까지에 해당하여 청약철회 등이 불가능한 경우에 H2K5가 그 사실을 콘텐츠 또는 그 포장 기타 이용자가 쉽게 알 수 있는 곳에 표시하거나 시용상품을 제공하거나 콘텐츠의 한시적 또는 일부 이용이 가능하게 하는 등의 방법으로 청약철회 등의 권리 행사가 방해받지 아니하도록 조치를 취하지 아니하는 때에는 이용자는 청약철회 등을 할 수 있습니다.<br/>
			1. 콘텐츠의 내용을 확인하기 위하여 포장 등을 훼손한 경우를 제외하고, 이용자에게 책임 있는 사유로 콘텐츠가 멸실 또는 훼손된 경우<br/>
			2. 이용자의 사용 또는 일부 소비에 의하여 콘텐츠의 가치가 현저히 감소한 경우<br/>
			3. 시간의 경과에 의하여 재판매가 곤란할 정도로 콘텐츠의 가치가 현저히 감소한 경우<br/>
			4. 복제가 가능한 콘텐츠의 포장을 훼손한 경우<br/>
			5. 이용자의 주문에 의하여 콘텐츠가 개별적으로 생산되는 경우 등 청약철회 등을 인정하면 H2K5에게 회복할 수 없는 중대한 피해가 예상되는 경우로서 사전에 당해 거래에 대하여 별도로 그 사실을 고지하고 이용자의 서면(전자문서를 포함합니다)에 의한 동의를 얻은 경우<br/>
			③ 이용자는 콘텐츠의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행된 경우에는 당해 콘텐츠를 공급받은 날로부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날로부터 30일 이내에 청약철회 등을 할 수 있습니다.<br/>
			④ 이용자는 구두 또는 서면(전자문서를 포함합니다)으로 청약철회 등을 할 수 있습니다.<br/>
			⑤ 이용자가 청약철회 등을 서면으로 하는 경우 그 의사표시가 기재된 서면을 발송한 날에 그 효력이 발생합니다.<br/>
			⑥ 콘텐츠의 훼손에 대하여 이용자의 책임이 있는지의 여부, 콘텐츠의 구매에 관한 계약이 체결된 사실 및 그 시기, 콘텐츠의 공급사실 및 그 시기 등에 관하여 다툼이 있는 경우에는 H2K5가 이를 입증하여야 합니다.<br/>
			<br/>
			<font>제31조 (청약철회등의 효과)</font><br/>
			① 청약철회 등을 한 경우 이용자는 공급받은 콘텐츠를 반환하여야 하며, 다운로드받은 온라인콘텐츠의 경우에는 이를 삭제하여야 합니다. <br/>
			② 콘텐츠의 반환에 필요한 비용은 제1조 제1항에 의한 청약철회 등의 경우 이용자가 부담하며, 제1조 제3항에 의한 청약철회 등의 경우 H2K5가 부담합니다.<br/>
			③ H2K5는 콘텐츠를 반환받은 날부터 3영업일 이내에 지급받은 콘텐츠대금을 환급합니다. 이 경우 H2K5가 이용자에게 콘텐츠대금의 환급을 지연한 때에는 그 지연기간에 대하여 연 20%를 곱하여 산정한 지연이자(이하 "지연배상금"이라 합니다)를 지급합니다. <br/>
			④ H2K5는 이용자에게 청약철회 등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. <br/>
			⑤ H2K5는 반환된 콘텐츠가 일부 사용 또는 일부 소비된 경우 그 콘텐츠의 사용 또는 일부 소비에 의하여 이용자가 얻은 이익 또는 그 콘텐츠의 공급에 소요된 비용에 상당하는 금액(콘텐츠의 사용으로 인하여 소모성 부품의 재판매가 곤란하거나 재판매가격이 현저히 하락하는 경우에는 당해 소모성 부품의 공급에 소요된 비용 또는 다수의 동일한 가분물로 구성된 콘텐츠의 경우에는 이용자의 일부소비로 인하여 소비된 부분의 공급에 소요된 비용)의 범위내에서 이용자에게 청구할 수 있습니다.<br/>
			<br/>
			<font>제32조 (이용자의 해제 또는 해지)</font><br/>
			① 이용자는 다음 각 호의 어느 하나에 해당하는 경우 당해 콘텐츠계약을 해제 또는 해지할 수 있습니다.<br/>
			1. 이용자와 H2K5간에 약정한 해제·해지사유가 발생한 경우<br/>
			2. 법률에서 정한 해제·해지사유가 발생한 경우<br/>
			② H2K5가 콘텐츠를 공급하지 않거나 불완전한 콘텐츠를 공급한 경우에 있어서 이용자가 당해 콘텐츠이용계약을 해제 또는 해지하기 위하여 상당한 기간을 정하여 완전한 콘텐츠를 공급할 것을 최고하여야 합니다. 다만, 이용자는 다음 각 호의 어느 하나에 해당하는 경우 최고를 하지 않고 계약을 해제 또는 해지할 수 있습니다.<br/>
			1. 일정한 시일 또는 기간 내에 콘텐츠를 공급하여야만 그 목적을 달성할 수 있는 계약에서 H2K5가 그 시기에 콘텐츠를 공급하지 아니한 경우<br/>
			2. H2K5가 미리 콘텐츠를 공급하지 않을 의사를 표시한 경우<br/>
			3. 완전한 콘텐츠의 공급이 불가능한 경우(콘텐츠 구입목적을 달성할 수 없는 경우에 한함)  <br/>
			4. 콘텐츠계약이 계속거래에 해당하는 경우<br/>
			5. 기타 법률에 규정되거나 당사자가 합의한 경우<br/>
			<br/>
			<font>제33조 (H2K5의 해제 또는 해지)</font><br/>
			① H2K5는 다음 각 호의 어느 하나에 해당하는 경우 당해 콘텐츠이용계약을 해제 또는 해지할 수 있습니다.<br/>
			1. 이용자와 H2K5간에 약정한 해제·해지사유가 발생한 경우<br/>
			2. 법률에서 정한 해제·해지사유가 발생한 경우<br/>
			② H2K5는 이용자가 콘텐츠 대금을 지급하지 않는 등 채무를 이행하지 않은 경우에 당해 콘텐츠이용계약을 해제 또는 해지하기 위해서 상당한 기간을 정하여 콘텐츠대금의 지급 등을 최고하여야 합니다. 다만, H2K5는 다음 각 호의 어느 하나에 해당하는 경우 최고 없이 계약을 해제 또는 해지할 수 있습니다.<br/>
			1. 이용자가 대금지급 등 채무이행을 거절한 경우<br/>
			2. 기타 법률에서 규정하고 있는 경우<br/>
			<br/>
			<font>제34조 (해제의 효과)</font><br/>
			① H2K5 또는 이용자가 콘텐츠계약을 해제한 경우 이용자는 H2K5에게 콘텐츠를 반환하여야 합니다. 다만, 이용자가 콘텐츠를 이용한 경우 그 사용에 따라 얻은 이익을 반환하여야 합니다.<br/>
			② H2K5는 대금을 받은 날로부터 그 대금에 이자를 더하여 이용자에게 반환하여야 합니다.<br/>
			③ H2K5와 이용자는 제1항 단서에 따른 이익과 제2항에 따른 이자를 상계할 수 있습니다.<br/>
			④ H2K5 또는 이용자는 해제권의 행사와 별도로 상대방에게 손해배상을 청구할 수 있습니다. 다만, 상대방이 손해배상책임을 면하기 위해서는 자신에게 고의 또는 과실 없음을 증명하여야 합니다.<br/>
			<font>제35조 (해지의 효과)</font><br/>
			① H2K5 또는 이용자가 콘텐츠계약을 해지한 경우에 당해 콘텐츠계약은 해지한 시점이후부터 효력을 잃는다.<br/>
			② H2K5 또는 이용자는 해지권의 행사와 별도로 상대방에게 손해배상을 청구할 수 있다. 다만, 상대방이 손해배상책임을 면하기 위해서는 자신에게 고의 또는 과실 없음을 증명하여야 합니다.<br/>
			③ 이용자가 계속거래에 해당하는 콘텐츠계약을 해지한 경우 H2K5가 이용자에게 청구할 수 있는 손해배상액(위약금) 또는 이용자에게 환급하여야 할 금액은 다음 각 호에 의하여 산정됩니다.<br/>
			1. H2K5는 이용자의 해지로 인해 발생하는 손실을 현저하게 초과하는 위약금을 청구하거나 가입비 그 밖의 명칭여하를 불문하고 실제 공급된 콘텐츠의 대가를 초과하여 수령한 대금의 반환을 부당하게 거부하여서는 아니 됩니다.<br/>
			2. 콘텐츠계약이 해지된 경우 이용자는 반환할 수 있는 콘텐츠를 H2K5에게 반환할 수 있으며, H2K5는 반환받은 콘텐츠의 가치에 상당하는 금액을 계약의 해지에 따라 지급하여야 할 환급금에 더하거나 청구할 수 있는 위약금에서 감액하여야 합니다.<br/>
			3. H2K5는 콘텐츠계약이 해지된 때에 이용자로부터 받은 콘텐츠의 대금(콘텐츠가 반환된 경우 환급하여야 할 금액을 포함합니다)이 이미 공급한 콘텐츠의 대금에 위약금을 더한 금액보다 많은 경우에는 그 차액을 이용자에게 환급하여야 합니다. <br/>
			4. H2K5는 차액의 환급을 지연한 경우에 지연기간에 대한 지연배상금을 더하여 환급하여야 합니다.<br/>
			④ 계약의 해지 또는 대금의 환급에 관하여 이용자의 책임이 있는지의 여부, 계약이 체결된 사실 및 그 시기, 콘텐츠의 공급사실 및 그 시기에 관하여 다툼이 있는 경우에는 H2K5가 이를 입증하여야 합니다.<br/>
			<br/>
			<font>제36조 (해제 또는 해지 시 대금의 환급)</font><br/>
			① H2K5는 이용자로부터 해제 또는 해지 통보를 받은 경우 3영업일 이내에 온라인콘텐츠에 대한 대금을 환급합니다.<br/>
			② H2K5는 해제 또는 해지에 따라 오프라인으로 공급한 콘텐츠를 이용자로부터 반환받은 경우 즉시 콘텐츠대금을 환급합니다.<br/>
			③ H2K5가 이용자에게 대금을 환급할 때에 이용대금의 결제와 동일한 방법으로 결제대금의 전부 또는 일부를 환급합니다. 다만, 동일한 방법으로 환급이 불가능할 경우에 즉시 이를 이용자에게 고지하고, 이용자의 선택에 따라 환급합니다.<br/>
			④ H2K5는 콘텐츠계약의 해제 또는 해지로 인하여 이용자가 지급한 대금 중 일부를 위약금 또는 이용금액으로 공제할 경우 복수의 지급수단 중 이용자가 선택한 지급수단에서 공제하며, 이용자의 선택이 없는 경우에 이용자에게 유리한 방법으로 공제합니다.<br/>
			<br/>
			<font>제37조 (스트리밍 방식의 계속적 온라인콘텐츠이용계약의 해지 시 환급)</font><br/>
			① 제6조에도 불구하고, 이용자가 임의적으로 온라인콘텐츠이용계약을 해지하거나 이용자의 책임 있는 사유로 인하여 H2K5가 온라인콘텐츠이용계약을 해지한 경우 H2K5가 이용자에게 환급하여야 할 금액은 전체 이용대금에서 기 이용일수 또는 이용회차에 해당하는 금액과 잔여 대금의 10% 이내의 손해배상금을 공제한 금액으로 합니다. 다만, 이용자가 임의적으로 해지할 수 있는 경우는 H2K5가 이를 인정하거나 온라인 콘텐츠이용계약이 계속거래에 해당하는 경우로 한정됩니다.<br/>
			② H2K5의 책임 있는 사유로 인하여 이용자가 온라인콘텐츠이용계약을 해지한 경우 H2K5가 이용자에게 환급하여야 할 금액은 전체 대금에서 기 이용일수 또는 이용회차에 해당하는 금액을 공제하고, 잔여 대금의 10% 이내의 손해배상금을 더한 금액으로 합니다.<br/>
			③ 제1항 및 제2항에 따라 환급금액을 산정함에 있어 콘텐츠이용 약정기간에 따라 대금 할인율이 상이한 경우 이용자가 장기 콘텐츠이용계약을 체결한 후 단기 할인율이 적용되는 이용기간이 경과한 후 해지한 때에는 단기 할인율을 적용합니다.<br/>
			<h3>제8장 기타</h3><br/>
			<font>제38조 (손해배상) </font><br/>
			공사가 제공하는 서비스 중에서 무료로 제공하는 서비스의 이용과 관련하여 개인정보보호정책에서 정하는 내용에 해당하지 않는 사항에 대하여는 어떠한 손해도 책임을 지지 않습니다.<br/><br/> 
			<font>제39조 (면책 조항)</font><br/> 
			<font class="protectUser">① 공사는 이용자가 서비스를 통해 게재 또는 전송한 정보, 자료, 사실의 정확성, 신뢰성 등 내용에 관하여 어떠한 보증도 하지 아니하며 이용자의 서비스 자료에 대한 취사선택 또는 이용으로 발생하는 손해 등에 대해 책임을 지지 아니합니다.</font> 
			<font class="protectUser">② 공사는 이용자가 서비스를 이용하며 기대하는 손익이나 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 아니합니다. </font>
			<font class="protectUser">③ 공사는 이용자 상호간 또는 이용자와 제3자 상호간에 서비스를 매개로 발생한 분쟁에 대해서는 개입할 의무가 없으며 이로 인한 손해를 배상할 책임도 없습니다.</font> 
			<font class="protectUser">④ 공사는 이용자의 귀책사유로 인하여 서비스 이용의 장애가 발생한 경우에는 책임이 면제 됩니다.</font> 
			<font class="protectUser">⑤ 본 약관의 규정을 위반함으로 인하여 공사에 손해가 발생하게 되는 경우, 이 약관을 위반한 이용자는 공사에 발생되는 모든 손해를 배상하여야 하며, 동 손해로부터 공사를 면책 시켜야 합니다.</font><br/><br/> 
			<font>제40조 (분쟁의 해결)</font><br/>
			① 공사와 이용자 사이의 콘텐츠계약에 관한 소의 관할은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우 거소를 관할하는 지방법원의 전속관할로 합니다.<br/> 
			② 제소 당시 이용자의 주소 또는 거소가 분명하지 아니한 경우에는 민사소송법에 따라 관할법원을 정합니다.<br/><br/> 
			<font>제41조 (불만접수 등)</font><br/>
			공사는 이용자의 공사에 대한 불만 접수 또는 피해구제요청을 위해 H2K5 고객센터를 운영하고 있으며, 이용자는 H2K5 고객센터를 통해 회원정보, 동영상 문의, 결제, 환불 등 불만접수 또는 피해구제요청을 할 수 있습니다.<br/> 
			* H2K5 고객센터 : 1588-1580 (발신자 부담)<br/><br/>
			※ 상기 약관상의 녹색으로 처리된 조항은 '콘텐츠산업진흥법' 제28조 3항 및 ‘콘텐츠이용자보호지침’ 제6조 3항에 따른 표기임을 알려 드립니다.<br/><br/>
			<font>&lt;부칙&gt;</font><br/> 
			<font>1. 본 약관은 2020년 02월 01일부터 적용됩니다.</font><br/>
			<font>2. 2018년 07월 20일부터 시행되던 종전의 약관은 본 약관으로 대체합니다.</font><br/>
			<font>3. 유/무료 VOD/AOD 서비스는 별도의 서비스중지 안내 전까지 서비스 됩니다.</font><br/>
			<font># 단, 초상권,저작권 등의 사유로 별도의 안내 없이 서비스가 중지 될 수 있습니다.</font><br/><br/>   
			
			※별첨 : H2K5패밀리사이트 권장사양정보<br/> 
			<table cellspacing="1" cellpadding="0" summary="H2K5패밀리사이트 이용을 위한 OS, CPU, Memory, 그래픽카드, Network속도에 대한 권장사양정보" align="center" class="tbl_pc">
				<caption>H2K5패밀리사이트 권장사양정보</caption>
				<tbody>
					<tr>
						<th width="10%">사이트 구분</th>
						<th width="20%">OS</th>
						<th width="20%">CPU</th>
						<th width="13%">Memory</th>
						<th width="18%">그래픽카드</th>
						<th width="20%">Network속도</th>
					</tr>
					<tr>
						<th rowspan="3">방송<br/> 다시보기/<br/>다시듣기</th>
						<td>Window</td>
						<td>x86, x64 500MHz<br/>이상</td>
						<td>128MB이상</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>Mac OS<br/>10.4.8+(PowerPC)</td>
						<td>PowerPC G4<br/>800MHz 이상</td>
						<td>128MB이상</td>
						<td></td>
						<td></td>
					</tr><tr>
						<td>Mac OS<br/>10.4.8+(PowerPC)</td>
						<td>Inter Core Duo<br/>1.83GHz 이상</td>
						<td>128MB이상</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<th>강좌<br/>(명품,한자)<br/>동영상강의</th>
						<td>Window XP 이상</td>
						<td>펜티엄4 3.0GHz<br/>이상</td>
						<td></td>
						<td>라데온9500이상<br/>GeforceFX5200<br/>이상</td>
						<td></td>
					</tr>
					<tr>
						<th>방송/직업<br/>모바일<br/>서비스</th>
						<td>안드로이드<br/>2.3(진저브레드)<br/>이상</td>
						<td></td>
						<td></td>
						<td></td>
						<td>TV/라디오방송:<br/>500KB이상 직업강좌:1M이상</td>
					</tr>
					<tr>
						<th>수능<br/>동영상<br/>강의</th>
						<td>Window XP SP3<br/> 이상</td>
						<td>Core2 Duo<br/>1.8GHz</td>
						<td>4G</td>
						<td>64M 이상의 Nvidia 또는 동급의 그래픽 카드</td>
						<td>고화질 서비스600KB이상 속도조절기능1.2M이상<br/></td>
					</tr>
					<tr>
						<th>수능<br/>모바일앱<br/>이용</th>
						<td>안드로이드 2.3(진저브래드)이상</td>
						<td></td>
						<td></td>
						<td></td>
						<td>※모바일앱:500KB 강의 모바일웹:1M강의</td>
					</tr>
					<tr>
						<th rowspan="2">H2K5e<br/>VOD학습</th>
						<td>Window XP 이상</td>
						<td>펜티엄4 1.6GHz 이상</td>
						<td>256MB이상</td>
						<td rowspan="2">라데온9500이상 GeforceFX5200이상</td>
						<td rowspan="2">※600KB:2012년까지VOD1MB:2013년이후VOD</td>
					</tr>
					<tr>
						<td>Mac OS 10.7 이상</td>
						<td>Inter Core2 Duo 이상</td>
						<td>256MB이상</td>
					</tr>
					<tr>
						<th rowspan="2">H2K5e<br/>플래시학습</th>
						<td>Window XP 이상</td>
						<td>x86 3.0GHz 이상</td>
						<td>512MB이상</td>
						<td rowspan="2">128MB 이상</td>
						<td rowspan="2">600KB~1MB이상</td>
					</tr>
					<tr>
						<td>Mac OS 10.6 이상</td>
						<td>Intel Core Duo 1.83GHz 이상</td>
						<td>512MB이상</td>
					</tr>
					<tr>
						<th>H2K5lang<br/>학습</th>
						<td>Window XP 이상</td>
						<td>펜티엄3급 500MHz 이상</td>
						<td>64MB이상</td>
						<td>32MB 이상</td>
						<td>600KB 이상</td>
					</tr>
					<tr>
						<th>H2K5Math</th>
						<td>Window XP 이상</td>
						<td>2.33GHz 이상의x86호환프로세서</td>
						<td>512MB이상</td>
						<td>128MB 이상</td>
						<td>600KB~1M이상</td>
					</tr>
					<tr>
						<th rowspan="2">H2K5초중학<br/>학습</th>
						<td>Window XP SP3 이상</td>
						<td>x86, x64 1.6GMHz 이상</td>
						<td>512MB이상</td>
						<td></td>
						<td>500KB 이상</td>
					</tr>
					<tr>
						<td>Mac OS<br/>10.4.8+(Intel기반)</td>
						<td>Intel Core Duo<br/>1.83GHz 이상</td>
						<td>512MB이상</td>
						<td></td>
						<td>500KB 이상</td>
					</tr>
				</tbody>
			</table>				
		</div>
	<p class="agreement">
		<input type="checkbox" class="agreementInput" id="agree1" name="clause_agree_yn" value="Y"/>
		<label for="agree1" class="st_label01"><i></i>약관을 충분히 이해하였으며 동의 합니다.</label>
	</p>
	<h2>개인정보 수집 및 이용에 대한 안내 (필수)</h2>
		<table summary="개인정보 수집 및 이용 안내 테이블. 수집목적, 수집항목, 보유기간" class="data_table">
				<caption>개인정보 수집 및 이용에 대한 안내 (필수)</caption>
				<colgroup>
					<col width="33.3%" />
					<col width="33.3%" />
					<col width="33.3%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">수집목적</th>
						<th scope="col">수집항목</th>
						<th scope="col">보유기간</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>이용자 식별 및 본인 여부 확인</td>
						<td>아이디, 비밀번호, 이름, 생년월일, 이메일, 단말기 기기정보</td>
						<td rowspan="2">회원탈퇴 시 까지</td>
					</tr>
					<tr>
						<td>만14세 미만 가입 시 법정대리인 동의</td>
						<td>법정대리인 이름, 법정대리인 휴대전화번호 혹은 아이핀</td>
					</tr>
				</tbody>
			</table>
			<p class="agree_desc">
				* EBS인터넷 서비스 제공을 위하여 필요한 최소한의 개인정보이므로 동의를 해주셔야 서비스를 이용하실 수 있습니다.<br />
				* 이 외 서비스 이용과정에서 별도 동의를 통해 추가정보 수집이 있을 수 있습니다.
			</p>
			<p class="agreement">
				<input type="checkbox" class="check01 next-focus" id="agree2" name="prsnl_info_essntl_agree_yn" value="Y"/>
				<label for="agree2" class="st_label01"><i></i>개인정보 수집 및 이용(필수)에 대한 안내를 이해하였으며 동의 합니다.</label>
			</p>
			<h2 class="next_tit">개인정보 수집 및 이용에 대한 안내 <span>(선택)</span></h2>
		<table summary="개인정보 수집 및 이용 안내 테이블. 수집목적, 수집항목, 보유기간" class="data_table">
			<caption>개인정보 수집 및 이용에 대한 안내 (선택)</caption>
			<colgroup>
				<col width="33.3%" />
				<col width="33.3%" />
				<col width="33.3%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">수집목적</th>
					<th scope="col">수집항목</th>
					<th scope="col">보유기간</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>이용자 식별 및 본인 여부 확인</td>
					<td>성별, 휴대전화번호</td>
					<td>회원탈퇴 시 까지</td>
				</tr>
			</tbody>
		</table>
		<p class="agree_desc">
			* 동의를 거부하시는 경우에도 회원가입이 가능합니다.
		</p>
		<p class="agreement">
			<input type="checkbox" class="check01" id="agree3" name="prsnl_info_selct_agree_yn" value="Y"/>
			<label for="agree3" class="st_label01"><i></i>개인정보 수집 및 이용(선택)에 대한 안내를 이해하였으며 동의 합니다.</label>
		</p>
		
		<div class="btn_area">
			<button type="submit" class="cssbtn big on" id="confirmButton" >
				<span>확인</span>
			</button>
		</div>
		</form>
	</div>
</body>
<style>
.data_table{
border: 1px solid gray;
}

caption{
display: none;
}

</style>
</html>