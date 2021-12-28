<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-template</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		console.log("template.jsp");
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

				<!-- start:해당 부분은 지우고 아래 container안에 작성 -->
				<div class="row">
					<div class="col-12">
						<ul style="display: flex; list-style: none;">
							<li><a href="/ui-template/basic-template.jsp">기본 템플릿</a></li>
							<li><a href="/ui-template/button.jsp">버튼</a></li>
							<li><a href="/ui-template/form.jsp">등록양식</a></li>
							<li><a href="/ui-template/form-view.jsp">등록양식 결과</a></li>
							<li><a href="/ui-template/thumbnail.jsp">썸네일리스트</a></li>
							<li><a href="/ui-template/list.jsp">일반리스트</a></li>
							<li><a href="/ui-template/carousel.jsp">슬라이드</a></li>
							<li><a href="/ui-template/table.jsp">테이블</a></li>
							<li><a href="/ui-template/etc-ui.jsp">기타ui</a></li>
						</ul>
					</div>
				</div>
				<!-- end -->

				<section id="">
					<div class="container">

						<!-- start:Thumbnail -->
						<div class="row thumb-list">
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<a href="" class="thumb"><img
										src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"
										alt="플래터, 음식, 선발, 식사, 잔치, 다 이닝 테이블, 테이블, 먹다, 맛있는 음식, 식당, 요리"></a>

									<div class="card-body">
										<h4 class="card-title">Card with stretched links</h4>
										<p class="card-text">This is a wider card with supporting
											text below as a natural lead-in to additional content. This
											content is a little bit longer.</p>
										<div class="d-flex justify-content-between align-items-center">
											<a href="#" class="button small primary stretched-link">Go
												somewhere</a> <small class="text-muted">9 mins</small>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<a href="" class="thumb"><img
										src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"
										alt="플래터, 음식, 선발, 식사, 잔치, 다 이닝 테이블, 테이블, 먹다, 맛있는 음식, 식당, 요리"></a>

									<div class="card-body">
										<h4 class="card-title">Card with stretched links</h4>
										<p class="card-text">This is a wider card with supporting
											text below as a natural lead-in to additional content. This
											content is a little bit longer.</p>
										<div class="d-flex justify-content-between align-items-center">
											<a href="#" class="button small primary stretched-link">Go
												somewhere</a> <small class="text-muted">9 mins</small>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<a href="" class="thumb"><img
										src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"
										alt="플래터, 음식, 선발, 식사, 잔치, 다 이닝 테이블, 테이블, 먹다, 맛있는 음식, 식당, 요리"></a>

									<div class="card-body">
										<h4 class="card-title">Card with stretched links</h4>
										<p class="card-text">This is a wider card with supporting
											text below as a natural lead-in to additional content. This
											content is a little bit longer.</p>
										<div class="d-flex justify-content-between align-items-center">
											<a href="#" class="button small primary stretched-link">Go
												somewhere</a> <small class="text-muted">9 mins</small>
										</div>
									</div>
								</div>
							</div>

							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<a href="" class="thumb"><img
										src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"
										alt="플래터, 음식, 선발, 식사, 잔치, 다 이닝 테이블, 테이블, 먹다, 맛있는 음식, 식당, 요리"></a>

									<div class="card-body">
										<p class="card-text">This is a wider card with supporting
											text below as a natural lead-in to additional content. This
											content is a little bit longer.</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="btn-group">
												<button type="button" class="btn small normal">View</button>
												<button type="button" class="btn small normal">Edit</button>
											</div>
											<small class="text-muted">9 mins</small>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<a href="" class="thumb"><img
										src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"
										alt="플래터, 음식, 선발, 식사, 잔치, 다 이닝 테이블, 테이블, 먹다, 맛있는 음식, 식당, 요리"></a>

									<div class="card-body">
										<p class="card-text">This is a wider card with supporting
											text below as a natural lead-in to additional content. This
											content is a little bit longer.</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="btn-group">
												<button type="button" class="btn small normal">View</button>
												<button type="button" class="btn small normal">Edit</button>
											</div>
											<small class="text-muted">9 mins</small>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<a href="" class="thumb"><img
										src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"
										alt="플래터, 음식, 선발, 식사, 잔치, 다 이닝 테이블, 테이블, 먹다, 맛있는 음식, 식당, 요리"></a>

									<div class="card-body">
										<p class="card-text">This is a wider card with supporting
											text below as a natural lead-in to additional content. This
											content is a little bit longer.</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="btn-group">
												<button type="button" class="btn small normal">View</button>
												<button type="button" class="btn small normal">Edit</button>
											</div>
											<small class="text-muted">9 mins</small>
										</div>
									</div>
								</div>
							</div>

							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<a href="" class="thumb"><img
										src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"
										alt="플래터, 음식, 선발, 식사, 잔치, 다 이닝 테이블, 테이블, 먹다, 맛있는 음식, 식당, 요리"></a>

									<div class="card-body">
										<p class="card-text">This is a wider card with supporting
											text below as a natural lead-in to additional content. This
											content is a little bit longer.</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="btn-group">
												<button type="button" class="btn small normal">View</button>
												<button type="button" class="btn small normal">Edit</button>
											</div>
											<small class="text-muted">9 mins</small>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<a href="" class="thumb"><img
										src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"
										alt="플래터, 음식, 선발, 식사, 잔치, 다 이닝 테이블, 테이블, 먹다, 맛있는 음식, 식당, 요리"></a>

									<div class="card-body">
										<p class="card-text">This is a wider card with supporting
											text below as a natural lead-in to additional content. This
											content is a little bit longer.</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="btn-group">
												<button type="button" class="btn small normal">View</button>
												<button type="button" class="btn small normal">Edit</button>
											</div>
											<small class="text-muted">9 mins</small>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="card mb-4 shadow-sm">
									<a href="" class="thumb"><img
										src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"
										alt="플래터, 음식, 선발, 식사, 잔치, 다 이닝 테이블, 테이블, 먹다, 맛있는 음식, 식당, 요리"></a>

									<div class="card-body">
										<p class="card-text">This is a wider card with supporting
											text below as a natural lead-in to additional content. This
											content is a little bit longer.</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="btn-group">
												<button type="button" class="btn small normal">View</button>
												<button type="button" class="btn small normal">Edit</button>
											</div>
											<small class="text-muted">9 mins</small>
										</div>
									</div>
								</div>
							</div>

						</div>

						<div class="col-12 text-center thumb-more">
							<a href="#" class="icon solid fa fa-plus-circle"></a>
						</div>
						<!-- end -->

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