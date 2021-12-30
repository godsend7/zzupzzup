<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-GETCOMMUNITY</title>

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
				$("#restaurant").attr("method", "POST").attr("action","/community/deleteCommunity").submit();
			});
		});
		
		$(function() {
			$("button.btn.btn-primary").on("click", function() {
				self.location = "/community/updateCommunity?postNo=${community.postNo}"
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
				
				<section id="">
				
				<form id="restaurant">
				
				<input type="hidden" class="form-control" id="community.postNo" name="community.postNo" value="${community.postNo}">
				
				<div class="container">
					
					<div class="row">
				       <h2 class=" col">${community.postTitle} &nbsp;
				       	<small style="color:gray;">작성자: ${community.member.nickname}</small></h2>
				    </div><hr>
				    
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
				  		<div class="col-xs-4 col-md-2"><strong>게시물 설명</strong></div>
						<div class="col-xs-8 col-md-4">${community.postText}</div>
					</div><hr/>
				    
				    <div class="row">
				  		<div class="col-xs-4 col-md-2"><strong>음식점명</strong></div>
						<div class="col-xs-8 col-md-4">${community.restaurantName}</div>
					</div>
					
					<div class="row">
				  		<div class="col-xs-4 col-md-2"><strong>음식점 전화번호</strong></div>
						<div class="col-xs-8 col-md-4">${community.restaurantTel}</div>
					</div>
					
					<div class="row">
				  		<div class="col-xs-4 col-md-2"><strong>음식점 도로명주소</strong></div>
						<div class="col-xs-8 col-md-4">${community.streetAddress}</div>
					</div>
					
					<div class="row">
				  		<div class="col-xs-4 col-md-2"><strong>음식점 지번주소</strong></div>
						<div class="col-xs-8 col-md-4">${community.areaAddress}</div>
					</div>
					
					<div class="row">
				  		<div class="col-xs-4 col-md-2"><strong>음식점 상세주소</strong></div>
						<div class="col-xs-8 col-md-4">${community.restAddress}</div>
					</div>
					
					<div class="row">
				  		<div class="col-xs-4 col-md-2"><strong>음식 종류</strong></div>
						<div class="col-xs-8 col-md-4">${community.menuType}</div>
					</div><hr>
					
					<div class="row">
				  		<div class="col-xs-4 col-md-2"><strong>음식점 메인메뉴 이름</strong></div>
						<div class="col-xs-8 col-md-4">${community.mainMenuTitle}</div>
					</div>
					
					<div class="row">
				  		<div class="col-xs-4 col-md-2"><strong>음식점 메인메뉴 가격</strong></div>
						<div class="col-xs-8 col-md-4">${community.mainMenuPrice}</div>
					</div><hr>
					
					<div class="text-center">
						<button type="button" class="btn btn-link">삭제하기</button>
						<button type="button" class="btn btn-primary">수정하기</button>
						<button type="button" class="btn btn-warning">목록으로</button>
					</div>
					
				</div>
				
				</form>
	
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
