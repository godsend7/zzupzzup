<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-listMy</title>

<jsp:include page="/layout/toolbar.jsp" />
<link rel="stylesheet" href="/resources/css/review.css" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	function fncPageNavigation(currentPage) {
		  /* document.getElementById("currentPage").value = currentPage;
	    document.detailForm.submit(); */
	    console.log(currentPage);
	    $("#currentPage").val(currentPage);
	    
	    var link = window.location.href;
	    console.log(link);
	    
	    if (link.includes('listReview')) {
	    	$("#review").attr("action","/review/listReview").attr("method", "POST").submit();
		} else if(link.includes('listMyLikeReview')) {
			$("#review").attr("action","/review/listMyLikeReview").attr("method", "POST").submit();
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
						<h2>Review List</h2>
						
						<form id="review">
							<!-- 검색 정렬 조건 -->
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
							
						</div>
						<ul class='icons'> 
							<jsp:include page='/review/getReview.jsp'/>
						</ul>
						<jsp:include page="../common/pageNavigator.jsp"/>
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