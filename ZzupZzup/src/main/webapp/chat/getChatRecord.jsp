<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-채팅방 기록</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/chat.css" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		console.log("getChatRecord.jsp");
		
		const chatNo = $("#chatNo");
		const memberId = $("#memberId");
		const nickname = $("#nickname");
		const profileImage = $("#profileImage");
		const chatList = $(".chatting-list");
		const displayContainer = $(".display-container");
		
		showCollections();
		
		// 채팅 내역 가져오기 함수
		function showCollections(){
			$.ajax({
				url:"/mongo/json/getChatCon/"+chatNo.val(),
				type:"GET",
				dataType: "json",
				headers: {
					"Accept": "application/json",
					"Content-Type": "application/json"
				},
				success:function(JSONData, status){
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
						dom += '<li class="'+msgType+'"><div class="chatProfile"><img src="https://zzupzzup.s3.ap-northeast-2.amazonaws.com/review/'+mem_profile_img+'"/><b>'+value.chatMemberName+'</b><small>'+newTime+'</small></div><div class="chat-message">'+value.msg+'</div></li>';
					});
					chatList.html(dom);
					displayContainer.scrollTop(chatList.height());
					
					console.log("success");
				},
				error:function(e){
					console.log("err : " + e);
				}
			});
		}
		
		//채팅방 시간 포멧 함수
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
			var time = hour + ":" + minutes + " " + amPm;
			return time;
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
				
				<section id="getChatRecord">
					<div class="container">
						
						<!-- S:chatting -->
						<div class="d-flex flex-row chat-container">
							<input type="hidden" id="memberId" value="${member.memberId}"/>
							<input type="hidden" id="nickname" value="${member.nickname}"/>
							<input type="hidden" id="profileImage" value="${member.profileImage}"/>
							<input type="hidden" id="chatNo" value="${chat.chatNo}"/>
						
							<div class="chat-contents d-flex flex-column">
								<div class="chat-header d-flex flex-row align-items-center">
									<h3 class="flex-fill">${chat.chatTitle}</h3>
									<div class="chat-header-util flex-fill">
										<span>${chat.chatRegDate}</span>
										<span class="badge badge-secondary chat-state">${chat.chatNo}</span>
									</div>
								</div>
								<div class="chat-body">
									<div class="display-container">
										<ul class="chatting-list">
	             						</ul>
									</div>
								</div>
							</div>
							
						</div>
						<!-- E:chatting -->

					</div>
				</section>
			</div>
		</div>
		<!-- E:Main -->
		
		<!-- Sidebar -->
		<jsp:include page="/layout/sidebar.jsp" />
	</div>
	<!-- E:Wrapper -->
</body>
</html>