<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
  box-shadow: 0 1px 0 1px rgba(0,0,0,.04);
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
table.type05 {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    margin: 20px 10px;
}
table.type05 th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #efefef;
}
table.type05 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
}
#boot {
      background-color: #b3c6ff;
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
div > #paging {
      text-align: center;
    }
#boot {
      background-color: #b3c6ff;
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
	<input Type="hidden" value="${id}" id="hiddenid">
		<select id="LIKEMYCC" name="LIKEMYCC">
			<option>---------</option>
			<c:forEach var="cc" items="${CList}" varStatus="i">
				<option value="${cc.cc_cc}">${cc.cc_cc}</option>
			</c:forEach>
		</select>
		<div class="container">
	<table class="table table-striped">
			<tr id="boot">
				<th width="150"align="center">관심사</th>
				<th width="150"align="center">사진</th>
				<th width="150"align="center">강좌명|교수명|강의수|level</th>
				<th width="150"align="center">평점</th>
				<th width="200"align="center">맛보기 문제|강의계획서</th>
				<th width="150"align="center">수강신청</th>
			</tr>
			<tbody id="tableShow">
				<c:forEach var="Clasc" items="${cList}">
					<tr height="25">
						<td align="center">${Clasc.cl_cc}</td>
						<td align="center"><img
							src="<c:url value="/upload/${Clasc.pi_pisysname}"/>" width="50px;" /></td>
						<td align="center"><h2>${Clasc.cl_clname}</h2>${Clasc.cl_id}
							| ${Clasc.co_num} |${Clasc.cl_lv}</td>
							  <c:choose>
                     <c:when test="${Clasc.gpa_gpa eq 0}">
                        <td><h3>등록된 평점이 없습니다.</h3></td>
                     </c:when>
                     <c:when test="${Clasc.gpa_gpa ne 0}">
                        <td width="150"><h2>${Clasc.gpa_gpa}</h2></td>
                     </c:when>
                  </c:choose>
						<td align="center"><a href='goSelectTasterQuestion?cl_idnum=${Clasc.cl_idnum}'>맛보기 문제</a><a
							href='goSelectClassReport?cl_idnum=${Clasc.cl_idnum}'>강의계획서</a></td>
						<td><a href='#' onclick="openBuyPage(${Clasc.cl_idnum} , ${Clasc.cl_lv})\">수강신청
								하러가기</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
		<div id="search">
			<form action="DeeplearningSearch" name="DeeplearningSearch">
				<select name="selvalue">
					<option value="searchcc">관심사</option>
					<option value="searchWriter">교수명</option>
				</select> <input type="text" name="search" placeholder="입력하기" />
				<button class="dtn dtn-default">검색하기</button>
			</form>
		</div>
		<div id="Paging">${Paging}</div>
		<div id='modal'>
			<div id='bg_modal'></div>
			<div id='contents_modal'></div>
		</div>
	</section>
</body>
<script type="text/javascript">
$('#LIKEMYCC')
.change(
		function() {
			var select_sub = $('#LIKEMYCC').val();
			var json = new Object();
			json.cc_cc = select_sub;
			$
					.ajax({
						type : 'post',
						dataType : 'json',
						url : 'rest/selectMylnterestLevel',
						beforeSend : function(xhr) {
							var $token = $("#token");
							xhr.setRequestHeader($token
									.data("token-name"), $token
									.val());
						},
						contentType : 'application/json; charset=UTF-8',
						data : JSON.stringify(json),
						success : function(result) {
							console.log(result);
							$('#Paging').remove();
							str = "";
							if(result ==0){
								alert("등록된 강의가 없습니다!");
							} else{
							for ( var i in result) {
								str += "<tr><th>" + result[i].cl_cc+ "</th>";
								str += "<th><img src='<c:url value='/upload/"+result[i].pi_pisysname+"'/>'width='150px;'></th>";
								str += "<th><h2>" + result[i].cl_clname+ "</h2>|" + result[i].cl_id+ "|" +result[i].co_num+ "|" + result[i].cl_lv+ "</th>";
								if(result[i].gpa_gpa == 0){
							    	str += "<th><h2>등록된 평점이 없습니다.<h2></th>"
							    }else{
							    str += "<th><h2>"+result[i].gpa_gpa+"</h2></th>"
							    }		
								str += "<th><a href='goSelectTasterQuestion?cl_idnum="+result[i].cl_idnum+"'>맛보기문제|<a href='goSelectClassReport?cl_idnum="
										+ result[i].cl_idnum
										+ "'>강의계획서</th>";
										
							    str+="<td><a href='#' onclick=\"openBuyPage('"+result[i].cl_idnum+"', '"+result[i].cl_lv+"')\">수강신청 하러가기</a></td></tr>";
									
								$("#tableShow").html(str);
							}
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
		var str="";
		m_contents.html("");
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
					str +="<table class='type05' id='buyTable'>";
					str +="<tr><th>강의명</th><td>"+json.cb.cl_clName+"</td></tr>";
					str +="<tr><th>학습레벨</th><td>"+json.cb.cl_lv+"</td></tr>";
					str +="<tr><th>강수</th><td>"+json.cb.cl_lcnum+"</td></tr>";
					str +="<tr><th>수강기간</th><td>"+json.cb.cl_stDay.substring(0,10)+" ~ "+json.cb.cl_fnDay.substring(0,10)+"</td></tr>";
					var date = new Date();
					str +="<tr><th>Today</th><td>"+date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+"</td></tr>";
					str +="<tr><th>강의가격</th><td><input type='text' value='"+json.cb.cl_pt+"' readonly> point</td></tr>";
					str +="<tr><th>나의 보유 포인트</th><td><input type='text' value='"+json.mb.mb_point+"' readonly> point</td></tr>";
					var deductPoint = json.mb.mb_point - json.cb.cl_pt;
					var booleanPoint = deductPoint>=0;
					str +="<tr><th>차감 후 나의 포인트</th><td><input type='text' value='"+deductPoint+"' readonly> point</td></tr>";
					str +="</table>";
					str +="<input type='checkbox'id='mustChk'/><b> 위 상품 정보 및 거래 조건을 확인하였으며, 구매 진행에 동의합니다.(필수)</b>";
					str +="<p id='err'></p>";
					str +="<input type='button' value='구매하기' onclick=\"insertBuyClass('"+json.cb.cl_idnum+"','"+json.cb.cl_lv+"','"+json.cb.cl_pt+"','"+booleanPoint+"')\">";
					m_contents.append(str);
				}else{
					alert("구매하기창 불러오기에 실패했습니다.");
				}
			},error: function(err){
				console.log(err);
			}
		});//ajaxEND
	};//openBuyPage END
	$("#modal").find('#bg_modal').on('mousedown',function(evt){
		console.log(evt);
		if(confirm("구매중입니다. 나가시겠습니까?")){
			$("#modal").removeClass('open'); 			
		}
	});// modal mousesdown end
	$(document).keydown(function(evt){
		if(evt.keyCode !=27){
			return;
		}else if (modal.hasClass('open')){
			if(confirm("구매중입니다. 나가시겠습니까?")){
				modal.removeClass('open');			
			}
		}
	}); //modal esc END
	
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
</script>



</html>