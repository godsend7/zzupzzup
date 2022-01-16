<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-채팅방</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/chat.css" />

<!--  ///////////////////////// CSS ////////////////////////// -->

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<!-- <script src="http://localhost:3000/socket.io/socket.io.js"></script> -->
<script src="http://18.191.246.235:3000/socket.io/socket.io.js"></script>
<script type="text/javascript">
	$(function() {
		console.log("getChatEntrance.jsp");
		
		//==>페이지 접속시 socket.io 접속
		/* const socket = io.connect('http://localhost:3000', { */
		const socket = io.connect('http://18.191.246.235:3000', {
			cors: { origin: '*' }
		});
		
		const chatNo = $("#chatNo").val();
		const chatLeaderId = $("#chatLeaderId").val();
		const memberId = $("#memberId").val();
		const nickname = $("#nickname").val();
		const gender = $("#gender").val();
		const age = $("#ageRange").val();
		const profileImage = $("#profileImage").val();
		const $chatList = $(".chatting-list");
		const $chatInput = $(".chatting-input");
		const $sendButton = $(".send-button");
		const $chatUpload = $("#chatUpload");
		const $uploadButton = $(".upload-button");
		const $displayContainer = $(".display-container");
		const $userList = $(".user-list");
		
		//==>접속한 유저의 정보
		const memberInfo = {
			chatNo : chatNo,
			chatLeaderId : chatLeaderId,
			memberId : memberId,
			nickname : nickname,
			gender : gender,
			age : age,
			profileImage : profileImage
		}
		
		//==>페이지 로딩시 접속된 애들 가져오기
		memList();

		//==>페이지 로딩시 채팅 내역 가져오기
		showCollections();
		
		//==>접속시 접속 유저 정보를 노드서버로 보냄
		socket.emit('new_user', memberInfo);
		
		//==>시스템 문구 출력되는 부분
		socket.on('update', (data) => {
			console.log("====update====");
			console.log(data);
			const item = new makeSysemPost(data.message);
			if(data.chatNo == chatNo){
				item.makeLi();
				if(data.type == "connect"){
					updateConnected(data.chatNo,data.memberId, true);
				}else if(data.type == "disconnect"){
					updateConnected(data.chatNo,data.memberId, false);
				}
			}
			$displayContainer.scrollTop($chatList.height());
			
			//==>나갔다 들어올 때 멤버 확인 리스트 출력
			setTimeout(function() { 
				memList(data.memberId);
			}, 500);
		});
		
		//==>유저가 채팅방을 나갔을 때
		socket.on('disconnect', (data) => {
			console.log(data);
			updateConnected(data.memberId, false);
			memList(data.memberId);
		});
		
		//==>서버에서 온 메세지 받기
		socket.on("send_msg", (data) => {
			const { message, memberInfo, regDate } = data;
			const item = new makeClientPost(message, memberInfo, regDate);
			if(data.memberInfo.chatNo == chatNo){
				item.makeLi();
				updateConnected(data.memberInfo.chatNo,data.memberInfo.memberId, true);
				setTimeout(function() { 
					memList(data.memberInfo.memberId);
				}, 500);
			}
			//console.log("con scroll" + $chatList.height());
			$displayContainer.scrollTop($chatList.height());
		});
		
		//==>서버에서 온 이미지 받기
		socket.on("send_img", (data) => {
			const { message, memberInfo, regDate } = data;
			const item = new makeClientPost(message, memberInfo, regDate);
			if(data.memberInfo.chatNo == chatNo){
				item.makeLi();
				updateConnected(data.memberInfo.chatNo,data.memberInfo.memberId, true);
				setTimeout(function() { 
					memList(data.memberInfo.memberId);
				}, 500);
			}
			//console.log("con scroll" + $chatList.height());
			$displayContainer.scrollTop($chatList.height());
		});
		
		//==>엔터쳤을때도 메세지 보내기
		$chatInput.on("keypress", (e) => {
			if(e.keyCode === 13){
				if($chatInput.val() != '' && $chatInput.val().lenght != 0 && $chatInput.val() != null){
					messageSend();
				}
			}
		});
		
		//==>메세지 보내기 버튼 클릭시
		$sendButton.on("click", function(){
			if($chatInput.val() != '' && $chatInput.val().lenght != 0 && $chatInput.val() != null){
				messageSend();
			}
		});
		
		//==>채팅방 폭파
		socket.on("bomb_msg", (data) => {
			console.log("폭파왔다.");
			console.log(data);
			if(data.chatNo == chatNo){
				$("#chatBombModal").modal('show');
			}
		});
		
		//==>참여자 강퇴
		socket.on("get_out_msg", (data) => {
			console.log("강퇴 왔다.");
			console.log(data);
			console.log(data.chatNo +"==="+ data.getOutId);
			console.log(chatNo +"==="+ memberId);
			
			if(data.chatNo == chatNo && data.getOutId == memberId){
				console.log("갸갸갸");
				$("#outingChat").modal("show");
				updateGetOutChatMember(data.chatNo,data.getOutId);
				$("body").on("click", function(e){
					e.preventDefault();
					location.href="/chat/listChat";
				});
				/* setTimeout(function() { 
				}, 1000); */
			}
		});
		
		// 채팅방 폭파
		function bombChat(){
			console.log("폭파시킨다");	
			socket.emit("bomb_msg", memberInfo);
		}
		
		// 참여자 강퇴
		function getOutMember(getOutId){
			console.log(getOutId + "강퇴시킨다.");	
			socket.emit("get_out_msg", {
				memberInfo : memberInfo,
				getOutId : getOutId
			});
		}
		
		// 메세지 보내기
		function messageSend(){
			socket.emit("send_msg", {
				type: "send",
				msgType: "client",
				message: $chatInput.val(),
				regDate: new Date(),
				memberInfo
			});
			//보낸후 적힌 메세지 지우기
			$chatInput.val("");
		}
		
		// 이미지 보내기
		function uploadSend(){
			socket.emit("send_img", {
				type: "send",
				msgType: "client",
				message: '<img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/chat/'+$chatUpload.val()+'"/>',
				regDate: new Date(),
				memberInfo
			});
			//보낸후 파일 저장된 지우기
			$chatUpload.val("");
		}
		
		// 시스템 메세지 출력
		function makeSysemPost(message){
			this.makeLi = () => {
				//console.log(name, message);
				const $li = $("<li class='system'></li>");
				const dom = "<div class='chat-message'>"+message+"</div>";
				$li.html(dom).appendTo($chatList);
			}
		}
		
		// 채팅 메세지 출력
		// 이미지 경로 변경
		/* function makeClientPost(message, memberInfo, regDate){
			this.makeLi = () => {
				console.log(message, memberInfo, regDate);
				let mem_profile_img = memberInfo.profileImage;
				mem_profile_img != "defaultImage.png" ? mem_profile_img = "uploadImages/"+mem_profile_img : "";
				const $li = $("<li></li>");
				$li.addClass(nickname == memberInfo.nickname ? "sent" : "received");
				const dom = '<div class="chatProfile"><img src="/resources/images/common/'+mem_profile_img+'"/><b>'+memberInfo.nickname+'</b><small>'+regDate+'</small></div><div class="chat-message">'+message+'</div>';
				$li.html(dom).appendTo($chatList);
			}
		} */
		function makeClientPost(message, memberInfo, regDate){
			this.makeLi = () => {
				console.log(message, memberInfo, regDate);
				let mem_profile_img = memberInfo.profileImage;
				mem_profile_img == "defaultImage.png" ? mem_profile_img = "common/"+mem_profile_img : "member/"+mem_profile_img;
				const $li = $("<li></li>");
				$li.addClass(nickname == memberInfo.nickname ? "sent" : "received");
				const dom = '<div class="chatProfile"><img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/'+mem_profile_img+'"/><b>'+memberInfo.nickname+'</b><small>'+regDate+'</small></div><div class="chat-message">'+message+'</div>';
				$li.html(dom).appendTo($chatList);
			}
		}
		
		// 참가자 강퇴 rest
		function updateGetOutChatMember(chatNo,memberId){
			$.ajax({
				url: "/chat/json/updateGetOutChatMember/chatNo="+chatNo+"&memberId="+memberId+"&",
				method:"GET",
				dataType: "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success: function(JSONData){
					console.log("success");
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
				}
			});
		}
		
		// 참가자 접속 아닌사람 connected 해제
		function updateConnected(chatNo,memberId,onConnected){
			$.ajax({
				url: "/chat/json/updateConnectedChatMember/chatNo="+chatNo+"&memberId="+memberId+"&onConnected="+onConnected,
				method:"GET",
				dataType: "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success: function(JSONData){
					console.log("success");
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
				}
			});
		}
		
		// 참가자 리스트에 뿌려질 리스트 가져오기 함수
		function memList(memberId){
			$.ajax({
				url: "/chat/json/listChatMember/chatNo=${chat.chatNo}",
				method: "GET",
				dataType: "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status) {
					//console.log(JSONData);
					let dom = "";
					let memberCount = "";
					//console.log(JSONData.list);
					$.each(JSONData.list, function(index, item){
						//console.log(item);
						memberCount = JSONData.list.length;
						let mem_profile_img = item.member.profileImage;
						let mem_gender = item.member.gender;
						//console.log(mem_profile_img);
						//console.log(mem_gender);
						// 업로드된 프로필 이미지라면 경로 변경
						// 이미지 경로 변경
						/* mem_profile_img != "defaultImage.png" ? mem_profile_img = "uploadImages/"+mem_profile_img : ""; */
						mem_profile_img == "defaultImage.png" ? mem_profile_img = "common/"+mem_profile_img : "member/"+mem_profile_img;
						// 성별 한글 변환
						if(mem_gender == "male"){
							mem_gender = "남자";
						}else if(mem_gender == "female"){
							mem_gender = "여자";
						}
						const chatLeaderClass = "${chat.chatLeaderId.memberId}" == item.member.memberId ? "chat-leader":"";
						// 멤버들중 들어온 애들 루핑
						const chatConnected = item.onConnected == true ? "connected" : ""; 
						
						//이미지 경로 변경
						/* dom += '<li class="chatProfile d-flex flex-row align-items-center '+chatLeaderClass+' '+chatConnected+'"><img src="/resources/images/common/'+mem_profile_img+'"><div class="dropmenu"><a href="" class="member_dropdown dropmenu-btn" data-target="'+item.member.memberId+'" data-toggle="dropmenu">'+item.member.nickname+'</a></div><span class="badge badge-info gender">'+mem_gender+'</span><span class="badge badge-warning age">'+item.member.ageRange+'</span></li>'; */
						dom += '<li class="chatProfile d-flex flex-row align-items-center '+chatLeaderClass+' '+chatConnected+'"><img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/'+mem_profile_img+'"><div class="dropmenu"><a href="" class="member_dropdown dropmenu-btn" data-target="'+item.member.memberId+'" data-toggle="dropmenu">'+item.member.nickname+'</a></div><span class="badge badge-info gender">'+mem_gender+'</span><span class="badge badge-warning age">'+item.member.ageRange+'</span></li>';
						
					});
					$userList.html(dom);
					$(".member-count").html(memberCount);
					$displayContainer.scrollTop($chatList.height());
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
				}
			});
		}
		
		// 채팅 내역 가져오기 함수
		function showCollections(){
			$.ajax({
				url:"/mongo/json/getChatCon/"+chatNo,
				type:"GET",
				dataType: "json",
				headers: {
					"Accept": "application/json",
					"Content-Type": "application/json"
				},
				success:function(JSONData, status){
					console.log("몽고디비 데이터");
					console.log(JSONData);
					let dom = "";
					
					// 이미지 경로 변경
					/* $.each(JSONData, function(key, value){
						let timeStemp = new Date(value.regDate);
						let newTime = timeFormatter(timeStemp);
						let mem_profile_img = value.chatMemberImg;
						mem_profile_img != "defaultImage.png" ? mem_profile_img = "uploadImages/"+mem_profile_img : "";
						const msgType = nickname == value.chatMemberName ? "sent" : "received";
						dom += '<li class="'+msgType+'"><div class="chatProfile"><img src="/resources/images/common/'+mem_profile_img+'"/><b>'+value.chatMemberName+'</b><small>'+newTime+'</small></div><div class="chat-message">'+value.msg+'</div></li>';
					}); */
					$.each(JSONData, function(key, value){
						let timeStemp = new Date(value.regDate);
						let newTime = timeFormatter(timeStemp);
						let mem_profile_img = value.chatMemberImg;
						mem_profile_img == "defaultImage.png" ? mem_profile_img = "common/"+mem_profile_img : "member/"+mem_profile_img;
						const msgType = nickname == value.chatMemberName ? "sent" : "received";
						dom += '<li class="'+msgType+'"><div class="chatProfile"><img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/'+mem_profile_img+'"/><b>'+value.chatMemberName+'</b><small>'+newTime+'</small></div><div class="chat-message">'+value.msg+'</div></li>';
					});
					$chatList.html(dom);
					$displayContainer.scrollTop($chatList.height());
				},
				error:function(e){
					console.log("err : " + e);
				}
			});
		}
		
		// 채팅방 시간 포멧 함수
		function timeFormatter(dateTime){
			var date = new Date(dateTime);
			if (date.getHours()>=12){
			    var hour = parseInt(date.getHours()) - 12;
			    var amPm = "PM";
			} else {
			    var hour = date.getHours();
			    var amPm = "AM";
			}
			if (date.getMinutes() <10){
				var minutes = "0"+date.getMinutes();
			}else{
				var minutes = date.getMinutes();
			}
			if (date.getMonth()+1 <10){
				var month = "0"+(date.getMonth()+1);
			}else{
				var month = date.getMonth()+1;
			}
			if (date.getDate() <10){
				var day = "0"+date.getDate();
			}else{
				var day = date.getDate();
			}
			var time = month + "-" + day + " " + hour + ":" + minutes + " " + amPm;
			return time;
		}
		
		//============= "참여자 닉네임" Event 처리 =========
		$("body").on("click", ".member_dropdown", function(e) {
			e.preventDefault();
			let dataTarget = $(this).attr("data-target");
			let dom = '';

			dom += '<div class="dropmenu-list">'
				+ '<a href="#" class="dropmenu-item getOtherUserModal" data-toggle="modal" data-target="#getOtherUserModal" data-id="'+dataTarget+'">프로필 보기</a>';
			if("${member.memberId}" != dataTarget){
			dom += '<a href="" class="reportModal dropmenu-item" data-target="#reportModal" data-toggle="modal" data-id=\'["2","'+dataTarget+'"]\' class="dropmenu-item">참여자 신고</a>';
			}
			if("${chat.chatLeaderId.memberId}" == "${member.memberId}" && "${member.memberId}" != dataTarget){
				dom += '<a href="" id="getOutNow" class="dropmenu-item" data-target="#getOutModal" data-toggle="modal" data-id="'+dataTarget+'">참여자 강퇴</a>'
			}
			dom += '</div>';
			let isActive = $(this).siblings(".dropmenu-list").hasClass("active");
			if(isActive){
				$(".user-list .dropmenu-list").remove();
			}else{
				$(".user-list .dropmenu-list").remove();
				$(this).parent().append(dom);
			}
		});
		
		//============= "예약하기" Event 처리 ============
		$("#chatReservationBefore").on("click", function() {
			console.log("예약한 애들 불러오기");
			$.ajax({
				url : "/chat/json/listReadyCheckMember/chatNo=${chat.chatNo}",
				method : "GET",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"contentType" : "application/json; charset=utf-8"
				},
				success : function(JSONData){
					console.log(JSONData);
					let dom ='';
					$.each(JSONData.list, function(index, item){
						console.log(item.member.nickname);
						dom += "<li>"+item.member.nickname+"</li>"
					});
					$(".chat-member-list").html(dom);
				},
				error : function(e) {
					alert(e.responseText);
				}
			})
		});
		
		//============= "예약하기 모달 예" Event 처리 ============
		$("#chatReservationBtn").on("click", function() {
			console.log("예약하기");
			let chatNo = "${chat.chatNo }";
			location.href="/chat/getChatReservation?chatNo="+chatNo;
		});
		
		//============= "모임참여 체크하기" Event 처리 ============
		$("body").on("click", "input[value='모임참여 체크하기']", function() {
			console.log("모임참여 체크하기");
			$.ajax({
				url : "/chat/json/updateReadyCheck/chatNo=${chat.chatNo}&readyCheck=true",
				method : "GET",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"contentType" : "application/json; charset=utf-8"
				},
				success : function(JSONData){
					console.log("바꾸기 성공");
					$("input[value='모임참여 체크하기']").val('모임참여 해제하기');
					$('#chatReservationOkModal').modal('show');
				},
				error : function(e) {
					alert(e.responseText);
				}
			});
		});
			
		//============= "모임참여 해제하기" Event 처리 ============
		$("body").on("click", "input[value='모임참여 해제하기']", function() {
			console.log("모임참여 해제하기");
			$.ajax({
				url : "/chat/json/updateReadyCheck/chatNo=${chat.chatNo}&readyCheck=false",
				method : "GET",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"contentType" : "application/json; charset=utf-8"
				},
				success : function(JSONData){
					console.log("바꾸기 성공");
					$("input[value='모임참여 해제하기']").val('모임참여 체크하기');
					$('#chatReservationCancleModal').modal('show');
				},
				error : function(e) {
					alert(e.responseText);
				}
			});
		});
		
		//============= "나가기" Event 처리 ============
		$("#chatOutBtn").on("click", function() {
			console.log("나가기 클릭");
			//방장이 나가면 폭파 함수 실행
			if(chatLeaderId == memberId){
				bombChat();
			}
			location.href="/chat/deleteChatMember?chatNo=${chat.chatNo}";
		});
		
		//============= "채팅방 폭파" Event 처리 ============
		$("#chatBombBtn").on("click", function(){
			location.href="/chat/listChat";
		});
		
		//============= "강퇴하기" Event 처리 ============		
		$("body").on("click", "#getOutNow", function(){
			const getOutId = $(this).attr("data-id");
			console.log(getOutId);
			$("input[name=getOutId]").val(getOutId);
			//getOutMember(getOutId);
		});
		
		//============= "강퇴하기 예 버튼" Event 처리 ============
		$("#getOutBtn").on("click", function(){
			const getOutId = $("input[name=getOutId]").val();
			getOutMember(getOutId);
		});
		
		
		//============= "이미지 업로드" Event 처리 ============
		//==>drag 파일 업로드
		let $fileDragArea = $(".upload-area");
		let $fileDragBtn = $(".upload-btn");
		let $fileDragInput = $(".upload-input");
		
		//==>박스 안에 Drag 들어왔을 때
		$fileDragArea.on("dragenter", function(e){
			console.log("dragenter");
			$fileDragArea.addClass('is-active');
		});
		
		//==>박스 안에 Drag 하고 있을 때
		$fileDragArea.on("dragover", function(e){
			console.log("dragover");
			
			// 드래그 한 것이 파일인지 아닌지 체크
			let valid = e.originalEvent.dataTransfer.types.indexOf('Files')>= 0;
			console.log(valid);
			
			if(!valid){
				$fileDragArea.addClass('is-warning');
			}else{
				$fileDragArea.addClass('is-active');
			}
		});
		
		//==>박스 밖으로 Drag 나갈 때
		$fileDragArea.on("dragleave", function(e){
			console.log("dragleave");
			$fileDragArea.removeClass('is-active');
		});
		
		//==>박스 안에서 Drag를 Drop 했을 때
		$fileDragArea.on("drop", function(e){
			console.log("drop");
			$fileDragArea.removeClass('is-active');
		});

		//==>change inner text
		$fileDragInput.on('change', function(e) {
			var fileName = $(this).val().split('\\').pop();
			
			const data = e.target;
			console.dir(data);
			
			//유효성 체크
			if(!isValid(data)){
				return;
			}
			
			const formData = new FormData();
			formData.append('uploadFile', data.files[0]);
			
			const saveName = "";
			
			ajax({
				url: '/chat/json/addDragFile',
				method: 'POST',
				data: formData,
				progress: () => {
				},
				loadend: () => {
				}
			});
		});

		// 유효성 검사
		function isValid(data){
			
			//파일인지 유효성 검사
			if(data.type.indexOf('file') < 0){
				alert("파일이 아닙니다.");
				return false;
			}
			
			//이미지인지 유효성 검사
			if(data.files[0].type.indexOf('image') < 0){
				alert('이미지 파일만 업로드 가능합니다.');
				return false;
			}
			
			//파일의 개수는 1개씩만 가능하도록 유효성 검사
			if(data.files.length > 1){
				alert('파일은 하나씩 전송이 가능합니다.');
				return false;
			}
			
			//파일의 사이즈는 10MB 미만
			if(data.files[0].size >= 1024 * 1024 * 10){
				alert('10MB 이상인 파일은 업로드할 수 없습니다.');
				return false;
			}
			
			return true;
		}
		
		// 참고 ajax 커스텀 모듈
		function ajax(obj){
			
			const xhr = new XMLHttpRequest();
			
			var method = obj.method || 'GET';
			var url = obj.url || '';
			var data = obj.data || null;
			
			/* 성공/에러 */
			xhr.addEventListener('load', function() {
				
				const data = xhr.responseText;
				
				if(obj.load)
					obj.load(data);
			});
			
			/* 성공 */
			xhr.addEventListener('loadend', function() {
				
				const data = xhr.responseText;
				
				if(obj.loadend) {
					obj.loadend(data);
				}
				//이미지 경로 수정
				/* saveName = JSON.parse(data).saveName;
				$fileDragView.html("<a href='javascript:void(0)' class='cvf_delete_image'><img src='/resources/images/uploadImages/chat/"+saveName+"'/></a>");
				console.log("saveName : " + saveName);
				$chatUpload.val(saveName); */
				saveName = JSON.parse(data).saveName;
				
				console.log("saveName : " + saveName);
				$chatUpload.val(saveName);
				uploadSend();
			});
			
			/* 실패 */
			xhr.addEventListener('error', function() {
				
				console.log('Ajax 중 에러 발생 : ' + xhr.status + ' / ' + xhr.statusText);
				
				if(obj.error){
					obj.error(xhr, xhr.status, xhr.statusText);
				}
			});
			
			/* 중단 */
			xhr.addEventListener('abort', function() {
				
				if(obj.abort){
					obj.abort(xhr);
				}
			});
			
			/* 진행 */
			xhr.upload.addEventListener('progress', function() {
				
				if(obj.progress){
					obj.progress(xhr);
				}
			});
			
			/* 요청 시작 */
			xhr.addEventListener('loadstart', function() {
				
				if(obj.loadstart)
					obj.loadstart(xhr);
			});
			
			if(obj.async === false)
				xhr.open(method, url, obj.async);
			else
				xhr.open(method, url, true);
			
			if(obj.contentType)
				xhr.setRequestHeader('Content-Type', obj.contentType);	
				
			xhr.send(data);	
		}
		
		
	});
