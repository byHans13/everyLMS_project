<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <!-- 차트 링크 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    <!-- 부트스트랩 -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
<style>
html, body {
   height: 100%;
   margin: 0
}             
    #errP{
    color: red;
    }
    #rateChart{
    display: none;
    }

aside {
	width: 300px;
	float: left;
}
section {
	width: 1000px;
	float: left;
			position: absolute;
	transform:translate(320px,20px);
}
 .menu{
    margin-left: 20px;
    text-align:center;
    width: 200px;
    border: 1px black solid;
    float: left;
} 
        
    </style>
    </head>
    <body>
    <header>
    <jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_teacherAside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
 <h1>강의 업로드 폼</h1>
        <form action="insertclassupload?${_csrf.parameterName }=${_csrf.token}" method="post" enctype="multipart/form-data" id="frm">
        <table>
            <tr>
                <th>강의명을 입력하시오</th>
                <td><input type="text" placeholder="강의명" name='cl_clname'></td>
            </tr>
            <tr>
                <th>썸네일을 입력하시오</th>
                <td><input type="file" name="fileName" id="files"></td>
            </tr>
            <tr>
                <th>시작날짜를 입력하시오(ex.2020/08/22)</th>
                <td><input type="date" name='cl_stday'></td>
            </tr>
            <tr>
                <th>종료날짜를 입력하시오(ex.2020/08/22)</th>
                <td><input type="date" name='cl_fnday'></td>
            </tr>
            <tr>
                <th>강의 가격을 입력하시오(ex.100point=>100)</th>
                <td><input type="number" placeholder="강의가격" name='cl_pt'>POINT</td>
            </tr>
            <tr>
                <th>강좌 회차를 입력하시오</th>
                <td><input type="number" placeholder="강의회차" name='cl_lcnum'>회차</td>
            </tr>
            <tr>
                <th>레벨을 설정하시오(1~5)</th>
                <td><input type="number" placeholder="레벨" name='cl_lv'></td>
            </tr>
            <tr>
                <th>관심사를 선택하시오</th>
                <td><input type="radio" value="여행" name='cl_cc'>여행<input type="radio" value="영화감상" name='cl_cc'>영화감상
                <input type="radio" value="음악감상" name='cl_cc'>음악감상<input type="radio" value="인터넷" name='cl_cc'>인터넷
                <input type="radio" value="컴퓨터" name='cl_cc'>컴퓨터</td>
            </tr>
        </table>
       <p>강의별 점수 백분율</p>
  		    출석: <input type="number" id="rc_at" name="rc_at">%<br>
     	    과제: <input type="number" id="rc_hw" name="rc_hw">%<br>
     	    퀴즈: <input type="number" id="rc_qz" name="rc_qz">%<br>
    	    최종시험: <input type="number" id="rc_test" name="rc_test">%<br>
    	  <p id='rateErr' style="color: red;"><p>
    	  <button type="button" onclick="openRateChart()">백분율 확인하기</button>
       
       
        <div class="container" id='rateChart'>
        <div class="card" style="height: 300px; width: 500px; margin-left: -130px;">
            <div class="card-body"> <canvas id="myChart1"></canvas> </div>
        </div>
    </div>
        <button type="button" id='insertClassBnt'>등록하기</button> ||  <button type="reset">취소</button>
    </form>
    <input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
     <p id='errP'></p>
      		  </section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
     
     
    <script>
    var num;
    var rateNum = 0;
    $('#insertClassBnt').click(function() {
    	num = 0;
    	
    	var $input = $('table input');
    	console.dir($input[0]);

    	for(var i=0; i<$input.length; i++){
    		if($input[i].type != "radio"){
    			console.log("radio타입 아님 num: "+num)
        		if($input[i].value==""||$input[i].value==null){
        			num=1;
    		}
			}
    	}
    	
    	if($input[7].checked==false && $input[8].checked==false && $input[9].checked==false && $input[10].checked==false  && $input[11].checked==false){
			num=2;
		}
    	
    	var lv = parseInt($input[6].value);
    	console.log("$input[6].value: " + $input[6].value)
    	if(lv<1 || lv>5 ){
    		num=3;
   		
    	}
    	
    	daycal();
    	
    	console.log("num         :"+num);
    	
    	switch (num) {
		case 0:
			console.log("num: "+num);
			console.log("isfile:; "+isfile);
			console.log("rateNum:; "+rateNum);
			console.log("rateNum:; "+rateNum);
			console.log("openRateChart(): "+openRateChart());
			if(isfile == 1 && rateNum==100){
				if(openRateChart()){
	    		$('#insertClassBnt').attr("type","submit");
	    		$('#insertClassBnt').submit();	
				}
	    	}else if(isfile != 1){
	    		alert("동영상을 선택해 주세요.");
	    	}else if(rateNum != 100){
	    		alert("백분율을 버튼을 통해 확인해 주세요.");
	    	}
			break;
		case 1:
			$('#errP').text('');
            $('#errP').text('빈칸이 있으면 안됩니다.');	
			break;
		case 2:
			 $('#errP').text('');
	            $('#errP').text('관심사를 선택해 주세요');
			break;
		case 3:
			 $('#errP').text('');
	            $('#errP').text('1~5까지의 레벨만 설정가능합니다.');
			break;
		case 4:
			 $('#errP').text('');
	            $('#errP').text('현재날짜보다 시작일이 빠를 수 없습니다. ');  
			break;
		case 5:
			 $('#errP').text('');
	            $('#errP').text('시작일과 종료일이 같을 수 없습니다.');
			break;
		case 6:
			$('#errP').text('');
       	 $('#errP').text("종료일이 시작일보다 빠를 수 없습니다.");
       
			break;

		default:
			break;
		}
    	
        
    })


    
    
    
    function daycal(){
    	
        var stdayArr =document.getElementsByName('cl_stday')[0].value.split('-');
        var stday="";
        for(var i=0; i<stdayArr.length; i++){
            stday += stdayArr[i];
        }
        var intSt =parseInt(stday);

        var fndayArr =document.getElementsByName('cl_fnday')[0].value.split('-');
        var fnday="";
        for(var i=0; i<fndayArr.length; i++){
            fnday += fndayArr[i];
        }
        var intFn =parseInt(fnday);

        var now = new Date(); 
        var month = now.getMonth()+1; 
        var day = now.getDate();
        var year = now.getFullYear();
        if(month<10){
            month ="0"+month;
        }
        if(day<10){
            day = "0"+day;
        }
       
       var nowdate =""; 
       nowdate = parseInt(""+year+month+day);
       
       if(nowdate > intSt){
    	   num=4;
            console.log("nowdate > intSt");
        }else if(intSt==intFn){
        	num=5;
            console.log("intSt=intFn");
           
        }else if(intSt>intFn){
        	num=6;
        	
    }
    }
    
    var isfile = 0;
    $('#files').on("change",function(){
    	console.dir(this);
    	if($(this).val()==""){
    		console.log("파일이 없습니다.");
    		isfile = 0;
    	}else{
    		console.log("파일이 있습니다.");
    		isfile = 1;
    	}
    });
    
    
    
    function openRateChart() {
    	
    	var at = parseInt($('#rc_at').val());
    	var hw = parseInt($('#rc_hw').val());
    	var qz = parseInt($('#rc_qz').val());
    	var test = parseInt($('#rc_test').val());
    	console.log(at,hw,qz,test);
    	var sum = at+hw+qz+test;
    	if(at=="" || hw =="" || qz =="" || test ==""){
    		$("#rateChart").css("display","none");
    		$('#rateErr').text("값을 입력해주세요(없을 경우 0 으로 등록)");
    		return false;
    	}else if((at+hw+qz+test)!=100){
    		$("#rateChart").css("display","none");
    		 
    		 if(isNaN(sum)){
    			 sum=0;
    		 }
    		$('#rateErr').text("합이 100%가 되어야합니다.(총합:"+(sum)+"%)");
    		return false;
    	}else{
    		rateNum = at+hw+qz+test;
    		console.log("합: "+(sum));
    		$("#rateChart").css("display","block");
    		console.log($("#rateChart").css("display"));
    		data = {
    	            datasets: [{ backgroundColor: ['red', 'yellow', 'blue','green'], data: [at, hw, qz, test] }],
    	            // 라벨의 이름이 툴팁처럼 마우스가 근처에 오면 나타남
    	            labels: ['출석', '과제', '퀴즈','최종시험']
    	        };
    	        // 가운데 구멍이 없는 파이형 차트
    	        var ctx1 = document.getElementById("myChart1");
    	        var myPieChart = new Chart(ctx1,
    	            {
    	                type: 'pie', data: data, options: {}
    	            });
    	        return true;

    	}
    	
		
	}
    
    
   

        
    </script>
   
    
</body>
</html>