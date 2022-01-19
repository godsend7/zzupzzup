<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<!DOCTYPE HTML>

<html>
<head>
<title>Review 목록</title>

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
	
	//좋아요 기능 구현 function
	$(function() {
		//하트 모양을 클릭 시 이벤트 발생
		$(".reviewLike").on("click", function() {
			//로그인 및 유저 확인
			if (${member.memberId == null}) {
				alert("로그인이 필요한 서비스입니다.");
				return;
			}
			
			if (${member.memberRole != "user"}) {
				return;
			}
			
			//클릭 한 객체의 class에 check가 있다면 하트 누른 상태이므로 삭제 이벤트 발생
			if ($(this).hasClass("check") === true) {
				//해당 하트를 감싸고 있는 div를 찾은 후 span(좋아요 수)에 등록된 text 찾아 저장
				var likeCount = $(this).closest("div").find("span").text();
				
				//삭제 ajax 실행
				$.ajax({
					url : "/review/json/deleteLike/"+$(this).closest("div").find("input[name='reviewNo']").val(),
					method : "GET",
					context : this, //ajax에서 $(this)를 사용하기 위해서 필요
					success : function(data, status) {
						
						//json/deleteLike에서 return받은 getReview의 data안에 좋아요 수 받아와 text 변경
						$(this).closest("div").find("span").text(data.likeCount);
						//클릭 한 객체의 class를 reviewLike로 변경 (하트 check 여부를 판단)
						$(this).attr('class','reviewLike');
					}
				});	
			} else { //클릭 한 객체의 class에 check가 없다면 하트를 누르지 않은 상태이므로 등록 이벤트 발생
 				
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
		
		$(".search-sort").on("click", function(e){
			var sort = $(this).attr("data-sort");
			console.log(sort);
			
			$("input[name='searchSort']").val(sort);
			
			fncPageNavigation(1,${param.reportCategory});
		});
		
		$("#reportCount").on("change", function(e){
			fncPageNavigation(1);
		});
	});

</script>
</head>

<body class="is-preload">
	<!-- 현재 나의 PATH 가져오기 -->
	<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" /> 
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
						<c:if test = "${fn:contains(path, 'listMyLikeReview')}">
							<h2>내가 좋아요한 Review</h2>
						</c:if>
						<c:if test = "${fn:contains(path, 'listReview')}">
							<h2>${member.memberRole != 'admin' ? "내가 작성한 Review" : "등록된 전체 Review"}</h2>
						</c:if>
						
						<form id="review">
							<!-- 검색 정렬 조건 -->
							<div class="row search-box gtr-uniform">
								<div class="col-md-4 col-sm-12">
									<div class="dropmenu float-left mr-2">
										<a href="" class="button normal icon solid fa-sort dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">정렬</a>
										<div class="dropmenu-list" aria-labelledby="dropmenuList">
											<a class="dropmenu-item search-sort" href="#" data-sort="latest">최신순 </a>
											<a class="dropmenu-item search-sort" href="#" data-sort="oldest">오래된 순</a>
											<c:if test = "${fn:contains(path, 'listReview')}">
												<hr class="dropdown-divider">
												<a class="dropmenu-item search-sort" href="#" data-sort="likeLittlest">좋아요 적은 순</a>
												<a class="dropmenu-item search-sort" href="#" data-sort="likeMuchst">좋아요 많은 순</a>
											</c:if>
											<c:if test='${member.memberRole eq "admin"}'>
												<hr class="dropdown-divider">
												<a class="dropmenu-item search-sort" href="#" data-sort="reportLittlest">신고 적은 순</a>
												<a class="dropmenu-item search-sort" href="#" data-sort="reportMuchst">신고 많은 순</a>
											</c:if>
											<input type="hidden" name="searchSort" value="${search.searchSort}">
										</div>
									</div>
									<c:if test='${member.memberRole eq "admin"}'>
										<div class="dropmenu float-left">
											<a href="" class="button normal icon solid fa-filter dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">필터</a>
											<div class="dropmenu-list" aria-labelledby="dropmenuList">
												<input type="checkbox" id="reportCount" class="search-filter" name="searchFilter" value="1" ${search.searchFilter eq "1" ? "checked" : "" }><label for="reportCount">신고 5회 이상</label>
											</div>
										</div>
									</c:if>
								</div>
							</div>
							
							<input type="hidden" id="currentPage" name="currentPage" value=""/>
						</form>
						
						<div class="row table-list mb-2">
				 		 	<c:forEach var="review" items= "${list}">
		 		 				<div class="col-md-12">
									<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow card h-md-250 position-relative">
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
											<c:if test="${member.memberRole == 'user'}">
												<c:if test="${!review.reviewShowStatus}">
													<div class="review-report-info">
														<span class="badge badge-pill badge-danger">신고로 인해 미노출 된 리뷰입니다</span>
													</div>
												</c:if>
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
											
											<c:if test = "${fn:contains(path, 'listMyLikeReview')}">
												<h3 class="mb-0 getOtherUserModal"  data-toggle="modal" data-target="#getOtherUserModal" data-id="${review.member.memberId}">
											</c:if>
											<c:if test = "${fn:contains(path, 'listReview')}">
												<h3 class="mb-0">
											</c:if>
												<span class="badge badge-pill badge-primary">
													${review.member.memberRank}
												</span>&nbsp; ${review.member.nickname}
											</h3>
											
											<br>
											
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
														<!-- listReview 조회하면서 likeList(좋아요 목록)를 가져와 내가 작성한 리뷰인지 check -->
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