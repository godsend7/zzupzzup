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
	    
	    if (${param.restaurantNo == null}) {
	    	$("#review").attr("action","/review/listReview").attr("method", "POST").submit();
		} else {
			$("#review").attr("action","/review/listReview?restaurantNo=${param.restaurantNo}").attr("method", "POST").submit();
		}
	}
	
	
	$(function() {
		$(".reviewBox").on("click", function() {
			if (${member.memberId == null}) {
				alert("로그인이 필요한 서비스입니다.");
				return;
			}
			
			if (${member.memberRole != "user"}) {
				return;
			}
			
			console.log($(this).find("input[name='reviewNo']").val());
			
			//좋아요 체크한 상태일 경우(좋아요에 색깔이 있을 경우)
			/* if (condition) {
				
			} */
			
			
			var likeCount = $(this).find(".reviewLike");
			console.log(likeCount);
			
			$.ajax({
				url : "/review/json/addLike/"+$(this).find("input[name='reviewNo']").val(),
				method : "GET",
				success : function(data, status) {
					console.log(data);
					console.log(data.likeCount);
					
					$(this).find(".reviewLike").text(data.likeCount);
					
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

				<section id="listReview">
					<div class="container">
						<!-- 내용 들어가는 부분 -->
						
						<!-- start:Form -->
						<h3>리뷰 리스트</h3>
					
						<form id="review">
							<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
							<%-- <input type="hidden" id="restaurantNo" name="restaurantNo" value="${param.restaurantNo}"/> --%>
							<input type="hidden" id="currentPage" name="currentPage" value=""/>
						</form>
						
						<div class="row table-list mb-2">
				 		 	<c:forEach var="review" items= "${list}">
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
												<a href="#reviewModal" class="reviewModal" data-toggle="modal" data-id="${review.reviewNo}">상세보기</a>
												<span style="float: right; margin-right: 0;">작성일  ${review.reviewRegDate}</span>
												<div style="float: right;" class="reviewBox">
													<span class="reviewLike">${review.likeCount}</span>
													<input type="hidden" name="reviewNo" value="${review.reviewNo}">
												</div>												
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