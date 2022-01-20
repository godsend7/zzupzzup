<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" href="/resources/css/review.css" />


<c:if test="${empty list}">
<h3>아직 등록된 리뷰가 없습니다.</h3>
</c:if>
<c:if test="${!empty list}">
<br><br>
<div class="row table-list mb-2 review-top-box">
	<div class="reviewTitle">
		<div><h2 style="margin-bottom: 0px;">Review Total (${totalCount})</h2></div>
		<div class="star-in">
		<c:forEach var="i" begin="1" end="${avgTotalScope+((avgTotalScope%1>0.5)?(1-(avgTotalScope%1))%1:-(avgTotalScope%1))}">
			<span class="star-modal on"></span>
		</c:forEach>
		</div>
		<div style="margin-top: 10px; float: left;">
			<span>(${avgTotalScope} 점)</span>
		</div>
	</div>
	
	<c:if test="${member.memberRole eq 'user'}">
		<div>
			<a href="/reservation/listReservation?memberId=${member.memberId}" class="button svg-btn">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
					 <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
					 <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
			</svg>작성하기
			</a>
		</div>
	</c:if>
</div>

<br>

<form id="review">
	<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
	<%-- <input type="hidden" id="restaurantNo" name="restaurantNo" value="${param.restaurantNo}"/> --%>
	<c:if test='${!empty member}'>
		<div class="row search-box gtr-uniform">
			<div class="col-md-4 col-sm-12">
				<div class="dropmenu float-left mr-2">
					<a href="" class="button normal icon solid fa-sort dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">정렬</a>
					<div class="dropmenu-list" aria-labelledby="dropmenuList">
						<a class="dropmenu-item search-sort" href="#" data-sort="latest">최신순 </a>
						<a class="dropmenu-item search-sort" href="#" data-sort="oldest">오래된 순</a>
						<hr class="dropdown-divider">
						<a class="dropmenu-item search-sort" href="#" data-sort="likeLittlest">좋아요 적은 순</a>
						<a class="dropmenu-item search-sort" href="#" data-sort="likeMuchst">좋아요 많은 순</a>
						<hr class="dropdown-divider">
						<a class="dropmenu-item search-sort" href="#" data-sort="avgLittlest">평점 낮은 순</a>
						<a class="dropmenu-item search-sort" href="#" data-sort="avgMuchst">평점 높은 순</a>
						<input type="hidden" name="searchSort" value="${search.searchSort}">
					</div>
				</div>
				
				<%-- <div class="dropmenu float-left">
					<a href="" class="button normal icon solid fa-filter dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">필터</a>
					<div class="dropmenu-list" aria-labelledby="dropmenuList">
						<input type="checkbox" id="hashtag1" class="search-filter" name="searchFilter" value="1" ${search.searchFilter eq "1" ? "checked" : "" }><label for="hashtag1">인스타 맛집</label>
						<input type="checkbox" id="hashtag2" class="search-filter" name="searchFilter" value="2" ${search.searchFilter eq "2" ? "checked" : "" }><label for="hashtag2">여성이 많이 찾는 맛집</label>
						<input type="checkbox" id="hashtag3" class="search-filter" name="searchFilter" value="3" ${search.searchFilter eq "3" ? "checked" : "" }><label for="hashtag3">남성이 많이 찾는 맛집</label>
						<input type="checkbox" id="hashtag4" class="search-filter" name="searchFilter" value="4" ${search.searchFilter eq "4" ? "checked" : "" }><label for="hashtag4">자녀와 함께하기 좋은 맛집</label>
						<input type="checkbox" id="hashtag5" class="search-filter" name="searchFilter" value="5" ${search.searchFilter eq "5" ? "checked" : "" }><label for="hashtag5">부모님과 함께하기 좋은 맛집</label>
						<input type="checkbox" id="hashtag6" class="search-filter" name="searchFilter" value="6" ${search.searchFilter eq "6" ? "checked" : "" }><label for="hashtag6">반려견과 함께하기 좋은 맛집</label>
						<input type="checkbox" id="hashtag7" class="search-filter" name="searchFilter" value="7" ${search.searchFilter eq "7" ? "checked" : "" }><label for="hashtag7">가성비 좋은 맛집</label>
						<input type="checkbox" id="hashtag8" class="search-filter" name="searchFilter" value="8" ${search.searchFilter eq "8" ? "checked" : "" }><label for="hashtag8">데이트하기 좋은 맛집</label>
					</div>
				</div> --%>
			</div>
		</div>
	</c:if>
	<input type="hidden" id="currentPage" name="currentPage" value=""/>
</form>

<div class="row table-list mb-2 reviewListBox">
	<c:choose>
		<c:when test="${!empty member}">
			<c:forEach var="review" items= "${list}">
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
							
							<h3 class="mb-0 getOtherUserModal"  data-toggle="modal" data-target="#getOtherUserModal" data-id="${review.member.memberId}">
								<span class="badge badge-pill badge-primary">
									${review.member.memberRank}
								</span>&nbsp; ${review.member.nickname}
							</h3>
							
							<p class="card-text mb-auto reviewDetail">${review.reviewDetail}</p>
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
			</c:forEach>
			<ul class='icons'> 
				<jsp:include page='/review/getReview.jsp'/>
			</ul> 
		</c:when>
		<c:otherwise>
			<div class="col-md-12">
				<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
					<div class="col p-4 d-flex flex-column position-static divBox">
						<div class="row listStarBox">
							<label for="scopeAvg" class="label listLabel">평점</label>
							<div class="star-in">
								<fmt:parseNumber var="star" value="${list[0].avgScope}" integerOnly="true"/>
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
								<fmt:parseNumber var="star" value="${list[0].scopeClean}" integerOnly="true"/>
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
								<fmt:parseNumber var="star" value="${list[0].scopeTaste}" integerOnly="true"/>
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
								<fmt:parseNumber var="star" value="${list[0].scopeKind}" integerOnly="true"/>
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
								${list[0].member.memberRank}
							</span>&nbsp; ${list[0].member.nickname}
						</h3>
						
						<p class="card-text mb-auto reviewDetail">${list[0].reviewDetail}</p>
						<div class="mb-1 text-muted">
							<c:forEach var="hashtag" items="${list[0].hashTag}">
								<span class='badge badge-pill badge-secondary'>${hashtag.hashTag}</span>
							</c:forEach>
						</div>
						<br>
						
						<div class="review-info-bottom">
							<a href="#reviewModal" class="reviewModal" data-toggle="modal" data-id="${list[0].reviewNo}">상세보기</a> 
							<div class="review-info-bottom-right">
								<div class="likeBox">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill reviewLike" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>			
									<span class="reviewCount">${list[0].likeCount}</span>
									<input type="hidden" name="reviewNo" value="${list[0].reviewNo}">
								</div>
								<span>작성일&nbsp;&nbsp;${list[0].reviewRegDate}</span>													
							</div>		
						</div>										
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>
</c:if>




