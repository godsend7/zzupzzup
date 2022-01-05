<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-LISTCOMMUNITY</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
.restaurant-menu-text {
	position: relative;
	text-overflow: ellipsis;
	overflow: hidden;
	height: 25px;
	padding-right: 10px;
}

.restaurant-menu-text:after {
	content: '...';
	position: absolute;
	top: 0;
	right: 0;
}
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	// 상세조회 버튼 실행
	/* $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "#postinfo" ).on("click" , function() {
			self.location = "/community/getCommunity?postNo=${community.postNo}";
		});
	}); */

	// 게시물 작성하기 버튼 실행
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("#write").on("click", function() {
			self.location = "/community/addCommunity";
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

				<section id="">
					<div class="container">

						<div class="row">
							<div class="col">
								<h2>나만의 작고 소중한 맛집 리스트</h2>
							</div>
							<div class="col">
								<!-- <button type="button" class="btn btn-link btn-sm float-right" id="write">write</button> -->
								<a href="#" id="write" class="button svg-btn btn-sm float-right"><svg
										xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-pencil-square"
										viewBox="0 0 16 16">
  								<path
											d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 								0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
  								<path fill-rule="evenodd"
											d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 								1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z" />
								</svg>작성하기</a>
							</div>
						</div>
						<hr>
						<div class="container">
							<div class="row thumb-list">

								<c:set var="i" value="0" />
								<c:forEach var="community" items="${list}">

									<div class="col-md-4">
										<div class="card mb-1 shadow-sm">
											<a href="" class="thumb"> <c:if
													test="${community.postImage[0] == null}">
													<img src="/resources/images/uploadImages/default.jpg"
														height="100%">
												</c:if> <c:if test="${community.postImage[0] != null}">
													<img
														src="/resources/images/uploadImages/${community.postImage[0]}"
														height="100%">
												</c:if>
											</a>
											<div class="card-body">
												<c:if test="${member.memberRole == 'admin'}">
													<strong class="d-inline-block mb-2 text-primary">신고누적수:
														${community.postReportCount}</strong>
												</c:if>
												<h3 class="card-title">${community.postTitle}</h3>
												<p>
													<strong>작성자:</strong> ${community.member.nickname}
												</p>
												<p class="card-text restaurant-menu-text">${community.postText}</p>
												<div
													class="d-flex justify-content-between align-items-center">
													<a
														href="/community/getCommunity?postNo=${community.postNo}"
														class="button small primary stretched-link">더 보기</a> <small
														class="text-muted">${community.postRegDate}</small>
												</div>
											</div>
										</div>

										<button type="button"
											class="btn btn-outline-danger btn-sm btn-block">
											<svg xmlns="http://www.w3.org/2000/svg" width="16"
												height="16" fill="currentColor" class="bi bi-heart-fill"
												viewBox="0 0 16 16">
		  										<path fill-rule="evenodd"
													d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z" />
											</svg>
											${community.likeCount}
										</button>
										<br> <br>

									</div>
								</c:forEach>
							</div>
						</div>
					</div>
					<br> <br>

					<!-- <h3 style="text-align:center;">▽ 스크롤하여 더 많은 리스트 보기</h3> -->
					<div class="d-flex justify-content-center">
						<div class="spinner-border" role="status">
							<span class="sr-only">Loading...</span>
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