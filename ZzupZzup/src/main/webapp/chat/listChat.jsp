<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-채팅방 목록</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/chat.css" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/chat/listChat")
				.submit();
	}

	$(function() {
		console.log("listChat.jsp");

		//============= "검색"  Event  처리 =============
		$(".search-btn").on("click", function() {
			fncGetList(1);
		});
		
		//============= "검색"  Event  처리 =============		
		$("a.button:contains(작성하기)").on("click", function(e) {
			e.preventDefault();
			window.open("/chat/addChat", "_self");
		});

		//============= "참여하기" Event 처리 ============
		$("a.button:contains(참여하기)").on("click", function(e) {
			e.preventDefault();
			let url = $(this).attr("href");
			$.ajax({
				url : url,
				method : "GET",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status) {
					let chatImg = JSONData.chatImage;
					let chatState = JSONData.chatState;
					let chatRegDate = JSONData.chatRegDate;
					let regdate = new Date(chatRegDate);
					chatRegDate = regdate.getFullYear()+"-"+(regdate.getMonth()+1)+"-"+regdate.getDate();
					if(chatState == 1){
						chatState = "<span class='badge badge-success chat-state'>모집중</span>";
					}else if(chatState == 2){
						chatState = "<span class='badge badge-warning chat-state'>인원확정</span>";
					}else if(chatState == 3){
						chatState = "<span class='badge badge-info chat-state'>예약확정</span>";
					}else if(chatState == 4){
						chatState = "<span class='badge badge-danger chat-state'>모임완료</span>";
					}
					let displayValueBd = 
						"<ul class='data-list'>"
						+"<li>"+chatState+"</li>"
						+"<li><span class='badge badge-secondary chat-no'>"+JSONData.chatNo+"</span></li>"
						+"<li>채팅방 제목 : "+JSONData.chatTitle+"</li>"
						+"<li>개설일 : "+chatRegDate+"</li>"
						+"<li>"+JSONData.chatText+"</li>"
						+"<li>참가인원수 : "+JSONData.chatMemberCount+"</li>"
						+"<li>참가가능성별 : "+JSONData.chatGender+"</li>"
						+"<li>참가가능연령대 : "+JSONData.chatAge+"</li>"
						+"<li>"+JSONData.chatLeaderId.profileImage+"</li>"
						+"<li>"+JSONData.chatLeaderId.nickname+"</li>"
						+"<li>"+JSONData.chatLeaderId.gender+"</li>"
						+"<li>"+JSONData.chatLeaderId.age+"</li>"
						+"<li> 상태메세지 : "+JSONData.chatLeaderId.statusMessage+"</li>"
						+"<li> 노출여부 : "+JSONData.chatShowStatus+"</li>"
						+"<li> 신고횟수 : "+JSONData.reportCount+"</li>"
						+"<li>"+JSONData.chatRestaurant.restaurantName+"</li>"
						+"<li>음식점 타입 : "+JSONData.chatRestaurant.menuType+"</li>"
						+"<li>"+JSONData.chatRestaurant.streetAddress+"</li>"
						+"<li>"+JSONData.chatRestaurant.areaAddress+"</li>"
						+"<li>"+JSONData.chatRestaurant.restaurantTel+"</li>"
						+ "</ul>";
					let displayValueFt = "<input type='button' data-target="+JSONData.chatNo+" class='button small warning' value='대화기록보기'/>"
					+"<input type='button' data-target="+JSONData.chatNo+" class='button small info' value='수정하기'/>"
					+"<input type='button' class='button small secondary' data-dismiss='modal' value='닫기' />"
					+"<input type='button' data-target="+JSONData.chatNo+" class='button small primary' value='입장하기'>"
					$(".modal-body").html(displayValueBd);
					$(".modal-footer").html(displayValueFt);
					if(chatImg == 'chatimg.jpg'){
						$(".modal-body").css("background-image", "url(/resources/images/sub/"+chatImg+")");
					}else{
						$(".modal-body").css("background-image", "url(/resources/images/uploadImages/chat/"+chatImg+")");
					}
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:"
							+ error);
				}
			});
		});
		
		//============= "대화기록보기" Event 처리 ============
		$("body").on("click", "input[value='대화기록보기']", function(){
			console.log("대화기록보기");
			
		});
			
		//============= "수정하기" Event 처리 ============
		$("body").on("click", "input[value='수정하기']", function(){
			console.log("수정하기");
			let chatNo = $(this).attr("data-target");
			location.href="/chat/updateChat?chatNo="+chatNo;
		});
				
		//============= "입장하기" Event 처리 ============
		$("body").on("click", "input[value='입장하기']", function(){
			console.log("입장하기");
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

				<section id="listChat" class="chatting">

					<div class="container">

						<h3>쩝쩝친구 구하기</h3>

						<!-- S:Search -->
						<form class="form-inline" name="detailForm">
							<div class="container">
								<div class="row search-box gtr-uniform">
									<div class="col-md-4 col-sm-12">
										<a href="" class="button normal icon solid fa-sort"> 정렬</a> <a
											href="" class="button normal icon solid fa-filter"> 필터</a>
									</div>
									<div class="col-md-6 col-sm-12 d-flex">
										<select id="searchCondition" name="searchCondition">
											<option value="0"
												${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>음식점명</option>
											<option value="1"
												${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>음식점주소</option>
										</select> <input type="text" id="searchKeyword" name="searchKeyword"
											placeholder="검색어" autocomplete="off"
											value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
										<a href="#"
											class="button primary icon solid fa-search search-btn"></a>

										<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
										<input type="hidden" id="currentPage" name="currentPage"
											value="" />
									</div>
									<div class="col-md-2 d-flex justify-content-end">
										<a href="" class="button icon solid fa-pencil-square" >
											작성하기</a>
									</div>
								</div>
							</div>
						</form>
						<!-- E:Search -->

						<!-- S:Thumbnail -->
						<div class="container">
							<div class="row thumb-list">

								<c:set var="i" value="0" />
								<c:forEach var="chat" items="${list}">
									<c:set var="i" value="${ i+1 }" />
									<div class="col-md-6">
										<div class="card mb-4 shadow-sm">
											<div class="card-head">
												<span class="badge badge-secondary chat-no">${chat.chatNo }</span>
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
														<span class="badge badge-danger chat-state">모임완료</span>
													</c:when>
												</c:choose>
											</div>
											<div class="card-img">
												<img
													src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg">
											</div>
											<div class="card-body">
												<div class="chat-rating-info">
													<c:if test="${chat.chatShowStatus == false }">
														<i class="fa fa-eye-slash" aria-hidden="true"></i>
													</c:if>

													<i class="fa fa-exclamation-triangle" aria-hidden="true">
														${chat.reportCount } 회</i>
												</div>
												<h4 class="card-title">${chat.chatTitle}</h4>
												<h5 class="card-text mb-2 text-muted">${chat.chatText}</h4>
													<div class="d-flex justify-content-between align-items-end">
														<div>
															<p class="card-text text-right">${chat.chatRestaurant.restaurantName}</p>
															<p class="card-text text-right">${chat.chatRestaurant.streetAddress}</p>
														</div>
														<div class="btn-group">
															<a href="/rating/addRating?chatNo=${chat.chatNo}"
																class="button small primary">평가하기</a> <a
																href="/chat/json/getChat/${chat.chatNo}"
																class="button small primary get-chat-btn" data-toggle="modal" data-target="#getChatModal">참여하기</a>
														</div>
													</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
							<!-- E:Thumbnail -->

							<!-- S:Infinity page -->
							<div class="col-12 text-center thumb-more">
								<a href="#" class="icon solid fa fa-plus-circle"></a>
							</div>
							<!-- E:Infinity page -->

							<!-- S:Modal -->
							<div class="modal fade" id="getChatModal" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">채팅방 정보 상세보기</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body"></div>
										<div class="modal-footer">
											
										</div>
									</div>
								</div>
							</div>
							<!-- E:Modal -->
							
						</div>
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