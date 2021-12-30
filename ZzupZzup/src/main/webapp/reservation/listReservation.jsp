<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-listReservation</title>

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
		  $("#reservation").attr("action","/reservation/listReservation").attr("method", "POST").submit();
		}
		
		 function fncGetReservation(reservationNo) {
			 
			console.log(reservationNo);

			console.log("nickname~~~::"+${reservation.restaurant.restaurantName});
			$.ajax({
				url : "/reservation/json/getReservation/"+reservationNo,
				method : "GET",
				dataType : "json",
				success : function(data, status) {
					console.log(data);
				}
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

				<section id="listReservation">
					<div class="container">
						
					<!-- start:Form -->
					<form id="reservation">
							<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
							<input type="hidden" id="currentPage" name="currentPage" value=""/>
						</form>		
							
							
					<div class="row thumb-list">
						<c:set var="i" value="0" />
				 		 	<c:forEach var="reservation" items= "${list}">
				 		 		<c:set var="i" value="${i+2}" />
						<div class="col-md-4">
							<div class="card mb-4 shadow-sm">
								<a href="" class="thumb"><img
									src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"
									alt="플래터, 음식, 선발, 식사, 잔치, 다 이닝 테이블, 테이블, 먹다, 맛있는 음식, 식당, 요리"></a>
				
								<div class="card-body">
									<h3 class="card-title">${reservation.restaurant.restaurantName}</h3>
									<h4 class="text-primary card-title">에약번호  <a href="javascript:fncGetProductList();">${reservation.reservationNumber}</a></h4>
								
										<div class="col-6 col-12-xsmall">
										<label for="demo-name">참여자 NickName</label> 
										<p>${reservation.member.nickname}</p>
										</div>
										
										<div class="col-6 col-12-xsmall">
										<label for="demo-name">방문 확정 전</label> 
										<p>${reservation.planDate}</p>
										</div>
										
										<div class="container">
										<div class="row">
									    <div class="col-md-8">
									    <label for="demo-name">방문 확정 후(승인)</label> 
										<p>${reservation.fixedDate} </div>
									    <div class="col-6 col-md-4">
									    <a href="#" class="button small primary stretched-link">리뷰 쓰기</a></div>
									  	</div> 
									  	</div>
										<!-- <div class="col-6 col-12-xsmall">
										<label for="demo-name">방문 확정 후(승인)</label> 
										<p>2021-12-04  13:30   
										<div class="d-flex justify-content-between align-items-end">
										<a href="#" class="button small primary stretched-link">리뷰 쓰기</a></p>
										</div>
										</div> -->
									
										<div class="col-6 col-12-xsmall">
										<label for="demo-name">예약 및 결제 현황</label> 
										<p>${reservation.fixedDate}</p>
										</div>
								</div>
							</div>
							
						</div>
						</c:forEach>
						<!-- <div class="col-md-4">
							<div class="card mb-4 shadow-sm">
								<a href="" class="thumb"><img
									src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"
									alt="플래터, 음식, 선발, 식사, 잔치, 다 이닝 테이블, 테이블, 먹다, 맛있는 음식, 식당, 요리"></a>
				
								<div class="card-body">
									<h3 class="card-title">거구장 1호점</h3>
									<h4 class="text-primary card-title">에약번호  <a href="javascript:fncGetProductList();">202111215</a></h4>
								
										<div class="col-6 col-12-xsmall">
										<label for="demo-name">참여자 NickName</label> 
										<p>비트캠프 외 2명</p>
										</div>
										
										<div class="col-6 col-12-xsmall">
										<label for="demo-name">방문 확정 전</label> 
										<p>2021-12-04  13:30</p>
										</div>
										
										<div class="container">
										<div class="row">
									    <div class="col-md-8">
									    <label for="demo-name">방문 확정 후(승인)</label> 
										<p>2021-12-04  13:30   </div>
									    <div class="col-6 col-md-4">
									    <a href="#" class="button small primary stretched-link">리뷰 보기</a></div>
									  	</div> 
									  	</div>
										<div class="col-6 col-12-xsmall">
										<label for="demo-name">예약 및 결제 현황</label> 
										<p>방문 완료</p>
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
									<h3 class="card-title">거구장 1호점</h3>
									<h4 class="text-primary card-title">에약번호  <a href="javascript:fncGetProductList();">202111215</a></h4>
								
										<div class="col-6 col-12-xsmall">
										<label for="demo-name">참여자 NickName</label> 
										<p>비트캠프 외 2명</p>
										</div>
										
										<div class="col-6 col-12-xsmall">
										<label for="demo-name">방문 확정 전</label> 
										<p>2021-12-04  13:30</p>
										</div>
										
										<div class="container">
										<div class="row">
									    <div class="col-md-8">
									    <label for="demo-name">방문 확정 후(승인)</label> 
										<p>2021-12-04  13:30   </div>
									    <div class="col-6 col-md-4">
									    <a href="#" class="button small primary stretched-link">리뷰 쓰기</a></div>
									  	</div> 
									  	</div>
										<div class="col-6 col-12-xsmall">
										<label for="demo-name">예약 및 결제 현황</label> 
										<p>방문 완료</p>
										</div>
								</div>
							</div>
						</div> -->
						
		
				
				
					<div class="col-12 text-center thumb-more">
						<a href="#" class="icon solid fa fa-plus-circle"></a>
					</div>
					<!-- end -->
					
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