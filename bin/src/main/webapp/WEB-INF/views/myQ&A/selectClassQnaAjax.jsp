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
</head>
<style>
.cS {
   text-align: center;
   top: 30%;
   left: 50%;
/*    transform: translate(-50%, -50%);
   position: absolute; */
   padding: 5px 10px;
}

#delbtn {
   text-align: center;
   top: 70%;
   left: 70%;
/*    transform: translate(-50%, -50%);
   position: absolute; */
   padding: 5px 10px;
}

.search {
   text-align: center;
   top: 70%;
   left: 50%;
/*    transform: translate(-50%, -50%);
   position: absolute; */
   padding: 5px 10px;
}

#Paging {
   text-align: center;
   top: 70%;
   left: 30%;
/*    transform: translate(-50%, -50%);
   position: absolute; */
   padding: 5px 10px;
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
<body>
<header>
      <jsp:include page="../h2k5every_loginHeader.jsp" /><!-- 동적인 방식 -->
   </header>
   <aside>
      <jsp:include page="../h2k5every_aside.jsp" />
   </aside>
   <section id="section" style="margin-left: 20px;">
<input type='hidden' id='token' data-token-name='${_csrf.headerName}' name = '${_csrf.parameterName}' value='${_csrf.token}' />
 <input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}" />
   <form action="searchbtn">
      <table>
         <tr>
            <td width="600px"><select name="search" id="search">
                  <option>----------</option>
               <c:forEach var="Clasc" items="${sList}" varStatus="i">
         <option value = "${Clasc.cl_clname}">${Clasc.cl_clname}</option>
      </c:forEach>
            </select>
               <button>검색</button>
         </tr>
      </table>
   </form>
   <table class="cS" id="cS">
      <tr bgcolor="skyblue" height="30">
         <th width="150">회차</th>
         <th width="150">강좌명</th>
         <th width="150">제목</th>
         <th width="250">작성자 | 삭제</th>
         <td width="250">날짜</td>
      </tr>
      <tbody id="tableShow">
         <c:forEach var="Clasc" items="${cList}">
            <tr height="25">
               <td align="center">${Clasc.co_num}</td>
               <td align="center">${Clasc.co_name}</td>
               <td align="center"><a
                  href='selectClassQnaDetailAjax?cob_bonum=${Clasc.cob_bonum}'>${Clasc.cob_title}</a></td>
               <td align="center">${Clasc.cob_id}<input type='checkbox'
                  id="btncheck" value='${Clasc.cob_bonum}'></td>
               <td align="center">${Clasc.cob_date}</td>
            </tr>
         </c:forEach>
      </tbody>
   </table>
   <div align="center" id="Paging">${Paging}</div>
   <button id="delbtn" onclick="dtncheck()">삭제</button>
   <div class="search">
      <form action="searchClassQnaDetail">
         <select name="selvalue">
            <option value="searchWriter" selected="selected">작성자</option>
            <option value="searchTitle">제목</option>
            <option value="searchCont">내용</option>
         </select> <input type="text" name="search" placeholder="입력하기" />
         <button>검색</button>
      </form>
   </div>
   </section>
   <footer>
      <jsp:include page="../h2k5every_footer.jsp" />
   </footer>
</body>

<script type="text/javascript">
   function dtncheck(click) {
      var confirm_test = confirm("삭제하시겠습니까??");
      var dtnval = $(":input:checkbox[id=btncheck]:checked").val();
      var selval = $('#selval').val();
      var page = $('#page').val();
      var sch = $('#searchval').val();
      var schUrl = encodeURIComponent(sch);
  
         var json = new Object();
         json.cob_bonum = dtnval;
         $.ajax({
            type : 'post',
            dataType : 'json',
            url : 'rest/cobdelete',
            beforeSend : function(xhr)
               {      //이거 안하면 403 error
                  //데이터를 전송하기 전에 헤더에 csrf값을 설정한다
                  var $token = $("#token");
                  xhr.setRequestHeader($token.data("token-name"), $token.val());
               },
            contentType : 'application/json; charset=UTF-8',
            data : JSON.stringify(json),
            success : function(data) {
               console.log(data);
               if (confirm_test == true) {
                  alert("삭제완료.")
                  if(selval == null){        
                	    console.log("hans_uriCheck = ", schUrl);
                	      console.log(json);
                  location.href = "searchbtn?search="+schUrl+"&pageNum="+page+"";
                  }else if(selval != null){
                  location.href = "searchClassQnaDetail?selvalue="+selval+"&search="+sch+"&pageNum="+page+"";
            }
               } else if (confirm_test == false) {
                  alert("삭제가 취소되었습니다.")
               }
   }
         })
         }
</script>
</html>