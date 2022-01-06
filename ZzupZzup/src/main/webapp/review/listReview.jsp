<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/review.css" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
.review-top-box {
	display: flex;
	justify-content: space-between;
}

label {
	margin: 0px;
	
}

.listStarBox .star-in {
	padding-left: 10px;
	padding-top: 3px;
}

.reviewTitle h2 {
	margin-right: 15px;
	float: left;
}

.reviewTitle .star-in {
	padding-top: 6px;
}

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	function fncPageNavigation(currentPage) {
		  /* document.getElementById("currentPage").value = currentPage;
	    document.detailForm.submit(); */
	    console.log(currentPage);
	    $("#currentPage").val(currentPage);
	    
	    if (${param.restaurantNo == null}) {
	    	$("#review").attr("action","/review/listReview").attr("method", "POST").submit();
		} else {
			$("#review").attr("action","/review/listReview?restaurantNo=${param.restaurantNo}").attr("method", "POST").submit();
		}
	}
	
	
	
	$(function() {
		
		$(".reviewLike").on("click", function() {
			if (${member.memberId == null}) {
				alert("로그인이 필요한 서비스입니다.");
				return;
			}
			
			if (${member.memberRole != "user"}) {
				return;
			}
			
			if ($(this).hasClass("check") === true) {
				var likeCount = $(this).closest("div").find("span").text();
				
				$.ajax({
					url : "/review/json/deleteLike/"+$(this).closest("div").find("input[name='reviewNo']").val(),
					method : "GET",
					context : this,
					success : function(data, status) {
						
						$(this).closest("div").find("span").text(data.likeCount);
						$(this).attr('class','reviewLike');
					}
				});	
			} else {
				var likeCount = $(this).closest("div").find("span").text();
				
				$.ajax({
					url : "/review/json/addLike/"+$(this).closest("div").find("input[name='reviewNo']").val(),
					method : "GET",
					context : this, //ajax에서 $(this)를 사용하기 위해서 필요
					success : function(data, status) {
						
						$(this).closest("div").find("span").text(data.likeCount);
						$(this).attr('class','reviewLike check'); 
					}
				});
			}
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

				<section id="listReview">
					<div class="container">
						<!-- 내용 들어가는 부분 -->
						
						<!-- start:Form -->
						<c:choose>
							<c:when test="${empty param.restaurantNo}">
								<h2>Review List</h2>
							</c:when>
							<c:otherwise>
								<div class="row table-list mb-2 review-top-box">
									<div class="reviewTitle">
										<h2>Review Total</h2>
										<div class="star-in">
											<fmt:parseNumber var="star" value="${avgTotalScope}" integerOnly="true"/>
											<c:forEach var="i" begin="1" end="${star}">
												<span class="star-modal on"></span>
											</c:forEach>
										</div>
										<div>
											<span>(${avgTotalScope} 점)</span>
										</div>
									</div>
									
									<div>
										<c:if test="${member.memberRole eq 'user'}">
											<a href="/reservation/listReservation?memberId=${member.memberId}" class="button svg-btn">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
	 											 <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
	 											 <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
											</svg>작성하기
											</a>
										</c:if>
									</div>
									
									
								</div>
								<div class="row table-list mb-2" style="margin-left: 0px;">
									
									<a href="" class="button normal icon solid fa-filter"> 필터</a></div>
								<br>
							</c:otherwise>
						</c:choose>
						
						
						<form id="review">
							<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
							<%-- <input type="hidden" id="restaurantNo" name="restaurantNo" value="${param.restaurantNo}"/> --%>
							<input type="hidden" id="currentPage" name="currentPage" value=""/>
						</form>
						
						<div class="row table-list mb-2">
				 		 	<c:forEach var="review" items= "${list}">
				 		 		<c:choose>
				 		 			<c:when test="${member.memberRole != 'admin' && !review.reviewShowStatus}">
				 		 			</c:when>
				 		 			<c:otherwise>
				 		 				<div class="col-md-12">
											<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
												<div class="col p-4 d-flex flex-column position-static divBox">
													<c:if test="${member.memberRole == 'admin'}">
														<div class="review-report-info">
															<c:if test="${!review.reviewShowStatus}">
																<i class="fa fa-eye-slash" aria-hidden="true"></i>
															</c:if>
															<i class="fa fa-exclamation-triangle" aria-hidden="true">
																${review.reportCount} 회
															</i>
														</div>
													</c:if>
													<div class="row listStarBox">
														<label for="scopeAvg" class="label listLabel">평점</label>
														<div class="star-in">
															<fmt:parseNumber var="star" value="${review.avgScope}" integerOnly="true"/>
															<c:set var="notStar" value="${5 - star}"/>
															<c:forEach var="i" begin="1" end="${star}">
																<span class="star-small on"></span>
															</c:forEach>
															
															<c:forEach var="i" begin="1" end="${notStar}">
																<span class="star-small"></span>
															</c:forEach>
														</div>
														
														<label for="scopeClean" class="label">청결해요</label>
														<div class="star-in">
															<fmt:parseNumber var="star" value="${review.scopeClean}" integerOnly="true"/>
															<c:set var="notStar" value="${5 - star}"/>
															<c:forEach var="i" begin="1" end="${star}">
																<span class="star-small on"></span>
															</c:forEach>
															
															<c:forEach var="i" begin="1" end="${notStar}">
																<span class="star-small"></span>
															</c:forEach>
														</div>
														
														<label for="scopeTaste" class="label">맛있어요</label>
														<div class="star-in">
															<fmt:parseNumber var="star" value="${review.scopeTaste}" integerOnly="true"/>
															<c:set var="notStar" value="${5 - star}"/>
															<c:forEach var="i" begin="1" end="${star}">
																<span class="star-small on"></span>
															</c:forEach>
															
															<c:forEach var="i" begin="1" end="${notStar}">
																<span class="star-small"></span>
															</c:forEach>
														</div>
														
														<label for="scopeKind" class="label">친절해요</label>
														<div class="star-in">
															<fmt:parseNumber var="star" value="${review.scopeKind}" integerOnly="true"/>
															<c:set var="notStar" value="${5 - star}"/>
															<c:forEach var="i" begin="1" end="${star}">
																<span class="star-small on"></span>
															</c:forEach>
															
															<c:forEach var="i" begin="1" end="${notStar}">
																<span class="star-small"></span>
															</c:forEach>
														</div>
													</div>
													
													<h3 class="mb-0">
														<span class="badge badge-pill badge-primary">
															${review.member.memberRank}
														</span>&nbsp; ${review.member.nickname}
													</h3>
													
													<p class="card-text mb-auto">${review.reviewDetail}</p>
													<div class="mb-1 text-muted">
														<c:forEach var="hashtag" items="${review.hashTag}">
															<span class='badge badge-pill badge-secondary'>${hashtag.hashTag}</span>
														</c:forEach>
													</div>
													<br>
													
													<div class="review-info-bottom">
														<a href="#reviewModal" class="reviewModal" data-toggle="modal" data-id="${review.reviewNo}">상세보기</a>
														<div class="review-info-bottom-right">
															<div class="likeBox">
																<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill reviewLike <c:forEach var="like" items="${listLike}">${(review.reviewNo == like.reviewNo && !empty member && member.memberId == like.memberId )? ' check' : ''}</c:forEach>" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>			
																<span class="reviewCount">${review.likeCount}</span>
																<input type="hidden" name="reviewNo" value="${review.reviewNo}">
															</div>
															<span>작성일&nbsp;&nbsp;${review.reviewRegDate}</span>													
														</div>		
													</div>										
												</div>
											</div>
										</div>
				 		 			</c:otherwise>
				 		 		</c:choose>
							</c:forEach>
							<ul class='icons'> 
								<jsp:include page='/review/getReview.jsp'/>
							</ul>
						</div>
						
						<c:choose>
							<c:when test="${empty param.restaurantNo}">
								<jsp:include page="../common/pageNavigator.jsp"/>
							</c:when>
							<c:otherwise>
								무한스크롤 필요
								<jsp:include page="../common/pageNavigator.jsp"/>
							</c:otherwise>
						</c:choose>
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