</script>
</head>

<body class="is-preload">
	<!-- S:Wrapper -->
	<div id="wrapper">

		<!-- S:Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<jsp:include page="/layout/header.jsp" />

				<section id="getChatEntrance">
					<div class="container">

						<!-- S:chatting -->
						<div class="d-flex flex-row chat-container">
							<input type="hidden" id="chatNo" value="${chat.chatNo}"/>
							<input type="hidden" id="chatLeaderId" value="${chat.chatLeaderId.memberId}"/>
							<input type="hidden" id="memberId" value="${member.memberId}"/>
							<input type="hidden" id="nickname" value="${member.nickname}"/>
							<input type="hidden" id="gender" value="${member.gender}"/>
							<input type="hidden" id="ageRange" value="${member.ageRange}"/>
							<input type="hidden" id="profileImage" value="${member.profileImage}"/>
							<input type="hidden" id="restaurantNo" value="${chat.chatRestaurant.restaurantNo}"/>
						
							<div class="chat-contents d-flex flex-column">
								<div class="chat-header d-flex flex-row align-items-center">
									<h3 class="flex-fill">${chat.chatTitle}</h3>
									<div class="chat-header-util flex-fill">
										<span>${chat.chatRegDate}</span>
										<span><a href="" id="chatReportBtn" class="svg-btn" title="채팅방 신고" data-toggle="modal" data-target="#chatReportModal" ><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-exclamation-triangle-fill" viewBox="0 0 16 16"><path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/></svg></a></span>
											<c:choose>
													<c:when test="${chat.chatState=='1'}">
														<span class="badge badge-success chat-state">모집중</span>
													</c:when>
													<c:when test="${chat.chatState=='2'}">
														<span class="badge badge-warning chat-state">인원확정</span>
													</c:when>
													<c:when test="${chat.chatState=='3'}">
														<span class="badge badge-info chat-state">예약확정</span>
													</c:when>
													<c:when test="${chat.chatState=='4'}">
														<span class="badge badge-warning chat-state">모임완료</span>
													</c:when>
													<c:when test="${chat.chatState=='5'}">
														<span class="badge badge-danger chat-state">폭파된방</span>
													</c:when>
											</c:choose>
									</div>
								</div>
								<div class="chat-body">
									<div class="display-container">
										<ul class="chatting-list">
	                 						
	             						</ul>
									</div>
								</div>
								<div class="chat-footer">	
	             					<div class="input-container">
	             						<textarea rows="2" class="chatting-input" placeholder="보낼 메세지 입력" wrap="off"></textarea>
	             						<div class="upload-area d-inline-block position-relative mr-2">
											<span class="upload-btn button info">이미지 보내기</span> <input
											class="upload-input" type="file" id="fileDragInput" name="fileDragInput" >
											<input type="hidden" id="chatUpload" name="chatUpload">
										</div>
	             						<input type="button" class="send-button warning" value="보내기" />
	             					</div>
								</div>
							</div>
							
							<div class="chat-user d-flex flex-column">
								<div class="chat-header d-flex flex-row align-items-center">
									<h3 class="flex-fill">참여자 목록<small>(<b class="member-count">${chat.chatMemberCount}</b>/10)</small></h3>
									<div class="chat-header-util">
										<input type="button" class="button small secondary" data-toggle="modal" data-target="#chatLeaderOuteModal" value="나가기" />
										<div class="dropmenu">
											<a href="" class="svg-btn chat-info-button dropmenu-btn" data-toggle="dropmenu" title="채팅방,음식점 정보보기"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-three-dots-vertical" viewBox="0 0 16 16"><path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/></svg></a>
											<div class="dropmenu-list" aria-labelledby="dropmenuList">
												<a href="/restaurant/getRestaurant?restaurantNo=${chat.chatRestaurant.restaurantNo}" class="dropmenu-item" target="_blank">음식점 정보</a>
												<a href="/chat/json/getChat/${chat.chatNo}" data-toggle="modal" data-target="#getChatModal" id="getChatEntranceBtn" class="dropmenu-item">채팅방 정보</a>
												<a href="/chat/listChat" class="dropmenu-item">채팅방 목록</a>
											</div>
										</div>
									</div>
								</div>
								<div class="chat-body">
									<ul class="user-list">
										
									</ul>
								</div>
								<div class="chat-footer">
									<c:choose>
										<c:when test="${chat.chatLeaderId.memberId == member.memberId }">
										<c:choose>
											<c:when test="${chat.chatState == 1 || chat.chatState == 2}">
											<input type="button" id="chatReservationBefore" class="button primary" data-toggle="modal" data-target="#chatReservationModal" value="예약하기"/>
											</c:when>
											<c:otherwise>
											<input type="button" class="button primary small" disabled value="예약완료"/>
											</c:otherwise>
										</c:choose>
											
										</c:when>
										<c:otherwise>
										<c:choose>
											<c:when test="${chat.chatState == 1 || chat.chatState == 2}">
											<input type="button" class="button" value='${chatMember.readyCheck == true ? "모임참여 해제하기" : "모임참여 체크하기"}'/>
											</c:when>
											<c:otherwise>
											<input type="button" class="button" disabled value='모임참여 체크불가'/>
											</c:otherwise>
										</c:choose>
										</c:otherwise>
									</c:choose>
									
								</div>
							</div>
							
						</div>
						<!-- E:chatting -->
						
						<!-- S:Modal -->
						<!-- 예약진행 모달 -->
						<div class="modal fade" id="chatReservationModal" tabindex="-1" aria-labelledby="chatReservationModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-sm">
								<div class="modal-content">
									<div class="modal-header justify-content-end">
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								          <span aria-hidden="true">&times;</span>
								        </button>
									</div>
									<div class="modal-body">
										<p>예약을 진행하시겠습니까?</p>
										<span>모임에 참여된 유저 닉네임</span>
										<ul class="chat-member-list bg-light p-2 rounded">
										</ul>
									</div>
									<div class="modal-footer">
										<button type="button" class="button secondary small" data-dismiss="modal">아니오</button>
										<button type="button" class="button primary small" id="chatReservationBtn">예</button>
									</div>
								</div>
							</div>
						</div>
						
						<!-- 모임확정 모달 -->
						<div class="modal fade" id="chatReservationOkModal" tabindex="-1" aria-labelledby="chatReservationOkModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-sm">
								<div class="modal-content">
									<div class="modal-header justify-content-end">
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								          <span aria-hidden="true">&times;</span>
								        </button>
									</div>
									<div class="modal-body">
										모임참여가 확정되었습니다.
									</div>
									<div class="modal-footer">
										<button type="button" class="button primary small fit" data-dismiss="modal">확인</button>
									</div>
								</div>
							</div>
						</div>
						
						<!-- 모임 취소 모달 -->
						<div class="modal fade" id="chatReservationCancleModal" tabindex="-1" aria-labelledby="chatReservationCancleModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-sm">
								<div class="modal-content">
									<div class="modal-header justify-content-end">
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								          <span aria-hidden="true">&times;</span>
								        </button>
									</div>
									<div class="modal-body">
										모임참여가 취소되었습니다.
									</div>
									<div class="modal-footer">
										<button type="button" class="button primary small fit" data-dismiss="modal">확인</button>
									</div>
								</div>
							</div>
						</div>
						<!-- E:Modal -->
						
						<!-- 나가기 모달 -->
						<div class="modal fade" id="chatLeaderOuteModal" tabindex="-1" aria-labelledby="chatLeaderOuteModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-sm">
								<div class="modal-content">
									<div class="modal-header justify-content-end">
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								          <span aria-hidden="true">&times;</span>
								        </button>
									</div>
									<div class="modal-body">
										<c:choose>
											<c:when test="${chat.chatLeaderId.memberId == member.memberId }">
												방장이 나가면 채팅방이 폭파됩니다.<br/>채팅방을 나가시겠습니까?
											</c:when>
											<c:otherwise>
												채팅방을 나가시겠습니까?
											</c:otherwise>
										</c:choose>
									</div>
									<div class="modal-footer">
										<button type="button" class="button secondary small" data-dismiss="modal">아니오</button>
										<button type="button" class="button primary small" id="chatOutBtn">예</button>
									</div>
								</div>
							</div>
						</div>
						
						<!-- 채팅방 폭파 모달 -->
						<div class="modal fade" id="chatBombModal" tabindex="-1" aria-labelledby="chatBombModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-sm">
								<div class="modal-content">
									<div class="modal-body">
										채팅방이 폭파되었습니다.
									</div>
									<div class="modal-footer">
										<button type="button" class="button primary small" id="chatBombBtn">나가기</button>
									</div>
								</div>
							</div>
						</div>
						
						<!-- 채팅방 신고모달 -->
						<div class="modal fade" id="chatReportModal" tabindex="-1" aria-labelledby="chatReportModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-sm">
								<div class="modal-content">
									<div class="modal-header justify-content-end">
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								          <span aria-hidden="true">&times;</span>
								        </button>
									</div>
									<div class="modal-body">
										채팅방을 신고하시겠습니까?
									</div>
									<div class="modal-footer">
										<button type="button" class="button secondary small" data-dismiss="modal">아니오</button>
										<button type="button" class="button primary small reportModal" data-target='#reportModal' data-toggle='modal' data-id="[1,${chat.chatNo}]">예</button>
										
									</div>
								</div>
							</div>
						</div>
						
						<!-- 참여자 신고모달 -->
						<div class="modal fade" id="memberReportModal" tabindex="-1" aria-labelledby="memberReportModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-sm">
								<div class="modal-content">
									<div class="modal-header justify-content-end">
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								          <span aria-hidden="true">&times;</span>
								        </button>
									</div>
									<div class="modal-body">
										참여자를 신고하시겠습니까?
									</div>
									<div class="modal-footer">
										<button type="button" class="button secondary small" data-dismiss="modal">아니오</button>
										<button type="button" class="button primary small" id="memberReportBtn">예</button>
									</div>
								</div>
							</div>
						</div>
						
						<!-- 참여자 강퇴모달 -->
						<div class="modal fade" id="getOutModal" tabindex="-1" aria-labelledby="getOutModalLabel" aria-hidden="true">
							<div class="modal-dialog modal-sm">
								<div class="modal-content">
									<div class="modal-header justify-content-end">
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								          <span aria-hidden="true">&times;</span>
								        </button>
									</div>
									<div class="modal-body">
										<input type="hidden" name="getOutId">
										참여자를 강퇴시키시겠습니까?
									</div>
									<div class="modal-footer">
										<button type="button" class="button secondary small" data-dismiss="modal">아니오</button>
										<button type="button" class="button primary small" id="getOutBtn" data-target="" data-dismiss="modal">예</button>
									</div>
								</div>
							</div>
						</div>
						
						<!-- 강퇴 당하는 모달 -->
						<div class="modal fade" id="outingChat" tabindex="-1" aria-labelledby="" aria-hidden="true">
							<div class="modal-dialog modal-sm">
								<div class="modal-content">
									<div class="modal-body">
										채팅방에서 강퇴당하셨습니다.
									</div>
								</div>
							</div>
						</div>
						
						<!-- 채팅방 정보보기 모달 -->
						<jsp:include page='/chat/getChatModal.jsp'/>
						<!-- E:Modal -->
						
					</div>
				</section>
			</div>
		</div>
		<!-- E:Main -->
		
		<ul class='icons'> 
			<jsp:include page='/report/addReportView.jsp'/>
		</ul>
		
		<!-- Sidebar -->
		<jsp:include page="/layout/sidebar.jsp" />
	</div>
	<!-- E:Wrapper -->
	
</body>
</html>