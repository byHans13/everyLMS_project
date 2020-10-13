<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
	
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ClassHome</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="../resources/js/jquery.serializeObject.js"></script>
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

.html, body {
	width: 1400px;
	height: 1000px;
}

.classMain {
	display: flex;
	margin: 5px;
	border: 1px solid black;
	width :1075px;
}

#classInfo {
	list-style: none;
	margin-top: 40px;
	margin-left: 20px;
}

#className {
	list-style: none;
	margin-top: 20px;
	margin-left: 20px;
}

#classLike {
	list-style: none;
	margin-top: 20px;
	margin-left: 20px;
}

.classNav {
	margin: 5px;
	border: 1px solid black;
	width: 1075px;
	height: 65px;
	text-align: center;
	background: #eee;
}

.li {
	list-style: none;
	display: inline-block;
	margin-left: 20px;
	margin-top: 20px;
	margin-right: 20px;
}

.classAll {
	margin: 5px;
	border: 1px solid black;
	width: 1077px;
	height: 650px;
	text-align: center;
}

.classLeft {
	border: 1px solid black;
	width: 300px;
	height: 650px;
	float: left;
}

.classRight {
	border: 1px solid black;
	width: 775px;
	height: 650px;
	float: left;
	text-align: center;
	overflow: scroll;
}
table.type02 {
    border-collapse: separate;
    border-spacing: 0;
    text-align: left;
    line-height: 1.5;
    border-top: 1px solid #ccc;
    border-left: 1px solid #ccc;
  	margin : 20px 10px;
}
table.type02 th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    border-top: 1px solid #fff;
    border-left: 1px solid #fff;
    background: #eee;
}
table.type02 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
}
table.type11 {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: center;
    line-height: 1.5;
    margin:auto;
    margin-top:30px;
}
table.type11 th {
    width: 240px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
    background:black;
}
table.type11 td {
    width: 155px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #eee;
}
.btn_like {
  position: relative;
  display: block;
  width: 44px;
  height: 44px;
  border: 1px solid #e8e8e8;
  border-radius: 44px;
  font-family: notokr-bold,sans-serif;
  font-size: 14px;
  line-height: 16px;
  background-color: #fff;
  transition: border .2s ease-out,box-shadow .1s ease-out,background-color .4s ease-out;
}
.btn_unlike .img_emoti {
    background-position: -30px -120px;
}

