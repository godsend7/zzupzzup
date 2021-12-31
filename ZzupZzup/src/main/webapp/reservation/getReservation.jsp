<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-addReservationView</title>

<jsp:include page="/layout/toolbar.jsp" />
<!-- <script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script> -->
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
/* .nbsp > span {margin-right:100px;} 
.nbsp input { border: none;  } */

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {

		console.log("getReservationView.jsp");
		
		////////////////////////////////////==> 유효성 체크
		var reservation_status = 0;
		reservation_status ="<input type='text' name='reservationStatus["+ reservation_status +"].orderCount' id='reservationStatus' value='3'></div>";
		
	     $(".no").on("click" , function() {
	    	 reservation_status
		}); 
		//////////이전페이지////////////////
		
		
	   //console.log(reviewNo);
	    	function reservationStatusFunction() {
				var reservationStaus = $("#reservationStaus").val();
				$.ajax({
					type : "GET",
					url : "/reservation/json/getReservation",
					data : {
						"reservationStaus" : reservationStatus
					},
					success : function(result) {
						
							if (result==1) {
								$("#reservationStaus").text("결제완료");
							} 
							
							else if (result==2) {
								$("#reservationStaus").text("방문완료");	
							}
							 else if (result==3) {
							$("#reservationStaus").text("미방문");	
							}
							
							 else if (result==4) {
							$("#reservationStaus").text("예약 취소");	
							}
							
							 else if (result==5) {
							$("#reservationStaus").text("예약 거절");	
							}
							
							}
						})
			}
		
		
		
		
		
		
		
		
		
		
		
		
		
		//////////모달 이동////////////////
	    /* $(".yes").on("click" , function() {
	    	self.location = "/reservation/getReservation"
		}); */
		//////////모달 이동////////////////
		
		//////////모달 이동////////////////
	    /* $(".close").on("click" , function() {
	    	self.location = "/"
		}); */
		
		//////////모달 이동////////////////
		
		/////////////////////////getReservation 모달사용//////////////////////////
		/* $( "body" ).on("click" , ".fixedDate", function() {
			$("#modal").trigger('click');
			$(".yes").on("click" , function() {
				self.location = "/main.jsp"
			});  */
	   	
	   	/////////////////////////최종가격//////////////////////////
	  
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
				
				<section id="getReservationView">
					<div class="container">

						<!-- start:Form -->
						<h3>예약 정보</h3>
					
						<form id="getReservation">
						
								<input type="hidden" id="chat.chatNo" name="chat.chatNo" value="1">
								<input type="hidden" id="restaurant.restaurantNo" name="restaurant.restaurantNo" value="1">
<%-- 								<input type="hidden" id="chat.chatNo" name="chat.chatNo" value="${reservation.chat.chatNo}">
								<input type="hidden" id="restaurant.restaurantNo" name="restaurant.restaurantNo" value="${reservation.restaurant.restaurantNo}"> --%>
								
								<%-- <input type="hidden" id="member.memberId" name="member.memberId" value="${reservation.member.memberId}"> --%>
								<%-- <input type="hidden" id="reservation.reservationNo" name="reservation.reservationNo" value="${reservation.reservationNo}"> --%>
								<%-- <input type="hidden" id="restaurantNo" name="restaurantNo" value="${reservation.restaurant.restaurantNo}"> --%>
							
							<div class="row gtr-uniform">
								<div class="col-6 col-12-xsmall">
									<label for="reservationNumber">예약 번호</label> 
									<p>${reservation.reservationNumber}</p>
									
								</div>
								<div class="col-6 col-12-xsmall">
									<label for="restaurantName">음식점 명</label> 
									<p>${reservation.restaurant.restaurantName}</p>
								</div>
							
							
								<div class="col-12">
									<label for="nickname">NickName</label> 
									<p>${reservation.member.nickname}</p>
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="restaurantTel">음식점 전화번호</label> 
									<p>${reservation.restaurant.restaurantTel}</p>
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="restaurantAdress">음식점 소재지 주소</label> 
									<p>${reservation.restaurant.streetAddress}</p>
									<p>${reservation.restaurant.areaAddress}</p>
									<p>${reservation.restaurant.restAddress}</p>
									
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="restaurantType">음식 종류</label> 
									<p>${reservation.restaurant.menuType}</p>
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="memberCount">예약 인원 수</label> 
									<p>${reservation.memberCount} 명</p>
								</div>
					<!-- ///////////////////get 추가///////////////////////// -->			
								<div class="col-6 col-12-xsmall">
									<label for="restaurantType">방문 확정 전</label>
									<p>${reservation.planDate} ${reservation.planTime}
									<!-- Button trigger modal -->
								
								<!-- ========모달에서 유저일경우 업주일경우 다르게 보여야됨============== -->
								
								<%-- <c:if test="${reservation.member.reservationStatus == false}">
									<input type="button" value="예약 거절" class="button small primary stretched-link" id="admin-modal" data-toggle="modal"
									data-target="#getReservationModal"/></p>
								</c:if>	 --%>
								
								<%-- <c:if test="${reservation.member.memberRole == 'owner'}"> --%>
									<input type="button" value="방문 확정" name= "reservationStatus" class="button small primary stretched-link" id="reservationStatus-modal" data-toggle="modal"
									data-target="#getReservationModal"/></p>
								<%-- </c:if>	 --%>
								<!-- ========모달에서 유저일경우 업주일경우 다르게 보여야됨============== -->	
									<!-- Button trigger modal --> 
								</div>
								
								<div class="col-6 col-12-xsmall fixedDate">
									<label for=""fixedDate"">방문 확정 후</label> 
									<p>${reservation.fixedDate}</p>
									<input id="fixedDate" name="fixedDate" type="hidden" value="1">
									
									
								</div>
								
								<div class="col-12">
									<label for="reservationStatus">예약 및 결제 현황</label>
									<p>${reservation.reservationStatus}</p>
								</div>
								
								
							
								<!-- Break -->
								<h3>결제정보</h3>
								
								<!-- Break -->
								<div class="col-12">
									<label for="restaurantType">예약 및 결제 일시</label> 
									<p>${reservation.reservationDate}</p>
								</div>
								
								<!-- ///////////////////get 추가///////////////////////// -->
								<!-- Break -->
								<div class="col-6 col-12-xsmall">
									<label for="orderName">주문 메뉴 명, 수량</label> 
									
					                <p>	<c:forEach var="order" items="${reservation.order[0].menuTitle}">
					                		<c:out value = "${reservation.order[0].menuTitle} ${reservation.order[0].orderCount}"/>
										</c:forEach> </p>
								</div>
								
								
								<div class="col-6 col-12-xsmall">
									<label for="orderTotal">주문 메뉴 총 가격</label>
									<div class="orderTotal"></div>
									<p>${reservation.totalPrice}</p>
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="orderTotal">결제 수단</label>
									<div class="orderTotal"></div>
									<p>${reservation.payOption}</p>
								</div>
								
								
								<script type="text/javascript"></script>
							 
							 
					
								
								<script>
								
								
							    </script>
								
								<!-- Break -->
								
								<div class="col-12">
									<ul class="actions">
										<!-- <li><input type="button" value="결제하기" class="primary payment1 payment-btn"/></li> -->
										<li><input type="reset" value="이전 페이지" class="normal reset" /></li>
									</ul>
								</div>
							</div>
							
							
							
							<!-- Modal -->
							<div class="modal fade" id="getReservationModal" tabindex="-1" role="dialog"
								aria-labelledby="getReservationModalLabel" aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
									
										<div class="modal-body">
											<form class="form-signin">
												
												<h6 class="h6 mb-6 font-weight-normal">해당 고객이 음식점을 방문하였습니까?</h6>
												
												</div>
												<input class="btn btn-lg no" id="no"
													type="button" value="아니오" />
													
												<input class="btn btn-lg btn-primary yes" id="yes"
													type="button" value="예" />	
													
												<input class="btn btn-lg btn-primary close" id="close"
													type="button" value="닫기" />		
												
											</form>
										</div>
										
						</form>
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