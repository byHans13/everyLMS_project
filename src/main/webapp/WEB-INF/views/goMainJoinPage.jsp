<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=be5cba63ad7a176f9eba52bf834d7014&libraries=services"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>H2K5 - 회원가입</title>
<style>
table {
	margin:auto;
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
}
</style>
<script language="javascript">
  
	var result= 0; // 중복체크 여부를 파악하는 변수

	function validate() {
       var re = /^[a-zA-Z0-9]{4,12}$/; // 아이디와 패스워드가 적합한지 검사할 정규식
       var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일이 적합한지 검사할 정규식
       var rgEx = /(01[016789])([1-9]{1}[0-9]{2,3})([0-9]{4})$/; 

       var id = document.getElementById("id");
       var pw = document.getElementById("pw");
       var email = document.getElementById("email");
       var num1 = document.getElementById("num1");
       var num2 = document.getElementById("num2");
       var name = document.getElementById("name");
       var loe = document.getElementById("loe");
       var add = document.getElementById("sample5_address");
       var hp = document.getElementById("hp");
       
       var arrNum1 = new Array(); // 주민번호 앞자리숫자 6개를 담을 배열
       var arrNum2 = new Array(); // 주민번호 뒷자리숫자 7개를 담을 배열

       
    
       
       
       // ------------ 이메일 까지 -----------

       if(!check(re,id,"아이디는 4~12자의 영문 대소문자와 숫자로만 입력")) {
           return false;
       }

       if(!check(re,pw,"패스워드는 4~12자의 영문 대소문자와 숫자로만 입력")) {
           return false;
       }

       if(join.pw.value != join.checkpw.value) {
    	   alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
           join.checkpw.value = "";
           join.checkpw.focus();
           return false;
       }

       if(email.value=="") {
    	   alert("이메일을 입력해 주세요");
           email.focus();
           return false;
       }

       if(!check(re2, email, "적합하지 않은 이메일 형식입니다.")) {
           return false;
       }

       if(name.value=="") {
           alert("이름을 입력해 주세요");
           name.focus();
           return false;
       }
		
       // -------------- 주민번호 -------------

       for (var i=0; i<num1.value.length; i++) {
                arrNum1[i] = num1.value.charAt(i);
            } // 주민번호 앞자리를 배열에 순서대로 담는다.

            for (var i=0; i<num2.value.length; i++) {
                arrNum2[i] = num2.value.charAt(i);
            } // 주민번호 뒷자리를 배열에 순서대로 담는다.

            var tempSum=0;

            for (var i=0; i<num1.value.length; i++) {
                tempSum += arrNum1[i] * (2+i);
            } // 주민번호 검사방법을 적용하여 앞 번호를 모두 계산하여 더함

            for (var i=0; i<num2.value.length-1; i++) {
                if(i>=2) {
                    tempSum += arrNum2[i] * i;
                }
                else {
                    tempSum += arrNum2[i] * (8+i);
                }
            } // 같은방식으로 앞 번호 계산한것의 합에 뒷번호 계산한것을 모두 더함

       if((11-(tempSum%11))%10!=arrNum2[6]) {
           alert("올바른 주민번호가 아닙니다.");
           num1.value = "";
           num2.value = "";
           num1.focus();
           return false;
       }
		// ---------핸드폰-------------
       if(hp.value=="") {
           alert("휴대번호를 입력해주세요.");
           hp.focus();
           return false;
       }
       
       if(!check(rgEx, hp, "올바른 휴대폰번호가 아닙니다.")){
        return false;
       }
      
       if(loe.value=="") {
           alert("학력을 입력해 주세요");
           loe.focus();
           return false;
       }
       
       // 관심분야 미입력시 하라는 메시지 출력
       if(join.cc_cc[0].checked==false &&
           join.cc_cc[1].checked==false &&
           join.cc_cc[2].checked==false &&
           join.cc_cc[3].checked==false &&
           join.cc_cc[4].checked==false) {
           alert("관심분야를 골라주세요");
           return false;
       }
    
       if(add.value=="") {
           alert("주소를 입력해 주세요");
           add.focus();
           return false;
       }
       
       if(result==0){
    	   alert("중복체크 해주세요.");
    	   return false;
       }
       
       alert("회원가입이 완료되었습니다.");
       return true;
       
   }

   function check(re, what, message) {
       if(re.test(what.value)) {
           return true;
       }
       alert(message);
       what.value = "";
       what.focus();
       return false;
   }
   
 //-------아이디 중복체크
   function idclick() {
   	var id = join.mb_id.value;
   
   	console.log(id);
   	   $.ajax({
   			type:'get',
   			url:'rest/idclick?id='+id,
   			beforeSend : function(xhr)
   			{
   				//이거 안하면 403 error
   				//데이터를 전송하기 전에 헤더에 csrf값을 설정한다
   				var $token = $("#token");
   				xhr.setRequestHeader($token.data("token-name"), $token.val());
   			},
   			success: function (json) {
   				console.log(json);
   				if(json>0){
   					alert("이미 사용중인 아이디입니다.");
   					result =0;
   				}else{
   					alert("사용 가능한 아이디입니다.");
   					result =1;
   				}
   			
   			},
   			error: function (err) {
   				console.log(err);
   			}
   			
   		});
   }
   
