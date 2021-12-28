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

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	function fncPageNavigation(currentPage) {
		  /* document.getElementById("currentPage").value = currentPage;
	    document.detailForm.submit(); */
	    console.log(currentPage);
	    $("#currentPage").val(currentPage);
	    $("#listReview").attr("action","/review/listReview").attr("method", "POST").submit();
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

				<section id="review">
					<div class="container">
						<!-- 내용 들어가는 부분 -->
						
						<!-- start:Form -->
						<h3>리뷰 리스트</h3>
					
						<form id="listReview">
							<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
							<input type="hidden" id="currentPage" name="currentPage" value=""/>
						</form>
						
						<div class="row table-list mb-2">
							<c:set var="i" value="0" />
				 		 	<c:forEach var="review" items= "${list}">
				 		 		<c:set var="i" value="${ i+1 }" />
								<div class="col-md-12">
									<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
										<div class="col p-4 d-flex flex-column position-static">
											<c:if test="${member.memberRole == 'admin'}">
												<strong class="d-inline-block mb-2 text-primary">${review.reportCount}</strong>
											</c:if>
											
											<h3 class="mb-0">Featured post</h3>
											<div class="mb-1 text-muted">Nov 12</div>
											<p class="card-text mb-auto">This is a wider card with
												supporting text below as a natural lead-in to additional
												content.</p>
											<a href="#" class="stretched-link">Continue reading</a>
										</div>
									</div>
								</div>
							</c:forEach>
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