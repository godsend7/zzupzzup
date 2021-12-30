<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-채팅방 수정</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/chat.css" />

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
			$("form").attr("method", "POST").attr("action", "/chat/updateChat").submit();
		}

		//==> Form Submit 처리
		$("input[value='채팅방 수정']").on("click", function() {
			fncUpdateChat();
		});
		
		//==> 음식점 찾는 autocomplete
		var autoResArr = [];
		
		$("#restaurantName").autocomplete({
			source: function(request, response){
				console.log($("#restaurantName").val());
				var searchKeyword = $("#restaurantName").val();
				searchKeyword = escape(encodeURIComponent(searchKeyword));
				$.ajax({
					url: "/chat/json/listRestaurantAutocomplete/searchKeyword="+searchKeyword,
					method: "GET",
					dataType: "json",
					headers: {
						"Accept": "application/json",
						"contentType": "application/json; charset=utf-8"
					},
					success: function(JSONData){
						
						if(JSONData.list == null || JSONData.list == undefined || JSONData.list == "" || JSONData.list.length == 0 ){
							//alert("자료가 없음");
							$(".find-restaurant-txt").text("");
							$(".find-restaurant-txt").text("선택할 수 있는 음식점이 없습니다.");
						}else{
							$(".find-restaurant-txt").text("");
							console.log(JSONData);
							response(
								$.map(JSONData.list, function(item){
									
									autoResArr = {
										"restaurantNo" : item.restaurantNo,
										"restaurantName" : item.restaurantName,
										"restaurantTel" : item.restaurantTel,
										"restaurantSAddr" : item.streetAddress,
										"restaurantAAddr" : item.areaAddress
									};
									
									/* console.log(item.restaurantName);
									console.log(item.restaurantTel);
									console.log(item.streetAddress);
									console.log(item.areaAddress); */
									
									return{
										label: item.restaurantName
									}
								})
							);
						}
						
					},
					error: function(e){
						alert(e.responseText);
					}
				});
			},
			minLength: 1,
			select:function(event, ui){
				//log( "Selected: " + ui.item.value + " aka " + ui.item.id );
			}
		});
		
		$("body").on("click", ".ui-menu-item-wrapper", function(){
			console.log(autoResArr);
			let restaurantNo = autoResArr.restaurantNo;
			let restaurantName = autoResArr.restaurantName; 
			let restaurantTel = autoResArr.restaurantTel; 
			let restaurantSAddr = autoResArr.restaurantSAddr;
			let restaurantAAddr = autoResArr.restaurantAAddr;
			
			$("#restaurantNo").val(restaurantNo);
			$("#restaurantTel").val(restaurantTel);
			$("#streetAddress").val(restaurantSAddr);
			$("#areaAddress").val(restaurantAAddr);
		});
		
		//==>연령대 무관 클릭시 나머지 연령대 체크 해제
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
		
		//==>연령대 클릭시 나머지 연령대 다 체크하면 해당 체크 해제 연령대 무관 체크
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
		});
		
		//==> 연령대 값에 따라 체크되어있기
		let ageArr = [${chat.chatAge}];
		//console.log(ageArr.length);
		$(ageArr).each(function(index){
			//console.log(index);
			//console.log(ageArr[index]);
			$("input[value="+ageArr[index]+"]").prop("checked", true);
		});
		
		
		//==> 채팅방 노출여부 체크시
		$("input[name='chatShowStatus']").change(function(){
			if($("#chatShowStatus").is(":checked")){
				console.log("체크한거니?");
				$("#chatShowStatus").val(false);
			}else{
				console.log("체크한거니??");
				$("#chatShowStatus").val(true);
			}
		});
		
		//==>취소 클릭시 뒤로 감
		$("input[value='취소']").on("click", function(){
			history.back();
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
						<input type="hidden" name="chatNo" id="chatNo" value="${chat.chatNo }">
							<input type="hidden" name="chatRestaurant.restaurantNo" id="restaurantNo" value="${chat.chatRestaurant.restaurantNo }">
							<input type="hidden" name="chatLeaderId.memberId" id="chatLeaderId" value="hihi@a.com">
							
							<div class="row gtr-uniform">
								<div class="col-md-8">
									<label for="restaurantName">음식점명</label> <input type="text"
										name="restaurantName" id="restaurantName" value="${chat.chatRestaurant.restaurantName }"
										placeholder="" autocomplete="off" required maxlength="50"/> 
										<p class="find-restaurant-txt"></p>	
										
								</div> 
							</div>
							<div class="row gtr-uniform">
								<div class="col-md-4">
									<label for="restaurantTel">음식점 전화번호</label> <input type="text"
										name="restaurantTel" id="restaurantTel" value="${chat.chatRestaurant.restaurantTel }"
										placeholder="" disabled="disabled"/>
								</div>
								
								<div class="col-md-4">
									<label for="streetAddress">음식점 도로명 주소</label> <input type="text"
										name="streetAddress" id="streetAddress" value="${chat.chatRestaurant.streetAddress }"
										placeholder="" disabled="disabled"/>
								</div>
								
								<div class="col-md-4">
									<label for="areaAddress">음식점 지번 주소</label> <input type="text"
										name="areaAddress" id="areaAddress" value="${chat.chatRestaurant.areaAddress }"
										placeholder="" disabled="disabled"/>
								</div>
							</div>
							<div class="row gtr-uniform">
								<div class="col-md-8">
									<label for="chatTitle">채팅방 제목</label> <input type="text"
										name="chatTitle" id="chatTitle" placeholder="" required maxlength="100" value="${chat.chatTitle }"/>
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
										<input type="radio" id="male" name="chatGender" value="1" checked>
										<label for="male">남</label>
								
										<input type="radio" id="female" name="chatGender" value="2">
										<label for="female">여</label>
									
										<input type="radio" id="malefemale" name="chatGender" value="3">
										<label for="malefemale">성별무관</label>
										</c:when>
										
										<c:when test="${chat.chatGender=='2' }">
										<input type="radio" id="male" name="chatGender" value="1">
										<label for="male">남</label>
								
										<input type="radio" id="female" name="chatGender" value="2" checked>
										<label for="female">여</label>
									
										<input type="radio" id="malefemale" name="chatGender" value="3">
										<label for="malefemale">성별무관</label>
										</c:when>
										
										<c:otherwise>
										<input type="radio" id="male" name="chatGender" value="1">
										<label for="male">남자</label>
								
										<input type="radio" id="female" name="chatGender" value="2">
										<label for="female">여자</label>
									
										<input type="radio" id="malefemale" name="chatGender" value="3" checked>
										<label for="malefemale">성별무관</label>
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
									<textarea name="chatText" id="chatText"	placeholder="소개글 입력" rows="6">${chat.chatText }</textarea>
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-12">
									<label for="chatImage">채팅방 대표 이미지</label>
									<input type="file" id="chatImage" name="chatImage" value="${chat.chatImage}"/>
									<c:if test="${chat.chatImage != 'chatchat.jpg' }">
									<p>기본 이미지 :${chat.chatImage }</p>
									<div class="card col-md-4"><img src="/resources/images/uploadImages/chat/${chat.chatImage }"/></div>
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
										<input type="checkbox" id=chatShowStatus name="chatShowStatus" checked>
										</c:when>
										<c:when test="${chat.chatShowStatus==true }">
										<input type="checkbox" id=chatShowStatus name="chatShowStatus">
										</c:when>
									</c:choose>
									<label for="chatShowStatus">채팅방 노출하지 않기</label>
								</div>
							</div>
							<div class="row gtr-uniform">
								<!-- Break -->
								<div class="col-12">
									<ul class="actions justify-content-center">
										<li><input type="submit" value="채팅방 수정" class="primary" /></li>
										<li><input type="reset" value="취소" class="normal" /></li>
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