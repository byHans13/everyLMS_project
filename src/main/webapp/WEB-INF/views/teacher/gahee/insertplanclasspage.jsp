<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
</head>
<body>
<h1>강의 계획서</h1>
 <form action="insertplanclass?${_csrf.parameterName }=${_csrf.token}" method="post">
        <table>
        <tr>
                <th>강의 명</th>
                <td><input type="text" value="${cl_name}" readonly="readonly"></td>
            </tr>
             <tr>
                <th>강의 총 회차</th>
                <td><input type="text" value="${cl_lcnum}" readonly="readonly" >회차</td>
            </tr>
            <tr>
                <th>강의 레벨</th>
                <td><input type="number" name='pc_lv'  value="${cl_lv}" readonly="readonly"></td>
            </tr>
            <tr>
                <th>개요</th>
                <td><input type="text" name='pc_title' placeholder="개요입력"></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea style="overflow: auto;" placeholder="내용입력" name='pc_cont' id="pc_cont"></textarea></td>
            </tr>
        </table>
        <p id='errP'></p>
        <button type="button" id='insertPlanClassBnt'>등록하기</button> ||  <button type="reset">취소</button>
        <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="hidden" id='token' data-token-name='${_csrf.headerName }' value='${_csrf.token }'/>
        <input type="hidden" value="${idNum}" name="pc_idnum">
    </form>
    
    <script>
    var num;
    $('#insertPlanClassBnt').click(function() {
    	 var $input = $('input');
    	num=0;
    	for(var i=0; i<$input.length; i++){
        	if($input[i].value == null || $input[i].value =="" || $input[i].value ==" "){
        		num=1;
        		
        	}
        }
    	
    	switch (num) {
		case 0:
			var cont = $('#pc_cont').val();
			var pc_cont = cont.replace(/\n/g, '<br>');
			$('#pc_cont').val(pc_cont);
			$('#insertClassBnt').attr("type","submit");
    		$('form').submit(); 
			break;
		case 1:
			$('#errP').text('');
            $('#errP').text('빈칸이 있으면 안됩니다.');
			break;

		default:
			break;
		}
    	

	});
    
    
    
    
    
    
    </script>

</body>
</html>