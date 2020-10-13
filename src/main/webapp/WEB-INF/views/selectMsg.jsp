<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.min.js"></script>
   <sec:authorize access="hasRole('ROLE_STUD')">
	<script src="../script/wsocket.js"></script>
</sec:authorize>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<style>
* {box-sizing: border-box}
body {font-family: "Lato", sans-serif;}

/* Style the tab */
.tab {
  float: left;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
  width: 150px;
  height: 300px;
}

/* Style the buttons inside the tab */
.tab button {
  display: block;
  background-color: inherit;
  color: black;
  padding: 22px 16px;
  width: 100%;
  border: none;
  outline: none;
  text-align: left;
  cursor: pointer;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current "tab button" class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  float: left;
  padding: 0px 12px;
  border: 1px solid #ccc;
  width: 70%;
  border-left: none;
  height: 300px;
}
aside {
	/* background-color: blue; */
	width: 300px;
	float: left;
	position: absolute;
	transform :translate(0px, 230px;)
}

section {
	/* background-color: pink; */
	width: 1000px;
	float: left;
	position: absolute;
	transform:translate(300px,0px); 
	height: 500px;
}
table.type11 {
    border-collapse: separate;
    border-spacing: 1px;
    text-align: center;
    line-height: 1.5;
    margin: 20px 10px;
}
table.type11 th {
    width: 155px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    color: #fff;
    background: #ce4869 ;
}
table.type11 td {
    width: 155px;
    padding: 10px;
    vertical-align: top;
    border-bottom: 1px solid #ccc;
    background: #eee;
}
div.tabcontent{
 height: 500px;
}
div.tab{
height: 500px;
}




</style>
<body>
<header>
    <jsp:include page="./h2k5every_loginHeader.jsp" /><!-- 동적인 방식 --> 
   </header>
   <aside>
      <jsp:include page="./h2k5every_aside.jsp" />
   </aside>
   <section id="section" style=" margin-left: 20px;"  >
   <div class="tab" style="background-color: #ce4869;">
  <button class="tablinks" onclick="openCity(event, 'London')" id="defaultOpen">총 메일<span class="badge"></span></button>
  <button class="tablinks" onclick="openCity(event, 'Paris')" >안읽은 메일<span class="badge"></span></button>
  <button class="tablinks" onclick="openCity(event, 'Tokyo')">읽은메일</button>
</div>

<div id="London" class="tabcontent" style="overflow: auto;"> 
</div>

<div id="Paris" class="tabcontent" style="overflow: auto;">

</div>

<div id="Tokyo" class="tabcontent" style="overflow: auto;">

</div>

   </section>
   <footer>
 <jsp:include page="./h2k5every_footer.jsp" />
   </footer>
   <script>
   function openCity(evt, cityName) {
	   var i, tabcontent, tablinks;
	   tabcontent = document.getElementsByClassName("tabcontent");
	   for (i = 0; i < tabcontent.length; i++) {
	     tabcontent[i].style.display = "none";
	   }
	   tablinks = document.getElementsByClassName("tablinks");
	   for (i = 0; i < tablinks.length; i++) {
	     tablinks[i].className = tablinks[i].className.replace(" active", "");
	   }
	   document.getElementById(cityName).style.display = "block";
	   evt.currentTarget.className += " active";
	 }

	 // Get the element with id="defaultOpen" and click on it
	 document.getElementById("defaultOpen").click();
   </script>
  
 
   
   
   <script>
   var aaclmsg = ${aaclmsg};
   console.dir(aaclmsg);
   all();
   read();
   noread();
   
   function all() {
	   var num=aaclmsg.length;
	   var st=0;
	   $('#London').append("<center><table class='type11'><thead><tr><th>글번호</th><th>알림</th><th>보낸시간</th><th>읽음여부</th></tr></thead><tbody id='aa'></tbody>");
	   for(var i=0; i<aaclmsg.length; i++){
	   $('#aa').append("<tr><td>"+(i)+"</td><td><a style='text-decoration: none; color: black;' onclick=\"readMsg('"+aaclmsg[i].msg_id+"','"+aaclmsg[i].msg_text+"','"+aaclmsg[i].msg_st+"')\">"+aaclmsg[i].msg_id+"님의 쪽지를 보냈습니다.</a></td><td>"+aaclmsg[i].msg_date+"</td><td id='re"+i+"'></td></tr>");
	   if(aaclmsg[i].msg_st==1){
		   $('#re'+i).text('읽음');
	   }else{
		   $('#re'+i).text('안읽음');
		   st=st+1;
	   }
	   }
	   $('#London').prepend("</table></center>");
	   $('.badge').text(st);
	   
	   
}
   
   function read() {
	   var num=0;
	   $('#Tokyo').append("<center><table class='type11'><thead><tr><th>글번호</th><th>알림</th><th>보낸시간</th></tr></thead><tbody id='rr'></tbody>");
	   for(var i=0; i<aaclmsg.length; i++){
		   console.log("aaclmsg[i].msg_st= "+aaclmsg[i].msg_st);
		   if(aaclmsg[i].msg_st==1){
			   $('#rr').append("<tr><td>"+(num++)+"</td><td><a style='text-decoration: none; color: black;' onclick=\"readMsg('"+aaclmsg[i].msg_id+"','"+aaclmsg[i].msg_text+"','"+aaclmsg[i].msg_st+"')\">"+aaclmsg[i].msg_id+"님의 쪽지를 보냈습니다.</a></td><td>"+aaclmsg[i].msg_date+"</td></tr>");
	   		$('#Tokyo').prepend("</table></center>");
	   }
}
   }
   
   
   function noread() {
	   var num=0;
	   $('#Paris').append("<center><table class='type11'><thead><tr><th>글번호</th><th>알림</th><th>보낸시간</th></tr></thead><tbody id='nn'></tbody>");
	   for(var i=0; i<aaclmsg.length; i++){
		   console.log("aaclmsg[i].msg_st= "+aaclmsg[i].msg_st);
		   if(aaclmsg[i].msg_st==0){
			   $('#nn').append("<tr><td>"+(num++)+"</td><td><a style='text-decoration: none; color: black;' onclick=\"readMsg('"+aaclmsg[i].msg_id+"','"+aaclmsg[i].msg_text+"','"+aaclmsg[i].msg_st+"')\">"+aaclmsg[i].msg_id+"님의 쪽지를 보냈습니다.</a></td><td>"+aaclmsg[i].msg_date+"</td></tr>");
	   		$('#Paris').prepend("</table></center>");
	   }
}
   }
   
	 function readMsg(msg_id,msg_text,msg_st) {
		 alert(msg_id+"의 쪽지입니다.\n"+msg_text);
		 if(msg_st==0){
			 upMsg(msg_id,msg_text);
		 }
	}
	 
   
   
   
   
   
   
   
   //<a onclick=\"upMsg('"+aaclmsg[i].msg_id+"','"+msg_text+"')\">
   function upMsg(msg_id,msg_text){
	   $.ajax({
	  				url:'/h2k5every/stud/rest/upDateSt?msg_id='+msg_id+'&msg_text='+msg_text,
	  				type:'GET',
	  				dataType: 'json',
	  				success: function(result) {
	  					alert("해당쪽지가 읽음처리 되었습니다.");	
	  					location.reload();
	  				},
	  					error: function(err) {
	  					console.log(err)
	  			
	  					}
	  				
	  				});
	  }

   </script>

   
   
   
   
   
   
   
</body>


</html>