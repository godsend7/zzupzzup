<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-채팅방 수정</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/chat.css" />
<script
  src="https://code.jquery.com/ui/1.11.3/jquery-ui.min.js"
  integrity="sha256-xI/qyl9vpwWFOXz7+x/9WkG5j/SVnSw21viy8fWwbeE="
  crossorigin="anonymous"></script>

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		console.log("updateChatView.jsp");
		function fncUpdateChat() {
			
			//==> 유효성 체크
			let restaurantName = $("input[name='restaurantName']").val();
			let chatTitle = $("input[name='chatTitle']").val();
			let chatGender = $("input[name='chatGender']:checked").length;
			let chatAge = $("input[name='chatAge']:checked").length;
			
			/* console.log("restaurantName : " + restaurantName);
			console.log("chatTitle : " + chatTitle);
			console.log("chatGender : " + chatGender);
			console.log("chatAge : " + chatAge); */
			
			if(restaurantName == null || restaurantName.length<1){
				alert("음식점명은 반드시 입력하여야 합니다.");
				$("input[name='restaurantName']").focus();
				return;
			}
			
			if(chatTitle == null || chatTitle.length<1){
				alert("채팅방 제목은 반드시 입력하여야 합니다.");
				$("input[name='chatTitle']").focus();
				return;
			}
			
			if(chatGender == null || chatGender<1){
				alert("참여가능 성별은 반드시 선택하여야 합니다.");
				$("input[name='chatGender']").focus();
				return;
			}
			
			if(chatAge == null || chatAge<1){
				alert("참여가능 연령대는 반드시 선택하여야 합니다.");
				$("input[name='chatAge']").focus();
				return;
			}
			
			//==> submit 기능
			$("form").attr("method", "POST").attr("action", "/chat/addChat").submit();
		}

		$(function() {
			//==> Form Submit 처리
			$("input[value='채팅방 수정']").on("click", function() {
				fncUpdateChat();
			});
			
			//=========== 음식점 찾는거 rest ================//
			
			/* $("input[name='restauratName']").on("keypress",function() {
				console.log("하하하");
				
			}); */			
			
			/* $("#restauratName").autocomplete({
				source: function(request, response){
					console.log($("#restauratName").val());
					$.ajax({
						url: "/chat/json/listRestaurant",
						method: "GET",
						dataType: "json",
						headers: {
							"Accept": "application/json",
							"contentType": "application/json; charset=euc-kr"
						},
						success: function(JSONData, status){
							
						},
						error: function(e){
							alert(e.responseText);
						}
					});
				}
			}); */
			
			//=========== 연령대 무관 클릭시 나머지 연령대 체크 해제 ================//
			$("input[name=chatAge]").on("click", function(){
				//console.log($(this).attr("id"));
				if($(this).attr("id") == "chatAge7"){
					$("#chatAge1").prop("checked", false);
					$("#chatAge2").prop("checked", false);
					$("#chatAge3").prop("checked", false);
					$("#chatAge4").prop("checked", false);
					$("#chatAge5").prop("checked", false);
					$("#chatAge6").prop("checked", false);
				}else{
					$("#chatAge7").prop("checked", false);
				}
			});
			
			//=========== 연령대 클릭시 나머지 연령대 다 체크하면 해당 체크 해제 연령대 무관 체크================//
			$("input[name=chatAge]").change(function(){
				if($("#chatAge6").is(":checked") && $("#chatAge5").is(":checked") && $("#chatAge4").is(":checked") && $("#chatAge3").is(":checked") && $("#chatAge2").is(":checked") && $("#chatAge1").is(":checked")){
					//console.log("나이대 상관 없이 다 선택");
					$("#chatAge1").prop("checked", false);
					$("#chatAge2").prop("checked", false);
					$("#chatAge3").prop("checked", false);
					$("#chatAge4").prop("checked", false);
					$("#chatAge5").prop("checked", false);
					$("#chatAge6").prop("checked", false);
					$("#chatAge7").prop("checked", true);
				}else{
					//console.log("나이대 하나씩 선택");
				}
			})

		});
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

				<section id="updateChatView">
					<div class="container">

						<!-- start:Form -->
						<h3>쩝쩝친구 수정</h3>

						<form id="addChatView">
							<input type="hidden" name="chatRestaurant.restaurantNo" id="restaurantNo" value="1">
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
										<p>남</p>
										</c:when>
										
										<c:when test="${chat.chatGender=='2' }">
										<p>여</p>
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
								<div class="col-md-12">
									<input type="checkbox" id="chatAge1" name="chatAge" value="1">
									<label for="chatAge1">10대</label>
								
									<input type="checkbox" id="chatAge2" name="chatAge" value="2">
									<label for="chatAge2">20대</label>
								
									<input type="checkbox" id="chatAge3" name="chatAge" value="3">
									<label for="chatAge3">30대</label>
								
									<input type="checkbox" id="chatAge4" name="chatAge" value="4">
									<label for="chatAge4">40대</label>
								
									<input type="checkbox" id="chatAge5" name="chatAge" value="5">
									<label for="chatAge5">50대</label>
								
									<input type="checkbox" id="chatAge6" name="chatAge" value="6">
									<label for="chatAge6">60대 이상</label>
								
									<input type="checkbox" id="chatAge7" name="chatAge" value="7">
									<label for="chatAge7">연령대 무관</label>
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
								<div class="col-12">
									<label for="chatImage">채팅방 대표 이미지</label>
									<c:if test="${chat.chatImage != 'chatchat.jpg' }">
									<p>기본 이미지 :${chat.chatImage }</p>
									<p><img src="/resources/images/uploadImages/chat/${chat.chatImage }"/></p>
									</c:if>
									
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
									<label for="chatShowStatus">채팅방 노출하지 않기</label>
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-12">
									<ul class="actions justify-content-center">
										<li><input type="button" value="채팅방 목록" class="primary" /></li>
										<!-- <li><input type="reset" value="취소" class="normal" /></li> -->
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