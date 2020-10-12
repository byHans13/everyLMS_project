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
#cs {
	text-align: center;
	top: 50%;
	left: 50%;
/* 	transform: translate(-50%, -50%);
	position: absolute; */
	padding: 5px 10px;
    white-space:nowrap;
}
#search {
	text-align: center;
	top: 85%;
	left: 50%;
/* 	transform: translate(-50%, -50%);
	position: absolute; */
	padding: 5px 10px;
}

#Paging {
	text-align: center;
	top: 85%;
	left: 30%;
/* 	transform: translate(-50%, -50%);
	position: absolute; */
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
		position: absolute;
	transform:translate(300px,0px);
}

#modal {
   display: none;
   position: fixed;
   position: absolute;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%
}

#modal.open {
   display: block;
   color: red;
}

#modal #bg_modal {
   position: absolute;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background: #000;
   opacity: .5;
   filter: alpha(opacity = 50);
   z-index: 100
}

#contents_modal {
   position: absolute;
   top: 40%;
   left: 40%;
   width: 600px;
   height: 500px;
   margin: -150px 0 0 -194px;
   padding: 28px 28px 0 28px;
   border: 2px solid #555;
   background: #fff;
   font-size: 12px;
   z-index: 200;
   color: #767676;
   line-height: normal;
   white-space: normal;
   overflow: scroll
}
</style>
</head>
<body>
<header>
		<jsp:include page="../h2k5every_loginHeader.jsp" />
	</header>
	<aside>
		<jsp:include page="../h2k5every_aside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
	<input type='hidden' id='token' data-token-name='${_csrf.headerName}'
		name='${_csrf.parameterName}' value='${_csrf.token}' />
	<input type="hidden" name="${_csrf.parameterName}"
		value="${_csrf.token}" />
		
	<input Type="hidden" value="${id}" id="hiddenid">
	<select id="LIKEMYCC" name="LIKEMYCC" style="width: 70px; height: 50px">
		<option>---------</option>
		<c:forEach var="cc" items="${CList}" varStatus="i">
			<option value="${cc.cc_cc}">${cc.cc_cc}</option>
		</c:forEach>
	</select>
	<div id=viewlevel></div>
	<div id="cs">
	<table style="margin: auto; text-align: center;">
		<tr bgcolor="skyblue" height="30">
			<th width="150">관심사</th>
			<th width="150">사진</th>
			<th width="150">강좌명|교수명|강의수|level</th>			
			<th width="150">평점</th>
			<th width="150">강의계획서</th>
			<th width="150">수강신청</th>
		</tr>
		<tbody id="tableShow">
		<c:forEach var="Clasc" items="${cList}">
				<tr height="25">
					<td align="center">${Clasc.cl_cc}</td>
					<td align="center"><img src="<c:url value="../picture/${Clasc.pi_pisysname}"/>"width="50px;"/></td>
					<td align="center"><h2>${Clasc.cl_clname}</h2>${Clasc.cl_id} | ${Clasc.co_num} |${Clasc.cl_lv}</td>
					  <c:choose>
                     <c:when test="${Clasc.gpa_gpa eq 0}">
                        <th><h3>등록된 강의가 없습니다.</h3></th>
                     </c:when>
                     <c:when test="${Clasc.gpa_gpa ne 0}">
                        <th width="150"><h2>${Clasc.gpa_gpa}</h2></th>
                     </c:when>
                  </c:choose>

					<td align="center"><a href='goSelectClassReport?cl_idnum=${Clasc.cl_idnum}'>강의계획서</a></td> 
					<td><a href='#' onclick="openBuyPage(${Clasc.cl_idnum} , ${Clasc.cl_lv})\">수강신청 하러가기</a></td>
					<td><input type='hidden'value='${Clasc.cl_clname}'id="searchval"></td>
								
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	<div id="search">
	<form action= "lnterestSearch" name="lnterestSearch">
	<select name="selvalue">
		<option value="searchcc">관심사</option>
		<option value="searchWriter">교수명</option>
	</select>
	<input type="text" name="search" placeholder="입력하기" />
	<button>검색하기</button>
	</form>
	</div>
	<div id="Paging">${Paging}</div>
	<div id='modal'>
			<div id='bg_modal'></div>
			<div id='contents_modal'></div>
		</div>
		
	</section>
	<footer>
		<jsp:include page="../h2k5every_footer.jsp" />
	</footer>
</body>