</script>
</head>
<body>
<input type="hidden" id="token"  data-token-name="${_csrf.headerName}" name = "${_csrf.parameterName}" value="${_csrf.token}" />
<a href="/h2k5every/"><img src="upload/h2k5_mainLogo.PNG" id="mainlogo" width="200"></a>
<h1 align="center" style="font-size:50px;"><font color="navy"><b>오픈플랫폼</b></font></h1>
<form name="join" onsubmit="return validate();" action="insertmemberjoin" method="post">
    <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
   <table>
       <tr height="10" align="center">
           <td colspan="2" style="background:navy;"><font color=white><b>회원기본정보</b></font></td>
       </tr>
       <tr>
           <td><b>아이디:</b></td>
           <td>
           <input type="text" style="width:170px"id="id" name="mb_id" maxlength="12" />
           <input type="button" onclick="idclick()" value="중복체크">  ※4-12자의 대소문자와 숫자로만 입력
           	</td>
       </tr>
       <tr>
           <td><b>비번:</b></td>
           <td><input type="password"  style="width:170px"id="pw" name="mb_pw" maxlength="12"/> ※4-12자의 대소문자와 숫자로만 입력</td>
       </tr>
       <tr>
           <td><b>비번확인:</b></td>
           <td><input type="password" style="width:170px" id="checkpw" maxlength="12"/></td>
       </tr>
       <tr>
           <td><b>메일주소:</b></td>
           <td><input type="email" style="width:170px" name="mb_email" id="email" /> ex)wjdxo513@naver.com</td>
       </tr>
       <tr>
           <td><b>이름:</b></td>
           <td><input type="text" style="width:170px" id="name" name="mb_name" maxlength="12" /></td>
       </tr>
        <tr>
           <td><b>성별:</b></td>
           <td>
           		<input type="radio" name="mb_gender" value="남" checked/>남자
           		<input type="radio" name="mb_gender" value="여"/>여자
           </td>
       </tr>
       <tr  height="10" align="center">
           <td colspan="2" style="background:navy;"><font color=white><b>개인정보</b></font></td>
       </tr>
       <tr>
           <td><b>주민등록번호:</b></td>
           <td><input type="text" name="mb_rrn1" id="num1" size="10" maxlength="6"/>-
           	<input type="password" name="mb_rrn2" id="num2" size="10" maxlength="7"/>
           	예) 123456-1234567
           </td>
       </tr>
       <tr>
           <td><b>핸드폰:</b></td>
           <td>
              <input type="text" id="hp" name="mb_phone"/> 예) 0109998888 or 0104447777
           </td>
       </tr>
       <tr>
           <td><b>학력:</b></td>
           <td>
              <input type="text" id="loe" name="mb_loe"/> 예)○○대학교
           </td>
       </tr>
       <tr>
           <td><b>관심사분야:</b></td>
           <td>
              <input type='checkbox' name='cc_cc' value='컴퓨터'/>컴퓨터
              <input type='checkbox' name='cc_cc' value='인터넷'/>인터넷
              <input type='checkbox' name='cc_cc' value='여행'/>여행
              <input type='checkbox' name='cc_cc' value='영화감상'/>영화감상
              <input type='checkbox' name='cc_cc' value='음악감상'/>음악감상
           </td>
       </tr>
       <tr>
           <td><b>주소:</b></td>
           <td>
              <input type="text" id="sample5_address" name="mb_addr" placeholder="주소검색후 상세정보입력">
              <input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색">
              ex)경기 xx시 xx동 xx아파트 xxx동 xxx호
           </td>
       </tr>
        </table>
       <div id="map" style="width:655px;height:300px;margin-top:10px;display:none;margin-left: 625px;" ></div>
       <br>
       <br>
       <div style="margin-left:630px;">
       <input type="submit" value="회원가입" style="border-radius:5px; width: 655px; height: 50px; font-size: 20px;" id="aaa"/>
       </div>
       <br>
</form>

<script>
	
	


//-------지도 api
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = {
        center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };

//지도를 미리 생성
var map = new daum.maps.Map(mapContainer, mapOption);
//주소-좌표 변환 객체를 생성
var geocoder = new daum.maps.services.Geocoder();
//마커를 미리 생성
var marker = new daum.maps.Marker({
    position: new daum.maps.LatLng(37.537187, 127.005476),
    map: map
});



function sample5_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = data.address; // 최종 주소 변수

            // 주소 정보를 해당 필드에 넣는다.
            document.getElementById("sample5_address").value = addr;
            // 주소로 상세 정보를 검색
            geocoder.addressSearch(data.address, function(results, status) {
                // 정상적으로 검색이 완료됐으면
                if (status === daum.maps.services.Status.OK) {

                    var result = results[0]; //첫번째 결과의 값을 활용

                    // 해당 주소에 대한 좌표를 받아서
                    var coords = new daum.maps.LatLng(result.y, result.x);
                    // 지도를 보여준다.
                    mapContainer.style.display = "block";
                    map.relayout();
                    // 지도 중심을 변경한다.
                    map.setCenter(coords);
                    // 마커를 결과값으로 받은 위치로 옮긴다.
                    marker.setPosition(coords)
                }
            });
        }
    }).open();
}
</script>
</body>
</html>