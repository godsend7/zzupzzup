<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-template</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/chat.css" />
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	//검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용
	function fncPageNavigation(currentPage) {
		console.log(currentPage);
		$("#currentPage").val(currentPage);
	   	$("#ratingForm").attr("method", "POST").attr("action", "/rating/listMyRating").submit();
	}
	
	$(function() {
		console.log("listMyRatig.jsp");
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

				<section id="listMyRating">
					<div class="container">
					
						<h2>나의 평가 내역</h2>
						
						<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						<form id="ratingForm" name="ratingForm">
						<%-- 전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage}  페이지 --%>
							<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}"/>
						</form>
						<!-- start:Table -->
						<c:forEach var="rating" items="${list}">
						<div class="row table-list mb-2">
							<div class="col-md-12">
								<div
									class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
									<div class="col p-4 d-flex flex-column position-static">
										<h3 class=""><a href="#" class="getOtherUserModal" data-toggle="modal" data-target="#getOtherUserModal" data-id="${rating.ratingToId.memberId}">${rating.ratingToId.nickname}</a> <c:if test="${member.memberRole == 'admin'}"><small>(${rating.ratingToId.memberRank} / 매너점수 : ${rating.ratingToId.mannerAllScore}점)</small></c:if></h3>
										<p class="card-text mb-auto"><a href="/chat/json/getChat/${rating.chatNo}" data-toggle="modal" data-target="#getChatModal" id="getChatEntranceBtn">채팅방 정보</a><br/>평가 내용: <c:choose><c:when test="${rating.ratingType==1}">별로에요(-1점)</c:when><c:when test="${rating.ratingType==2}">좋아요(1점)</c:when><c:when test="${rating.ratingType==3}">최고에요(3점)</c:when></c:choose></p>
										<div class="text-right">
											<strong class="d-inline-block mr-2"><a href="#" class="getOtherUserModal" data-toggle="modal" data-target="#getOtherUserModal" data-id="${rating.ratingFromId.memberId}">${rating.ratingFromId.nickname}</a> <c:if test="${member.memberRole == 'admin'}"><small>(${rating.ratingFromId.memberRank} / 매너점수 : ${rating.ratingFromId.mannerAllScore}점)</small></c:if></strong><small>${rating.ratingRegDate}</small>
										</div>
									</div>

								</div>
							</div>
						</div>
						</c:forEach>
						<!-- end -->


						<!-- PageNavigation Start... -->
						<jsp:include page="../common/pageNavigator.jsp"/>
						<!-- PageNavigation End... -->
						
						<!-- S:Modal -->
						<!-- 채팅방 정보보기 모달 -->
						<jsp:include page='/chat/getChatModal.jsp'/>
						<!-- E:Modal -->

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