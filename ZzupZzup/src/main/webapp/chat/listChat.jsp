<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-ListChat</title>

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
		$("form").attr("method", "POST").attr("action",
				"/chat/listChat").submit();
	}

	$(function() {
		console.log("listChat.jsp");
		
		//============= "검색"  Event  처리 =============
		$(".search-btn").on("click", function() {
			fncGetList(1);
		});
		
		//============= "참여하기" Event 처리 ============
		$("a.button:contains(참여하기)").on("click", function(e) {
			e.preventDefault();
			let url= $(this).attr("href");
			alert(url);
			$.ajax({
				url: url,
				method: "GET",
				dataType: "json",
				headers: {
					"Accept": "application/json",
					"Content-Type": "application/json"
				},
				success: function(JSONData, status){
					var displayValue = 
						""
					alert(
							JSONData.chatNo,JSONData.chatTitle,JSONData.chatImage,JSONData.chatText
						);
				},
				error: function(request, status, error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
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
										<a href="" class="button normal icon solid fa-sort"> 정렬</a> 
										<a href="" class="button normal icon solid fa-filter"> 필터</a>
									</div>
									<div class="col-md-6 col-sm-12 d-flex">
										<select id="searchCondition" name="searchCondition">
											<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>음식점명</option>
											<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>음식점주소</option>
										</select>
										<input
								type="text" id="searchKeyword"
								name="searchKeyword" placeholder="검색어" autocomplete="off"
								value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
										<a href="#" class="button primary icon solid fa-search search-btn"></a>
										
										<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
										<input type="hidden" id="currentPage" name="currentPage" value="" />
									</div>
									<div class="col-md-2 d-flex justify-content-end">
										<a href="" class="button icon solid fa-pencil-square"> 작성하기</a>
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
									<c:set var="i" value="${ i+1 }"/>
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
												<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg">
											</div>
											<div class="card-body">
												<div class="chat-rating-info">
													<c:if test="${chat.chatShowStatus == false }">
													<i class="fa fa-eye-slash" aria-hidden="true"></i> 
													</c:if>
													
													<i class="fa fa-exclamation-triangle" aria-hidden="true"> ${chat.reportCount } 회</i> 
												</div>
												<h4 class="card-title">${chat.chatTitle}</h4>
												<h5 class="card-text mb-2 text-muted">${chat.chatText}</h4>
												<div class="d-flex justify-content-between align-items-end">
													<div>
														<p class="card-text text-right">${chat.chatRestaurant.restaurantName}</p>
														<p class="card-text text-right">${chat.chatRestaurant.streetAddress}</p>
													</div>
													<div class="btn-group">
														<a href="/rating/addRating?chatNo=${chat.chatNo}" class="button small primary">평가하기</a>
														<a href="/chat/json/getChat/${chat.chatNo}" class="button small primary get-chat-btn">참여하기</a>
													</div>
												</div>
											</div>
										</div>
									</div>								
									</c:forEach>		
								</div>
								<!-- E:Thumbnail -->
	
								<div class="col-12 text-center thumb-more">
									<a href="#" class="icon solid fa fa-plus-circle"></a>
								</div>
								
								
								<!-- rest -->
								<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
									<span class="badge badge-success chat-state">모집중</span>
									<input type="hidden" value="chatNo">
									<div class="col p-4 d-flex flex-column position-static">
										<p class="card-text mb-auto">${chat.chatNo}</p>
										<strong class="d-inline-block mb-2 text-primary">${chat.chatTitle }</strong>
										<h3 class="mb-0">개설일: ${chat.chatRegDate }</h3>
										<p class="card-text mb-auto">${chat.chatText}</p>
										<p class="card-text mb-auto">참여 인원수: ${chat.chatMemberCount }</p>
										<p class="card-text mb-auto">참여가능 성별: ${chat.chatGender }</p>
										<p class="card-text mb-auto">참여가능 연령대: ${chat.chatAge }</p>
									</div>
									
									<div class="col p-4 d-flex flex-column position-static">
										${chat.chatLeaderId.profileImage} ${chat.chatLeaderId.nickname } ${chat.chatLeaderId.gender } ${chat.chatLeaderId.age } ${chat.chatMember.chatLeaderCheck }
									</div>
									
									<div>
										${chat.chatRestaurant.restaurantName } ${chat.chatRestaurant.menuType } ${chat.chatRestaurant.streetAddress } ${chat.chatRestaurant.areaAddress }
									</div>
										
									<a href="#" class="stretched-link">Continue reading</a>
								</div>
								<!-- //rest -->

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