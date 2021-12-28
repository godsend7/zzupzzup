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

				<section id="">
					<div class="container">
						
					<div class="col-md-12">
						<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
							<div class="col p-4 d-flex flex-column position-static">
								<a style="text-align: right;"><strong class="d-inline-block mb-2 text-primary">불량음식점</strong></a>
								<h2 class="mb-0">${restaurant.restaurantName}&nbsp;<small style="color:gray;">${restaurant.menuType}</small></h2><hr>
								<div class="mb-1 text-muted"><strong>대표자명</strong> | ${restaurant.member.memberId}</div>
								<div class="mb-1 text-muted"><strong>주소</strong> | ${restaurant.streetAddress}</div>
								<div class="mb-1 text-muted"><strong>전화번호</strong> | ${restaurant.restaurantTel}</div>
								<a href="#" style="text-align: right;" class="stretched-link">상세보기</a>
							</div>
						</div>
					</div>
					
					<div class="col-md-12">
						<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
							<div class="col p-4 d-flex flex-column position-static">
								<a style="text-align: right;"><strong class="d-inline-block mb-2 text-primary">불량음식점</strong></a>
								<h2 class="mb-0">${restaurant.restaurantName}&nbsp;<small style="color:gray;">${restaurant.menuType}</small></h2><hr>
								<div class="mb-1 text-muted"><strong>대표자명</strong> | ${restaurant.member.memberId}</div>
								<div class="mb-1 text-muted"><strong>주소</strong> | ${restaurant.streetAddress}</div>
								<div class="mb-1 text-muted"><strong>전화번호</strong> | ${restaurant.restaurantTel}</div>
								<a href="#" style="text-align: right;" class="stretched-link">상세보기</a>
							</div>
						</div>
					</div>
					
					<div class="col-md-12">
						<div class="no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
							<div class="col p-4 d-flex flex-column position-static">
								<a style="text-align: right;"><strong class="d-inline-block mb-2 text-primary">불량음식점</strong></a>
								<h2 class="mb-0">${restaurant.restaurantName}&nbsp;<small style="color:gray;">${restaurant.menuType}</small></h2><hr>
								<div class="mb-1 text-muted"><strong>대표자명</strong> | ${restaurant.member.memberId}</div>
								<div class="mb-1 text-muted"><strong>주소</strong> | ${restaurant.streetAddress}</div>
								<div class="mb-1 text-muted"><strong>전화번호</strong> | ${restaurant.restaurantTel}</div>
								<a href="#" style="text-align: right;" class="stretched-link">상세보기</a>
							</div>
						</div>
					</div>

					</div><br><br><br>
					
					<ul class="pagination">
						<li><span class="button disabled">Prev</span></li>
						<li><a href="#" class="page active">1</a></li>
						<li><a href="#" class="page">2</a></li>
						<li><a href="#" class="page">3</a></li>
						<li><span>&hellip;</span></li>
						<li><a href="#" class="page">8</a></li>
						<li><a href="#" class="page">9</a></li>
						<li><a href="#" class="page">10</a></li>
						<li><a href="#" class="button">Next</a></li>
					</ul>
					
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