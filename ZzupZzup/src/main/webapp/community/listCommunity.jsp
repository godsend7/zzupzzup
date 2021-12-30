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

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	
	window.onload = function(){
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
			$( "#write" ).on("click" , function() {
				self.location = "/community/addCommunity";
			});
		});
		
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
				
				<section id="">
					<div class="container">
					
						<div class="row">
							<div class="col">
								<h2>나만의 작고 소중한 맛집 리스트</h2>
							</div>
							<div class="col">
								<button type="button" class="btn btn-link btn-sm float-right" id="write">write</button>
							</div>	
						</div><hr>
						
						<div class="row thumb-list">
						
						<c:set var="i" value="0" />
						<c:forEach var="community" items="${list}">
						
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<a href="" class="thumb">
										<img src="/resources/images/uploadImages/default.jpg" height="100%">
									</a>
									<div class="card-body">
										<c:if test="${member.memberRole == 'admin'}">
											<strong class="d-inline-block mb-2 text-primary">신고누적수: ${community.postReportCount}</strong>
										</c:if>
										<p>${community.member.memberId}</p>
										<h3 class="card-title">${community.postTitle}</h3>
										<p class="card-text">${community.postText}</p>
										<div class="d-flex justify-content-between align-items-center">
											<a href="/community/getCommunity?postNo=${community.postNo}" class="button small primary stretched-link">더 보기</a>
											<small class="text-muted">${community.postRegDate}</small>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
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