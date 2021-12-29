<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-listReview</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
 span {
 	white-space:nowrap;
 	margin-right: 20px;
 }
 
 .divBox {
 	 float:left;
 }
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	function fncPageNavigation(currentPage) {
		  /* document.getElementById("currentPage").value = currentPage;
	    document.detailForm.submit(); */
	    console.log(currentPage);
	    $("#currentPage").val(currentPage);
	    $("#review").attr("action","/review/listReview").attr("method", "POST").submit();
	}

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
						<h3>리뷰 리스트</h3>
					
						<form id="review">
							<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
							<input type="hidden" id="currentPage" name="currentPage" value=""/>
						</form>
						
						<div class="row table-list mb-2">
							<c:set var="i" value="0" />
				 		 	<c:forEach var="review" items= "${list}">
				 		 		<c:set var="i" value="${i+1}" />
								<div class="col-md-12">
									<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
										<div class="col p-4 d-flex flex-column position-static divBox">
											<c:if test="${member.memberRole == 'admin'}">
												<strong class="d-inline-block mb-2 text-primary">${review.reportCount}</strong>
											</c:if>
											<div>
												<span class="star_span">평점 ${review.avgScope}</span>
												<span class="star_span">청결해요 ${review.scopeClean}</span>  
												<span class="star_span">맛있어요 ${review.scopeTaste}</span>  
												<span class="star_span">친절해요 ${review.scopeKind}</span>
											</div>
											
											<h3 class="mb-0"><span>${review.member.memberRank}</span> ${review.member.nickname}</h3>
											<p class="card-text mb-auto">${review.reviewDetail}</p>
											<div class="mb-1 text-muted">
												<c:forEach var="hashtag" items="${review.hashTag}">
													<span class='badge badge-pill badge-secondary'>${hashtag.hashTag}</span>
												</c:forEach>
											</div>
											<div>
												<a href="#reviewModal" class="stretched-link" data-toggle="modal" data-id="${review.reviewNo}">상세보기</a>
												<span style="float: right; margin-right: 0;">작성일  ${review.reviewRegDate}</span>
												<span style="float: right;">좋아요 수 : ${review.likeCount}</span>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
							<ul class='icons'> 
								<jsp:include page='/review/getReview.jsp'/>
							</ul>
						</div>
						
						<jsp:include page="../common/pageNavigator.jsp"/>
						무한스크롤 필요
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