.img_emoti {
    display: inline-block;
    overflow: hidden;
    font-size: 0;
    line-height: 0;
    background: url(https://mk.kakaocdn.net/dn/emoticon/static/images/webstore/img_emoti.png?v=20180410) no-repeat;
    text-indent: -9999px;
    vertical-align: top;
    width: 20px;
    height: 17px;
    margin-top: 1px;
    background-position: 0px -120px;
    text-indent: 0;
}
.ani_heart_m.hi {
    -webkit-background-size: 9000px 125px;
    background-size: 9000px 125px;
}

.ani_heart_m.bye {
    background-size: 8250px 125px;
}
</style>
</head>
<body>
	<header>
		<%-- <%@ include file="h2k5every_header.jsp"%><!-- 정적인 방식 --> --%>
		<jsp:include page="../../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
	</header>
	<aside>
		<jsp:include page="../../h2k5every_aside.jsp" />
	</aside>
	<section id="section" style="margin-left: 20px;">
		<div id='classMain' name='classMain' class='classMain'>
			<input type='hidden' id='token' data-token-name='${_csrf.headerName}'
				name='${_csrf.parameterName}' value='${_csrf.token}'>
			<div id='classImg'></div>
			<ul class='ul'>
				<li id='classInfo'></li>
				<li id='className'></li>
				<li id='classLikeBtn'>
					<button type='button' onclick='classLike()' class='btn_like'>
						<span class="img_emoti">좋아요</span>
						<span class="ani_heart_m"></span>
					</button>
				</li>
			</ul>
			<input type='hidden' value='' name='cl_idnum' id='classPk'
				class='classPk'> 
			<input type='hidden' value=''
				name='cob_kind' id='boardKind' class='boardKind'>
		</div>
		<div id='classNav' name='classNav' class='classNav'>
			<ul>
				<li id='classInfoAjax' class='li' onclick='classInfoAjax()'>
					강의소개</li>
				<li id='classVideoTableAjax' class='li' onclick='classLectureAjax()'>
					강의목록</li>
				<li id='classNotice' class='li' onclick='classNotice()'>공지사항</li>
				<li id='classQNA' class='li' onclick='classQNA()'>Q&A</li>
				<li id='classPostscript' class='li' onclick='classReview()'>
					수강후기</li>
				<li id='classReference' class='li' onclick='classHomeworkSubmit()'>과제제출 </li>
			</ul>
		</div>
		<div id='classAll' name='classAll' class='classAll'>
			<div id='classLeft' name='classLeft' class="classLeft">
				<h4><b>강의정보</b></h4>
				<table class='type02' id='classInfoTable' >
				</table>
			</div>
			<div class='classRight' name='classRight' id='classRight'></div>
		</div>
	</section>
	<footer>
		<jsp:include page="../../h2k5every_footer.jsp" />
	</footer>
</body>
<script>
jQuery.fn.serializeObject = function() {
	  var obj = null;
	  try {
	    if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) {
	      var arr = this.serializeArray();
	      if(arr){
	        obj = {};    
	        jQuery.each(arr, function() {
	        obj[this.name] = this.value;
	        });             
	      }
	    }
	  }catch(e) {
	    alert(e.message);
	  }finally  {}
	  console.log("serialObject hans= ",obj);
	  return obj;
	}



	var sessionID = "${sessionScope.id}";
	var el = ${classInfo}; //포워딩으로 보내준 Gson값 받음
	var infoReview = ${infoReview};
	var avg = ${avgNum};
	var likeNum= ${likeNum};
	console.log("likelikelikeNum="+likeNum);
	classInfoAjax(); //강의실 들어오자마자 강좌소개에 필요한 값 ajax 밑 div 찍어주기 위한 함수 실행
	
	function test() {
		alert('성공');
	};
	function classInfoAjax() { //강의소개 ajax
		var cInfo = $('#classInfoTable');
		cInfo.html(""); // ajax 움직일 때 마다 초기화 why? append라서 
		// Gson으로 강의에 대한 강의 Info값 이미지, 관심사, 레벨, 강사이름 등 찍어주기 
		for ( var i in el) {
			//강의 head, aside 강의 정보 찍어주기 
			$('#classPk').val(el[i].cl_idnum);
			$('#classImg').html("<img src='../picture/"+el[i].pi_pisysname+"' width='150px' height='200px'>");
			$('#classInfo').html("<h5>" + el[i].cl_cc + " | LV " + el[i].cl_lv + " | "+ el[i].mb_name + " 강사</h5>");
			$('#className').html("<h2>" + el[i].cl_clName + "</h2>");
			cInfo.append("<tr><th>과목명</th><td>" + el[i].cl_clName	+ "</td></tr>");
			cInfo.append("<tr><th>학습레벨</th><td>LV " + el[i].cl_lv	+ "</td></tr>");
			cInfo.append("<tr><th>강수</th><td>" + el[i].cl_lcnum+ "강</td></tr>");
			cInfo.append("<tr><th>강의평점</th><td>" + avg + "점</td></tr>");
		}
		//ajax하기 전 초기화 
		$("#classRight").html("");
		//classRight에 값 찍어주기, 수강후기는 ajax 타고 와야함 
		var str = $("#classRight");
		str.append("<div style='width:745px; height:80px;'><h3>해당강의 맛보기 문제 풀어보기</h3><hr style='width:350px;'>");
		str.append("<div>해당강의의 맛보기 문제를 풀어볼 수 있습니다.</div><div>해당강의와 level이 맞지 않으면 맛보기 문제를 풀어주세요.</div>");
		str.append("<br><input type='button' onclick='previewQuiz()' value='맛보기문제 풀러가기'>");
		str.append("<br><br><hr style='width:350px;'></div>");
		// 수강후기 ajax 타고와서 table 찍어줌
		var classReviews = "";
		classReviews += "<div style='width:745px; height:300px;'><br><br><div>수강후기 ";
		classReviews += "<input type='button' value='+더보기' onclick='classReview()'><hr style='width:100px;'></div><br/>";
		for ( var i in infoReview) {
			if (infoReview[i].cob_id.length > 2) {
				var name = infoReview[i].cob_id.split('');
				for ( var j in name) {
					if (j == 0 || j == name.length - 1) {
						name[j] = name[j];
					} else {
						name[j] = '*';
					}
				}
				var rename = name.join('');
			} else {
				var name = infoReview[i].cob_id.split('');
				for ( var j in name) {
					if (j == 0 && name.length - 1 != 0) {
						name[j] = name[j];
					} else {
						name[j] = '*';
					}
				}
				var rename = name.join('');
			}
			classReviews += "<div style='width:745px;' onclick=\"classReviewDetail('"+ infoReview[i].cob_bonum+ "','"	+ infoReview[i].gpa_gpa	+ "','" + infoReview[i].cob_kind + "')\">";
			classReviews += "<div>" + infoReview[i].gpa_gpa + "점 || " + rename+ " || " + infoReview[i].cob_date + "</div>";
			classReviews += "<h4>" + infoReview[i].cob_title + "</h4>";
			classReviews += "<div>" + infoReview[i].cob_cont+ "</div></div><br/>";
		}
		str.append(classReviews);
		if(likeNum !=0){
		    $('button').addClass('btn_unlike');
		    $('.ani_heart_m').addClass('hi');
		}else{
		    $('.ani_heart_m').addClass('bye');
		}
	}//classInfoAjax() END
	function classLike() {
		var obj = {
			"likes_idnum" : el[0].cl_idnum,
			"likes_lv" : el[0].cl_lv,
			"likes_id" : sessionID
		};
		$.ajax({
			type : 'post',
			url : 'rest/insertClassLike',
			data : obj,
			dataType : 'json',
			beforeSend : function(xhr) {
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
			success : function(json) {
				console.log(json);
				if (json) {
					likeNum =1;
					alert("관심강의에 등록되었습니다. 수강신청관리 페이지에서 확인하실 수 있습니다.");
				} else {
					likeNum =0;
					alert("좋아요가 취소되었습니다.");
				}
			},
			error : function(json) {
				alert("error: 새로고침이나 브라우저를 다시 실행해주세요.");
			}
		});//ajaxEND
	}//function classLike()END

	function previewQuiz() {
		var classPk = $('#classPk').val(); //cl_clname
		window.open("selectPreviewQuiz?cl_idnum=" + classPk + "&cl_lv="+ el[0].cl_lv, '_blank',	'width=800, height=600, top=200, left=400');

	}// previewQuiz() END

	function classLectureAjax() { // 강의목록 ajax
		$("#classRight").html(""); //classRight 초기화 후 강의목록 테이블 찍어주기 위한 초기화 과정	
		var obj = {
			"cl_idnum" : el[0].cl_idnum,
			"cl_lv" : el[0].cl_lv
		};
		console.log(obj);
		$.ajax({ //강의 pk값으로 해당 강의 강좌list 가져오기 위한 ajax
					type : 'post',
					url : 'rest/classLectureAjax',
					data : obj,
					dataType : 'json',
					beforeSend : function(xhr) {
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token.val());
					},
					success : function(json) {
						var lectureList = $('#classRight'); //여기에 table 출력
						if (json[0].aa_id == null) {
							alert("로그인 후 이용해주세요.");
							classInfoAjax();
						} else {
							var str="";
							lectureList.append("<div id='lectureDiv' style='width:1036px; height:652px;'><table id='lectureTable' class='type11'></table></div>");
							str +="<thead><tr><th>회차</th><th>강좌명</th><th>수강여부</th></tr></thead><tbody>";
							for ( var i in json) {
								console.log("atmk=" + json[i].atd_atmk);
								if (json[i].atd_atmk != null) {
									str +="<tr><td>"+json[i].co_num+"강</td>";
									str +="<td><a href='selectClassLectureVideoPage?co_idnum="+json[i].co_idnum+"&co_lv="+json[i].co_lv+"&co_num="
										+json[i].co_num+"&atd_atmk="+json[i].atd_atmk+"'target='_blank'>"+json[i].co_name+"</a></td><td>수강완료</td></tr>";
								} else {
									str +="<tr><td>"+ json[i].co_num+ "강</td>";
									str +="<td><a href='selectClassLectureVideoPage?co_idnum="+json[i].co_idnum+ "&co_lv="
										+json[i].co_lv+"&co_num="+json[i].co_num+"'target='_blank'>"+ json[i].co_name+"</a></td><td>미수강</td></tr>";
								}
							}//for 
							$('#lectureTable').append(str);
						}// 로그인 if else에서 else문 end
					},
					error : function(err) {
						console.log(err);
					}
				}); //classLecture 의 ajax END
	}; //function classLectureAjax 의 END

	function classNotice() {
		$('#boardKind').val(1);
		var obj = {
			'cob_idnum' : $('#classPk').val(),
			"cob_lv" : el[0].cl_lv,
			'cob_kind' : $('#boardKind').val()
		}
		$.ajax({
					type : 'post',
					url : 'rest/selectClassNoticeAjax',
					data : obj,
					dataType : 'json',
					beforeSend : function(xhr) {
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token.val());
					},

					success : function(json) {
						//console.log(json);
						var notice = $('#classRight');
						notice.html("");
						notice.append("<div id='noticeDiv' style='width:1036px; height:652px;'><table id='noticeTable' style='margin:auto; border-collapse:collapse;'></table></div>");
						var noticeTable = $('#noticeTable');
						noticeTable	.append("<tr><td>번호</td><td>구분</td><td>제목</td><td>등록일</td></tr>");
						if (json != "") {
							for ( var i in json) {
								//console.log("1=",json[i]);
								var boardInfo = JSON.stringify(json[i]);
								//console.log(boardInfo);
								noticeTable.append("<tr id='tr_"+i+"'></tr>");
								var noticeTr = $('#tr_' + i);
								noticeTr.append("<td>"+ json[i].cob_bonum.substring(3)+ "</td>");
								noticeTr.append("<td>" + json[i].bk_boardName+ "</td>");
								noticeTr.append("<td><a href='#;' onclick='classNoticeDetail("+ boardInfo+ ")'>"+ json[i].cob_title+ "</a></td>");
								noticeTr.append("<td>" + json[i].cob_date+ "</td>");
							}
						} else {
							noticeTable.append("<tr><td colspan='4'>등록된 게시글이 없습니다.</td></tr>");
						}
					},
					error : function(err) {
						console.log(err);
					}
				});//classNotice Ajax END
	}//function classNotice() END

	function classNoticeDetail(info) {
		classInfo = ${classInfo};
		console.log(info);
		//var boardInfo = JSON.parse(info);
		var noticeDetail = $('#classRight');
		noticeDetail.html("");
		noticeDetail.append("<div id='noticeDetailDiv' style='width:800px; height:300px; margin:auto; text-align:left;'></div>");
		//$('#noticeDetailDiv').append("<table style='margin:auto; border-collapse:collapse; border:1px;'><tr><td>"+info.bk_boardName+"</td><td>"+info.cob_title+"</td><td>"+info.cob_date+"</td></tr></table>")
		$('#noticeDetailDiv').append("<h4>" + info.bk_boardName + "</h4><hr>");
		$('#noticeDetailDiv').append("<table id='noticeDetailTable' style='margin:auto; border-collapse:collapse; float:left;'><tr><td>제목:</td><td>"+ info.cob_title + "</td></tr></table>");
		$('#noticeDetailTable').append("<tr><td>강사명</td><td>" + classInfo[0].mb_name + "</td></tr>");
		$('#noticeDetailTable').append("<tr><td>작성일</td><td>" + info.cob_date + "</td></tr>");
		$('#noticeDetailDiv').append("<div style='float:left; margin:auto; width:800px; height:300px;'><hr><br/>"+ info.cob_cont + "</div>");
		$('#noticeDetailDiv').append("<input type='button' value='돌아가기' onclick='classNotice()'>");
	}

	function classQNA() {
		$('#boardKind').val(2);
		var obj = {
			'cob_idnum' : $('#classPk').val(),
			'cob_lv' : el[0].cl_lv,
			'cob_kind' : $('#boardKind').val()
		}
		$('#classRight').html("");
		$('#classRight').append("<div id='QNADiv' style='width:1036px; height:652px;'></div>");
		$('#QNADiv').append("<table id='QNATable' style='margin:auto; border-collapse:collapse;'></table>");
		$('#QNATable').append("<tr><td>번호</td><td>구분</td><td>강좌</td><td>제목</td><td>등록일</td></tr>");
		$('#QNADiv').append("<input type='button' value='Q&A 작성' onclick='classInsertViewQNA()'>");
		$.ajax({	type : 'post',
					url : 'rest/selectClassQNA',
					data : obj,
					dataType : 'json',
					beforeSend : function(xhr) {
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token.val());
					},

					success : function(json) {
						if (json != "") {
							for ( var i in json) {
								$('#QNATable')
										.append("<tr id='tr_"+i+"'></tr>");
								var QNATr = $('#tr_' + i);
								QNATr.append("<td>"+ json[i].cob_bonum.substring(2)+ "</td>");
								QNATr.append("<td>" + json[i].bk_boardName+ "</td>");
								QNATr.append("<td>" + json[i].cob_num+ "강</td>");
								QNATr.append("<td><a href='#;' onclick=\"classQnaDetail('"+ json[i].cob_bonum+ "')\">"+ json[i].cob_title+ "</a></td>");
								QNATr.append("<td>" + json[i].cob_date+ "</td>");
							}
						} else {
							$('#QNATable').append("<tr><td colspan='5'>등록된 게시글이 없습니다.</td></tr>");
						}
					},
					error : function(err) {
						console.log(err);
					}
				});
	}//function classQNA()END

	function classInsertViewQNA() {
		var obj = {
			"cl_idnum" : el[0].cl_idnum,
			"cl_lv" : el[0].cl_lv
		};
		console.log(obj);
		$.ajax({
					type : 'post',
					url : 'rest/classLectureAjax',
					data : obj,
					dataType : 'json',
					beforeSend : function(xhr) {
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token.val());
					},

					success : function(json) {
						var cr = $('#classRight');
						cr.html("");
						cr.append("<div id='insertQNADiv' style='width:500px; height:652px; margin:auto;'></div>");
						var iDiv = $('#insertQNADiv');
						var str = "";
						str += "<form name='insertFrmQNA' id='insertFrmQNA'>";
						str += "<input type='hidden' name='cob_idnum' value='"+json[0].co_idnum+"'>";
						str += "<input type='hidden' name='cob_lv' value='"+json[0].co_lv+"'><br/>"
						str += "<input type='hidden' name= cob_kind value='"+ $('#boardKind').val() + "'>";
						str += "<select id='cob_num' name='cob_num'><option value=''>강좌를 선택해주세요.</option>";
						for ( var i in json) {
							str += "<option value='"+json[i].co_num+"'>"+ json[i].co_name + "</option>";
						}
						str += "</select><br/><hr>";
						str += "<input type='text' placeholder='제목을 입력해주세요.' name='cob_title'><br/><br/>";
						str += "<textarea id='cob_cont' name='cob_cont' cols='40' rows='20'></textarea><br/>";
						str += "<input type='button' value='작성하기' onclick='insertQNA()'></form>";
						iDiv.append(str);
					},
					error : function(err) {
						console.log(err);
					}
				})//course select Ajax END
	}//function classInsertQNA() END

	function insertQNA() {
		var $confirm = confirm("Q&A를 작성하시겠습니까?");
		if ($confirm == true) {
			var obj = $('#insertFrmQNA').serializeObject();
			console.log(obj);

			$.ajax({
				type : 'post',
				url : 'rest/insertMyClassQnaAjax',
				data : obj,
				dataType : 'json',
				beforeSend : function(xhr) {
					var $token = $("#token");
					xhr.setRequestHeader($token.data("token-name"), $token.val());
				},
				success : function(json) {
					console.log(json);
					if (json != "") {
						var i = json.length - 1;
						alert("Q&A 작성이 완료되었습니다.");
						classQnaDetail(json[i].cob_bonum);
					} else {
						alert("Q&A 작성에 실패했습니다.");
						classInsertViewQNA()
					}
				},
				error : function(err) {
					console.log(err);
				}
			}); // insertQNA ajax END
		} else {//confirm if
			return;
		}
	}//function insertQNA() END

	function classQnaDetail(bonum) {
		var obj = {
			'cob_idnum' : $('#classPk').val(),
			'cob_lv' : el[0].cl_lv,
			'cob_bonum' : bonum,
			'cob_kind' : $('#boardKind').val()
		}
		$.ajax({
					type : 'post',
					url : 'rest/selectClassQnaDetail',
					data : obj,
					dataType : 'json',
					beforeSend : function(xhr) {
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token.val());
					},success : function(json) {
						var QnaDetail = $('#classRight');
						QnaDetail.html("");
						QnaDetail.append("<div id='QnaDetailDiv' style='width:800px; height:300px; margin:auto; text-align:left;'></div>");
						$('#QnaDetailDiv').append("<h4>" + json[0].bk_boardName + "</h4><hr>");
						$('#QnaDetailDiv').append("<table id='QnaDetailTable' style='margin:auto; border-collapse:collapse; float:left;'><tr><td>제목:</td><td>"+ json[0].cob_title+ "</td></tr></table>");
						$('#QnaDetailTable').append("<tr><td>작성자</td><td>"+json[0].cob_id+ "</td></tr>");
						$('#QnaDetailTable').append("<tr><td>작성일</td><td>" + json[0].cob_date+ "</td></tr>");
						console.log(json[0].cob_cont);
						$('#QnaDetailDiv').append("<div style='float:left; margin:auto; width:800px; height:300px;'><hr><br/>"
										+ json[0].cob_cont + "</div>");
						$('#QnaDetailDiv').append("<div style='float:left; marign:auto width:800px; height:300px;' id='replyDiv'></div>");
						$('#replyDiv').append("<hr><h4>댓글</h4><hr>");
						console.log(json[0].reply);
						var str = "";
						if (json[0].cr_reply != undefined) {
							for ( var i in json) {
								str += "<div><div style='margin:10px;'><b>"
										+ json[i].cr_id + "</b></div>";
								str += "<div style='margin:10px;'>"
										+ json[i].cr_reply + "</div>";
								str += "<div style='margin:10px;'>"
										+ json[i].cr_date + "</div>";
								str += "<hr></div>";
							}
						}
						str += "<form id='replyFrm' name='replyFrm'>";
						str += "<div style='float:left'>" + sessionID+ "</div><br/>";
						str += "<textarea rows='3px' cols='80px' name='cr_reply'></textarea><br/>";
						str += "<input type='hidden' value='"+json[0].cob_bonum+"' name='cob_bonum'>";
						str += "<input type='button' value='댓글 작성' onclick='insertQnaReply()'><br/><br/><br/></form>";
						$('#QnaDetailDiv').append("<input type='button' value='돌아가기' onclick='classQNA()'>");
						$('#replyDiv').append(str);
					},
					error : function(err) {
						console.log(err);
					}
				})//ajax END
	}//function classQnaDetail() END

	function insertQnaReply() {
		var obj = $('#replyFrm').serializeObject();
		console.log(obj);
		$.ajax({
			type : 'post',
			url : 'rest/insertQnaReply',
			data : obj,
			dataType : 'json',
			beforeSend : function(xhr) {
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},

			success : function(json) {
				classQnaDetail(json);
				//classQnaDetail()
			},
			error : function(err) {
				console.log(err);
			}
		});// ajax insertQnaReply END
	}// function insertQnaReply() END

	function classReview() {
		$('#boardKind').val(3);
		var obj = {
			'cob_idnum' : $('#classPk').val(),
			'cob_lv' : el[0].cl_lv,
			'cob_kind' : $('#boardKind').val()
		}
		$('#classRight').html("");
		$('#classRight').append("<div id='reviewDiv' style='width:1036px; height:652px;'></div>");
		$('#reviewDiv').append("<table id='reviewTable' style='margin:auto; border-collapse:collapse;'></table>");
		$('#reviewTable').append("<tr><td>번호</td><td>구분</td><td>제목</td><td>평점</td><td>작성자</td><td>등록일</td></tr>");
		$('#reviewDiv').append("<input type='button' value='리뷰 작성' onclick='classReviewInsertPage()'>");
		$.ajax({
					type : 'post',
					url : 'rest/selectClassReview',
					data : obj,
					dataType : 'json',
					beforeSend : function(xhr) {
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token.val());
					},
					success : function(json) {
						var str = "";
						if (json != "") {
							for ( var i in json) {
								str += "<tr><td>"+ json[i].cob_bonum.substring(2)+ "</td>";
								str += "<td>" + json[i].bk_boardName + "</td>";
								str += "<td><a href='#;' onclick=\"classReviewDetail('"+ json[i].cob_bonum+ "','"+ json[i].gpa_gpa+"')\">"+ json[i].cob_title + "</a></td>";
								str += "<td>" + json[i].gpa_gpa + "점</td>";
								if (json[i].cob_id.length > 2) {
									var name = json[i].cob_id.split('');
									for ( var j in name) {
										if (j == 0 || j == name.length - 1) {
											name[j] = name[j];
										} else {
											name[j] = '*';
										}
									}
									var rename = name.join('');
								} else {
									var name = json[i].cob_id.split('');
									for ( var j in name) {
										if (j == 0 && name.length - 1 != 0) {
											name[j] = name[j];
										} else {
											name[j] = '*';
										}
									}
									var rename = name.join('');
								}
								str += "<td>" + rename + "</td>";
								str += "<td>" + json[i].cob_date + "</td></tr>";
							}
							$('#reviewTable').append(str);
						} else {
							str += "<tr><td colspan='6' style='margin:auto'>등록된 수강후기가 없습니다.</td></tr>";
							$('#reviewTable').append(str);
						}
					},
					error : function(err) {
						console.log(err);
					}
				});//ajax classReview END
	}//function classReview() END

	function classReviewInsertPage() {
		var cl = ${classInfo};
		var obj = {
			'cob_idnum' : el[0].cl_idnum,
			'cob_lv' : el[0].cl_lv
		}
		$.ajax({
					type : 'post',
					url : 'rest/selectMyClassAvg',
					data : obj,
					dataType : 'json',
					beforeSend : function(xhr) {
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token.val());
					},
					success : function(json) {
						if (json >= 1) {
							var str = "";
							var reviewDetail = $('#classRight');
							reviewDetail.html("");
							reviewDetail.append("<div id='reviewDiv' style='width:500px; height:652px; margin:auto; text-align:left;'></div>");
							str += "<h4>강의후기 작성</h4><hr>"
							str += "<form name='insertFrmReview' id='insertFrmReview'>";
							str += "<input type='hidden' name='cob_idnum' value='"+cl[0].cl_idnum+"'>";
							str += "<input type='hidden' name='cob_lv' value='"+cl[0].cl_lv+"'>";
							str += "<input type='hidden' name= cob_kind value='"
									+ $('#boardKind').val() + "'>";
							str += "<input type='hidden' name='gpa_gpa' value='"+json+"'>";
							str += "<div style='margin:10px;'>강의명: "
									+ cl[0].cl_clName + " </div>";
							str += "<div style='margin:10px;'>교수명: "
									+ cl[0].mb_name + "</div>";
							str += "<div style='margin:10px;'>내 강의평점: " + json
									+ "</div><hr>";
							str += "<input type='text' placeholder='제목을 입력해주세요.' name='cob_title'><br/><br/>";
							str += "<textarea id='cob_cont' name='cob_cont' cols='40' rows='20'></textarea><br/>";
							str += "<input type='button' value='작성하기' onclick=\"insertReview('"+ json + "')\"></form>";	
							$('#reviewDiv').append(str);
						} else if (-1 >= json) {
							alert("강의평가를 진행할 수 없습니다. (미수강)");
						} else {
							alert("수강신청 후 강의를 모두 들으셔야 작성하실 수 있습니다.");
						}
					},
					error : function(err) {
						console.log(err);
					}
				});// ajax classReviewInsertPage END
	}//function classReviewInsertPage() END

	function insertReview(myGpa) {
		var myAvg = myGpa;
		console.log(myAvg);
		var obj = $('#insertFrmReview').serializeObject();
		console.log(obj);
		$.ajax({
			type : 'post',
			url : 'rest/insertClassReview',
			data : obj,
			dataType : 'json',
			beforeSend : function(xhr) {
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},
			success : function(json) {
				classReviewDetail(json, myAvg);
			},
			error : function(err) {
				console.log(err);
			}
		}); // ajax insertReview END
	}//function insertReview() END

	function classReviewDetail(bonum, gpa, kind) {
		if (kind != null) {
			var obj = {
				'cob_idnum' : $('#classPk').val(),
				'cob_lv' : el[0].cl_lv,
				'cob_bonum' : bonum,
				'cob_kind' : kind
			}
		} else {
			var obj = {
				'cob_idnum' : $('#classPk').val(),
				'cob_lv' : el[0].cl_lv,
				'cob_bonum' : bonum,
				'cob_kind' : $('#boardKind').val()
			}
		}
		var myAvg = gpa;
		var cl = ${classInfo};
		console.log(gpa);
		console.log(kind);
		console.log(myAvg);
		$.ajax({
					type : 'post',
					url : 'rest/selectClassReviewDetail',
					data : obj,
					dataType : 'json',
					beforeSend : function(xhr) {
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token.val());
					},
					success : function(json) {
						console.log(sessionID);
						var reviewDetail = $('#classRight');
						reviewDetail.html("");
						reviewDetail.append("<div id='reviewDetailDiv' style='width:800px; height:300px; margin:auto; text-align:left;'></div>");
						$('#reviewDetailDiv').append("<h4>" + json[0].bk_boardName + "</h4><hr>");
						$('#reviewDetailDiv').append("<table id='reviewDetailTable' style='margin:auto; border-collapse:collapse; float:left;'><tr><td>제목:</td><td>"+ json[0].cob_title	+ "</td></tr></table>");
						$('#reviewDetailTable').append("<tr><td>평점</td><td>" + myAvg + "</td></tr>");
						if (json[0].cob_id.length > 2) {
							var name = json[0].cob_id.split('');
							for ( var j in name) {
								if (j == 0 || j == name.length - 1) {
									name[j] = name[j];
								} else {
									name[j] = '*';
								}
							}
							var rename = name.join('');
						} else {
							var name = json[0].cob_id.split('');
							for ( var j in name) {
								if (j == 0 && name.length - 1 != 0) {
									name[j] = name[j];
								} else {
									name[j] = '*';
								}
							}
							var rename = name.join('');
						}
						$('#reviewDetailTable').append("<tr><td>작성자</td><td>" + rename + "</td></tr>");
						$('#reviewDetailTable').append("<tr><td>작성일</td><td>" + json[0].cob_date+ "</td></tr>");
						$('#reviewDetailDiv').append("<div style='float:left; margin:auto; width:800px; height:300px;'><hr><br/>"+ json[0].cob_cont + "</div>");
						$('#reviewDetailDiv').append("<div style='float:left; marign:auto width:800px; height:300px;' id='replyDiv'></div>");
						$('#replyDiv').append("<hr><h4>댓글</h4><hr>");
						var str = "";
						if (json[0].cr_reply != undefined) {
							var rename;
							for ( var i in json) {
								if (json[i].cob_id == json[i].cr_id) {
									rename = "작성자";
								} else if (json[i].cob_id == cl[0].cl_id) {
									rename = cl[0].mb_name;
								} else {
									rename = json[i].cr_id
								}
								str += "<div><div style='margin:10px;'><b>"
										+ rename + "</b></div>";
								str += "<div style='margin:10px;'>"
										+ json[i].cr_reply + "</div>";
								str += "<div style='margin:10px;'>"
										+ json[i].cr_date + "</div>";
								str += "<hr></div>";
							}
						}
						str += "<form id='replyFrm' name='replyFrm'>";
						str += "<div style='float:left'>" + sessionID+ "</div><br/>";
						str += "<textarea rows='3px' cols='80px' name='cr_reply'></textarea><br/>";
						str += "<input type='hidden' value='"+json[0].cob_bonum+"' name='cob_bonum'>";
						str += "<input type='button' value='댓글 작성' onclick=\"insertReviewReply('"+ myAvg + "')\"><br/><br/><br/></form>";
						$('#reviewDetailDiv').append("<input type='button' value='돌아가기' onclick=\"classReview('"+ myAvg + "')\">");
						$('#replyDiv').append(str);
					},
					error : function(err) {
						console.log(err);
					}
				})//ajax END    	
	}//function classReviewDetail() END

	function insertReviewReply(gpa) {
		var boardGpaAvg = gpa;
		var obj = $('#replyFrm').serializeObject();
		console.log(obj);
		$.ajax({
			type : 'post',
			url : 'rest/insertReviewReply',
			data : obj,
			dataType : 'json',
			beforeSend : function(xhr) {
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},

			success : function(json) {
				classReviewDetail(json, boardGpaAvg);
			},
			error : function(err) {
				console.log(err);
			}
		});// ajax insertReviewReply END
	}//function insertReviewReply()END
	
	function classHomeworkSubmit(){
		var obj = {
			'hw_idnum' : $('#classPk').val(),
			'hw_lv' : el[0].cl_lv
		}
		var str ="";
		console.log(obj);
		$('#classRight').html("");
		$('#classRight').append("<div id='hwDiv' style='width:1036px; height:652px;'></div>");
		$('#hwDiv').append("<table id='hwTable' style='margin:auto; border-collapse:collapse;'></table>");
		$('#hwTable').append("<tr><td>회차</td><td>과제명</td><td>과제확인</td><td>제출마감일</td><td>제출하기</td><td>비고</td></tr>");
		//<a id='a"+i+"' href='homeworkFiledown?sysFileName="+courseList[i].fbList[1].fl_sysname+"'></a>
		$.ajax({
			type:'get',
			url:'rest/selectClassHomeworkList',
			data:obj,
			dataType:'json',
			success: function(json){
				console.log(json);
				console.log(Object.keys(json["hw"]).length);
				console.log(json["hw"][0].hw_idnum);
				console.log(Object.keys(json["myHw"]).length);
				if(Object.keys(json["hw"]).length !=0){
					for(var i=0; i<Object.keys(json["hw"]).length; i++){
						str ="";
						str +="<tr>";
						str +="<td>"+json["hw"][i].hw_num+"강</td>";
						str +="<td>"+json["hw"][i].hw_hwname+"</td>";
						str += "<td><a href='homeworkFiledown?sysFileName="+json["hw"][i].fbList[1].fl_sysname+"'>"
								+json["hw"][i].fbList[1].fl_oriname+"</a></td>";
						str +="<td>"+json["hw"][i].hw_date.substring(0,10)+"</td>";
						var hwList = JSON.stringify(json["hw"][i]);
						var submitDate = new Date(json["hw"][i].hw_date);
						var today = new Date();
						var CheckSubmit =0;
						for(var j =0; j<Object.keys(json["myHw"]).length; j++){
							if(json["hw"][i].hw_num == json["myHw"][j].hw_num)
								CheckSubmit +=1;
						}
						if(CheckSubmit !=0){
							str +="<td onclick=\"alert('이미 파일을 제출했습니다.')\">submit</td>";
							str +="<td>제출완료</td>";
						}else{
							if(today <= submitDate){
								str +="<td onclick='insertClassHomeworkPage("+hwList+")'><a href='#;'>submit</a></td>";
								str +="<td>제출가능</td>";							
							}else{
								str +="<td onclick=\"alert('제출기한이 지났습니다.')\">submit</td>";
								str +="<td>제출불가</td>";							
							}							
						}
						str +="</tr>";
						$('#hwTable').append(str);
					}//for i
				}else{
					$('#hwTable').append("<tr><td colspan='5'>업로드된 과제가 없습니다.</td></tr>");
				}
			},error: function(err){
				console.log(err);
				$('#hwTable').append("<tr><td colspan='5'>업로드된 과제가 없습니다.</td></tr>");
			}
		});
	}//function classHomeworkSubmit() END
	function insertClassHomeworkPage(hwList){
		console.log(hwList);
		console.log(hwList.hw_idnum);
		var str ="";
		var hwInsertPage = $('#classRight');
		hwInsertPage.html("");
		hwInsertPage.append("<div id='hwInsertDiv' style='width:500px; height:652px; margin:auto; text-align:left;'></div>");
		str += "<h4>"+hwList.hw_num+"강 과제: "+hwList.hw_hwname+" 업로드</h4><hr>"
			str += "<form method='post' id='insertHw' enctype='multipart/form-data'>";
			str += "<input type='hidden' id='idnum' name='hw_idnum' value='"+hwList.hw_idnum+"'>";
			str += "<input type='hidden' id='lv' name='hw_lv' value='"+hwList.hw_lv+"'>";
			str += "<input type='hidden' id='num' name= hw_num value='"+hwList.hw_num+"'>";
			str += "<input type='text' id='name' name='hw_hwname' placeholder='과제 제목을 입력해주세요.'><hr/>";
			str += " <input type='file' id='file' name='fl_oriname' multiple='false'><hr/>";
			str += "<input type='button' value='작성하기' onclick='insertHomework()'></form>";	
			$('#hwInsertDiv').append(str);
	}// function insertClassHomeworkPage END
	function insertHomework(){
		var data = $('#insertHw')[0];
		var formData = new FormData(data);
		$.ajax({
			type:'post',
			url:'rest/insertHomework',
			data:formData,
			dataType:'json',
		    processData: false,
		    contentType: false,
		    beforeSend : function(xhr) {
				var $token = $("#token");
				xhr.setRequestHeader($token.data("token-name"), $token.val());
			},success: function(json){
				console.log(json);
				if(json==true){
					alert("과제 제출에 성공했습니다.");
					classHomeworkSubmit();
				}else{
					alert("과제 제출에 실패했습니다.");
					classHomeworkSubmit();
				}
			},error: function(err){
				alert("error:: 과제 제출에 실패했습니다. 관리자에게 문의해주세요.");
				classHomeworkSubmit();
			} 
		});//ajax ED		
	};//function insertHomework END 
	
	
	$('button').click(function(){
		  if($(this).hasClass('btn_unlike')){
		    $(this).removeClass('btn_unlike');
		    $('.ani_heart_m').removeClass('hi');
		    $('.ani_heart_m').addClass('bye');
		  }
		  else{
		    $(this).addClass('btn_unlike');
		    $('.ani_heart_m').addClass('hi');
		    $('.ani_heart_m').removeClass('bye');
		  }
		});
</script>
</html>