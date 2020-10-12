
$(function() {
	var wsocket=undefined;
	var socket =undefined;
	console.log("webSocketConnect");
	
	
function webSocketConnect() {
		// 로그인했고 웹 소켓 연결이 되지 않았다면...연결
		if(wsocket==undefined) {
			wsocket = new WebSocket("ws://localhost:8088/h2k5every/ws");
			
				wsocket.onopen = function() {
			console.log("wsocket연결");
		}
		wsocket.onclose = function() {
			console.log("wsocket해제");
		}
		
			wsocket.onmessage = function(evt) {
				var data = evt.data.split(":");
				var newmsg = confirm("새로운 알림이 있습니다. 확인 하시려면 확인을 눌러주세요");
				if(newmsg){
					alert(data[0]+"님의 메세지입니다.\n내용: "+data[1]);
					upDateSt(data[0],data[1]);	
				
		}
}
        }
}

	
	webSocketConnect();	
});



	function upDateSt(msg_id,msg_text){
	$.ajax({
					url:'/h2k5every/stud/rest/upDateSt?msg_id='+msg_id+'&msg_text='+msg_text,
					type:'GET',
					dataType: 'json',
					beforeSend : function(xhr){
						var $token = $("#token");
						xhr.setRequestHeader($token.data("token-name"), $token.val());
						},
					success: function(result) {
					alert('해당 쪽지가 읽음 처리되었습니다.');

							
					},
						error: function(err) {
						console.log(err)
				
						}
					
					});
	}






