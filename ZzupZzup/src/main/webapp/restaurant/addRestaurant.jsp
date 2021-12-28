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
			</div><hr>
			
			<div class="text-center">
				<ul class="actions">
					<li><input type="submit" id="button" value="확인" class="primary" /></li>
				</ul>
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
    