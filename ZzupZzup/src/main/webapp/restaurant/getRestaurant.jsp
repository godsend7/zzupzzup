<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-GETRESTAURANT</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	window.onload = function(){
		$(function() {
			$("button.btn.btn-warning").on("click", function() {
				history.go(-1);
			});
		});
		
		$(function() {
			$("button.btn.btn-link").on("click", function() {
				$("#restaurant").attr("method", "POST").attr("action","/restaurant/deleteRestaurant").submit();
			});
		});
		
		// carousel prev & next
		$("#car_prev").click(function(){
			$("#carouselExampleFade").carousel("prev");
		});
		
		$("#car_next").click(function(){
			$("#carouselExampleFade").carousel("next");
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
				
				<section id="restaurant">
					<div class="container">
					
					<h2 class="text-warning">${restaurant.restaurantName}&nbsp;<small style="color:gray;">${restaurant.menuType}</small></h2><hr>
					
					<div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel">
					  <div class="carousel-inner">
					    <div class="carousel-item active">
					      <img src="/resources/images/uploadImages/burger-king-logo.png" height="600" class="d-block w-100" alt="...">
					    </div>
					    <div class="carousel-item">
					      <img src="/resources/images/uploadImages/mcdonald.jpg" height="600" class="d-block w-100" alt="...">
					    </div>
					    <div class="carousel-item">
					      <img src="/resources/images/uploadImages/kfc.png" height="600" class="d-block w-100" alt="...">
					    </div>
					  </div>
					  <button class="carousel-control-prev" type="button" id="car_prev" data-target="#carouselExampleFade" data-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="sr-only">Previous</span>
					  </button>
					  <button class="carousel-control-next" type="button" id="car_next" data-target="#carouselExampleFade" data-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="sr-only">Next</span>
					  </button>
					</div><br><br>
					
					<div class="row">
		  				<div class="col-xs-4 col-md-2"><strong>전화번호</strong></div>
						<div class="col-xs-8 col-md-4">${restaurant.restaurantTel}</div>
					</div><br><br>
					
					<div class="row col-xs-4">
		  				<div class="col"><strong>위치</strong></div>
						<div class="col">도로명주소: ${restaurant.streetAddress}</div>
						<div class="col">지번주소: ${restaurant.areaAddress}</div>
						<div class="col">상세주소: ${restaurant.restAddress}</div>
					</div><br><br>
					
					<div class="row col-xs-4">
		  				<div class="col"><strong>영업시간</strong></div>
						<div class="col">오픈시간: ${restaurant.restaurantTimes[0].restaurantOpen}</div>
						<div class="col">마감시간: ${restaurant.restaurantTimes[0].restaurantClose}</div>
						<div class="col">브레이크타임: ${restaurant.restaurantTimes[0].restaurantBreak}</div>
						<div class="col">라스트오더: ${restaurant.restaurantTimes[0].restaurantLastOrder}</div>
						<div class="col">휴무일: ${restaurant.restaurantTimes[0].restaurantDayOff}</div>
					</div><br><br>
					
					<div class="row col-xs-4">
		  				<div class="col"><strong>음식점 메뉴</strong></div>
						<div class="col">메뉴이름: ${restaurant.restaurantMenus[0].menuTitle}</div>
						<div class="col">메뉴가격: ${restaurant.restaurantMenus[0].menuPrice}</div>
						<div class="col">대표메뉴여부: ${restaurant.restaurantMenus[0].mainMenuStatus}</div>
					</div><br><br>
					
					<div class="row">
		  				<div class="col-xs-4 col-md-2"><strong>음식점 소개글</strong></div>
						<div class="col-xs-8 col-md-4">${restaurant.restaurantText}</div>
					</div><br><br>
					
					<div class="row">
		  				<div class="col-xs-4 col-md-2"><strong>음식점 등록일</strong></div>
						<div class="col-xs-8 col-md-4">${restaurant.restaurantRegDate}</div>
					</div><br><br><hr>
					
					<div class="text-center">
						<button type="button" class="btn btn-link">삭제하기</button>
						<button type="button" class="btn btn-warning">목록으로</button>
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