<script type="text/javascript">
	$('#LIKEMYCC')
			.change(
					function() {
						var select_sub = $('#LIKEMYCC').val();
						var json = new Object();
						json.cc_cc = select_sub;
						$.ajax({
									type : 'post',
									dataType : 'json',
									url : 'rest/selectMyinterestAjax',
									beforeSend : function(xhr) {
										var $token = $("#token");
										xhr.setRequestHeader($token.data("token-name"), $token.val());
									},
									contentType : 'application/json; charset=UTF-8',
									data : JSON.stringify(json),
									success : function(result) {
										console.log(result);
										$('#LIKEMYCC').val('---------');
										$('#Paging').remove();
										str = "";
										for ( var i in result) {
											str += "<tr><th>" + result[i].cl_cc+ "</th>";
											str += "<th><img src='<c:url value='../picture/"+result[i].pi_pisysname+"'/>'width='150px;'></th>";
											str += "<th><h2>" + result[i].cl_clname+ "</h2>|" + result[i].cl_id+ "|" +result[i].co_num+ "|" + result[i].cl_lv+ "</th>";
											   if(result[i].gpa_gpa == 0){
				                                     str += "<th><h2>등록된 평점이 없습니다.<h2></th>"
				                                  }else{
				                                  str += "<th><h2>"+result[i].gpa_gpa+"</h2></th>"
				                                  }     
											str += "<th><a href='goSelectClassReport?cl_idnum="
													+ result[i].cl_idnum
													+ "'>강의계획서</th>";
													
										    str+="<td><a href='#' onclick=\"openBuyPage('"+result[i].cl_idnum+"', '"+result[i].cl_lv+"')\">수강신청 하러가기</a></td></tr>";
												
											$("#tableShow").html(str);
										}

									},
									error : function(request, status, error) {
										alert("code :" + request.status + "\ n"
												+ "message :"
												+ request.responseText + "\ n"
												+ "error :" + error);
									}
								});// ajax
					});
	function openBuyPage(idnum, lv){
		$("#modal").addClass('open');
	var m_contents=$('#contents_modal');
	var obj = {"cl_idnum":idnum, "cl_lv":lv};
	console.log(obj);
	$.ajax({
		type:'get',
		url: "rest/selectBuyClass",
		data:obj,
		dataType:'json',
		success:function(json){
			if(Object.keys(json).length!=0){				
				m_contents.append("<h3>강의 구매<h3>");
				m_contents.append("<p>강의명: "+json.cb.cl_clName+"</p>");
				m_contents.append("<p>학습레벨: lv"+json.cb.cl_lv+"</p>");
				m_contents.append("<p>강수: "+json.cb.cl_lcnum+"강</p>");
				m_contents.append("<p>수강기간: "+json.cb.cl_stDay.substring(0,10)+" ~ "+json.cb.cl_fnDay.substring(0,10)+"</p>");
				m_contents.append("<p>강의가격: <input type='text' value='"+json.cb.cl_pt+"' readonly> point</p>");
				m_contents.append("<p>나의 보유 포인트: <input type='text' value='"+json.mb.mb_point+"' readonly> point</p>");
				var deductPoint = json.mb.mb_point - json.cb.cl_pt;
				m_contents.append("<p>차감 후 남는 포인트: <input type='' value='"+deductPoint+"' readonly> point</p><br/>");
				var booleanPoint = deductPoint>=0;
				m_contents.append("<input type='checkbox'id='mustChk'/><b> 위 상품 정보 및 거래 조건을 확인하였으며, 구매 진행에 동의합니다.(필수)</b>");
				m_contents.append("<p id='err'></p>");
				m_contents.append("<input type='button' value='구매하기' onclick=\"insertBuyClass('"+json.cb.cl_idnum+"','"+json.cb.cl_lv+"','"+json.cb.cl_pt+"','"+booleanPoint+"')\">");
			}else{
				alert("구매하기창 불러오기에 실패했습니다.");
			}
		},error: function(err){
			console.log(err);
		}
	});//ajaxEND
};//openBuyPage END


function insertBuyClass(idnum, lv, point, bool){
	   var obj= {"cl_idnum":idnum,"cl_lv":lv, "cl_pt":point};
	   console.log(obj);
	   var chkbox = $("input:checkbox[id=mustChk]").is(":checked");
	   if(chkbox == true){
	      if(bool == 'true'){
	         $.ajax({
	            type:'post',
	            url:'rest/insertBuyClass',
	            data:obj,
	            dataType:'json',
	            beforeSend : function(xhr){
	               var $token = $("#token");
	               xhr.setRequestHeader($token.data("token-name"), $token.val());
	            },
	            success: function(json){
	               console.log(json);
	               if(json == true){
	                  alert("수강신청이 완료되었습니다.");
	                  location.replace("selectMyClassManagementPage");
	               }else{
	                  alert("수강신청에 실패했습니다. 관리자에게 문의해주세요.");
	                  location.replace("selectMyClassManagementPage");
	               }
	            },error: function(err){
	               console.log(err);
	               alert("err: 수강신청 오류 강의정보 오류");
	            }
	         });
	      }else{
	         if(confirm("포인트가 부족합니다. 포인트 구매창으로 이동하시겠습니까?")){
	            alert("페이지 구현 중!");
	         }else{
	            alert("창을 종료합니다.");
	            modal.removeClass('open');
	         }
	      }
	   }else{
	      $('#err').attr("style","color:red");
	      $('#err').html("체크 후 구매하기를 진행하실 수 있습니다.");
	   }
	};// function insertBuyClass END
	
	$("#modal").find('#bg_modal').on('mousedown',function(evt){
		console.log(evt);
		$("#modal").removeClass('open'); 
	});// modal mousesdown end
	$(document).keydown(function(evt){
		if(evt.keyCode !=27){
			return;
		}else if ($("#modal").hasClass('open')){
			$("#modal").removeClass('open');
		};
	}) //modal esc END
</script>



</html>