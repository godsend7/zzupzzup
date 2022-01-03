<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>음식점 등록 정보 확인</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	window.onload = function() {
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "#button" ).on("click" , function() {
				self.location = "../main.jsp";
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
		
			<form action="">
			
				<div class="page-header">
			       <h2 class=" text-info">등록 요청한 음식점 정보 내역입니다.</h2>
			    </div><hr>
			    
			    <div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점명</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.restaurantName}</div>
				</div><br>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점 전화번호</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.restaurantTel}</div>
				</div><br>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점 도로명주소</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.streetAddress}</div>
				</div><br>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점 지번주소</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.areaAddress}</div>
				</div><br>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점 상세주소</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.restAddress}</div>
				</div><br>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식 종류</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.menuType}</div>
				</div><br>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점 메뉴</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.restaurantMenus}</div>
				</div><br>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점 운영시간</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.restaurantTimes}</div>
				</div><br>
				
				<div class="row">
			  		<div class="col-xs-4 col-md-2"><strong>음식점 사진</strong></div>
					<div class="col-xs-8 col-md-4">${restaurant.restaurantImage}</div>
				</div>
				
			</form><hr>
			
			<div class="text-center">
				<button type="button" class="btn btn-outline-danger btn-sm" id="button">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-shop" viewBox="0 0 16 16">
  				<path d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.371 2.371 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976l2.61-3.045zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0zM1.5 8.5A.5.5 0 0 1 2 9v6h1v-5a1 1 0 0 1 1-1h3a1 1 0 0 1 1 1v5h6V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5zM4 15h3v-5H4v5zm5-5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1v-3zm3 0h-2v3h2v-3z"/>
				</svg> 메인으로</button>
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
    