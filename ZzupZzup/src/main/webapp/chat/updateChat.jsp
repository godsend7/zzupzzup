<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-채팅방 수정완료</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/chat.css" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		console.log("updateChat.jsp");
		
		//==> Button 이동 처리
		$("input[value='채팅방 목록']").on("click", function() {
			window.open("/chat/listChat", "_self");
		});
		
		$("input[value='채팅방 수정']").on("click", function() {
			location.href="/chat/updateChat?chatNo="+${chat.chatNo};
		});
		

		//==> 연령대 값에 가져와서 화면에 뿌리기
		let ageArr = [${chat.chatAge}];
		console.log(ageArr.length);
		console.log(ageArr);
		let ageTxt = "";
		$(ageArr).each(function(index){
			switch(ageArr[index]){
				case 1 :
					console.log("1번");
					ageTxt += "10대";
					break;
				case 2 :
					console.log("2번");
					ageTxt += "20대";
					break;
				case 3 :
					console.log("3번");
					ageTxt += "30대";
					break;
				case 4 :
					console.log("4번");
					ageTxt += "40대";
					break;
				case 5 :
					console.log("5번");
					ageTxt += "50대";
					break;
				case 6 :
					console.log("6번");
					ageTxt += "60대";
					break;
				default :
					console.log("연령대무관");
					ageTxt = "연령대 무관";
			}
			if(!(ageArr.length-1 <= index)){
				ageTxt += ", ";
			}
		}); 
		console.log(ageTxt);
		$(".chat-age-range").text(ageTxt);
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

				<section id="updateChat">
					<div class="container">

						<!-- start:Form -->
						<h3>쩝쩝친구 채팅방 수정 완료</h3>

						<form id="addChatView">
							<input type="hidden" name="chatRestaurant.restaurantNo" id="restaurantNo" value="${chat.chatRestaurant.restaurantNo }">
							<input type="hidden" name="chatLeaderId.memberId" id="chatLeaderId" value="hihi@a.com">
							<div class="row gtr-uniform">
								<div class="col-md-8">
									<label for="restaurantName">음식점명</label> 
									<p>${chat.chatRestaurant.restaurantName }</p>
										
								</div> 
							</div>
							<div class="row gtr-uniform">
								<div class="col-md-4">
									<label for="restaurantTel">음식점 전화번호</label> 
									<p>${chat.chatRestaurant.restaurantTel }</p>
								</div>
								
								<div class="col-md-4">
									<label for="streetAddress">음식점 도로명 주소</label> 
									<p>${chat.chatRestaurant.streetAddress }</p>
								</div>
								
								<div class="col-md-4">
									<label for="areaAddress">음식점 지번 주소</label> 
									<p>${chat.chatRestaurant.areaAddress }</p>
								</div>
							</div>
							<div class="row gtr-uniform">
								<div class="col-md-8">
									<label for="chatTitle">채팅방 제목</label> 
									<p>${chat.chatTitle }</p>
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-12">
									<label for="chatGender">참여가능 성별</label>
								</div>
							</div>
							<div class="row gtr-uniform">
								<div class="col-md-12">
									<c:choose>
										<c:when test="${chat.chatGender=='1' }">
										<p>남자</p>
										</c:when>
										
										<c:when test="${chat.chatGender=='2' }">
										<p>여자</p>
										</c:when>
										
										<c:otherwise>
										<p>성별무관</p>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-12">
									<label for="chatAge">참여가능 연령대</label>
								</div>
								<div class="col-md-12 chat-age-range">
									
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-12">
									<label for="chatText">채팅방 소개글</label>
									<p>${chat.chatText }</p>
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-md-8">
									<label for="fileDragInput">채팅방 대표 이미지</label>
										<span class="file-drag-msg">
										${chat.chatImage != 'chatimg.jpg' ? chat.chatImage : "대표이미지 없음"}
										</span> 
									<div class="file-drag-view mt-4">
										<c:if test="${chat.chatImage != 'chatimg.jpg' }">
										<img src="/resources/images/uploadImages/chat/${chat.chatImage }"/>
										</c:if>
									</div>
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-12">
									<label for="chatShowStatus">채팅방 노출 여부</label>
								</div>
								<div class="col-md-12">
									<c:choose>
										<c:when test="${chat.chatShowStatus==false }">
										채팅방 미노출
										</c:when>
										<c:when test="${chat.chatShowStatus==true }">
										채팅방 노출
										</c:when>
									</c:choose>
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-12">
									<ul class="actions justify-content-center">
										<li><input type="button" value="채팅방 수정" class="primary" /></li>
										<li><input type="button" value="채팅방 목록" class="" /></li>
									</ul>
								</div>
							</div>
							
						</form>
						<!-- end -->

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