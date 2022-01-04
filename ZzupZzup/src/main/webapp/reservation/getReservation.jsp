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
		
		//////////이전페이지////////////////
		
	   	 $(".reset").on("click" , function() {
	    	self.location = "/reservation/listReservation"
		}); 
		
		//////////모달 이동////////////////
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
	   	
	   	/////////////////////////ajax//////////////////////////
	 
			$(".no").on("click", function() {
				console.log(".no");
				console.log("${reservation.reservationNo}");
				console.log("${reservation.reservationStatus}");
				 $.ajax({
					url : "/reservation/json/updateReservation/${reservation.reservationNo}/3",
					method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"contentType" : "application/json; charset=utf-8"
					},
					success : function(data){
						console.log("바꾸기 성공");
						//$("input[value='3']").val('미방문');
						$('#getReservationModal').modal("hide");
					},
					error : function(e) {
						alert(e.responseText);
					}
				}); 
			});
					
	   	/////////////////////////ajax//////////////////////////
	   	
	   		$(".yes").on("click", function() {
				console.log(".yes");
				console.log("${reservation.reservationNo}");
				console.log("${reservation.reservationStatus}");
				 $.ajax({
					url : "/reservation/json/updateReservation/${reservation.reservationNo}/2",
					method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"contentType" : "application/json; charset=utf-8"
					},
					success : function(data){
						console.log("바꾸기 성공");
						//$("input[value='2']").val('방문완료');
						$('#getReservationModal').modal("hide");
					},
					error : function(e) {
						alert(e.responseText);
					}
				}); 
			});
					
	   	/////////////////////////ajax//////////////////////////
	   	
	   		$("#reservationRejectionModal").on("click", function() {
				console.log("#reservationRejectionModal");
				console.log("${reservation.reservationNo}");
				console.log("${reservation.reservationStatus}");
				 $.ajax({
					url : "/reservation/json/updateReservation/${reservation.reservationNo}/4",
					method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"contentType" : "application/json; charset=utf-8"
					},
					success : function(data){
						console.log("바꾸기 성공");
						$('#reservationRejectionModal').modal("hide");
						alert("예약 취소가 완료되었습니다. 예약/주문 취소 메세지가 가게에 전송되었습니다.");
						
					},
					error : function(e) {
						alert(e.responseText);
					}
				}); 
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
									<p>${reservation.restaurant.returnMenuType}</p>
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="memberCount">예약 인원 수</label> 
									<p>${reservation.memberCount} 명</p>
								</div>
									
								<div class="col-6 col-12-xsmall">
									<label for="restaurantType">방문 확정 전</label>
									<p>${reservation.planDate} ${reservation.planTime}</p>
									<!-- Button trigger modal -->
								
								<!-- ========모달에서 유저일경우 업주일경우 다르게 보여야됨============== -->
								
									<p><input type="button" value="방문 확정" name= "reservationStatus" class="button small primary stretched-link" id="reservationStatus-modal" data-toggle="modal"
									data-target="#getReservationModal"/></p>
									
									<p><input type="button" value="예약 거절" name= "reservationRejection" class="button small primary stretched-link" id="reservationRejection-modal" data-toggle="modal"
									data-target="#rejectionModal"/></p>
									
									<p><input type="button" value="예약 취소" name= "reservationCancel" class="button small primary stretched-link" id="reservationCancel-modal" data-toggle="modal"
									data-target="#reservationRejectionModal"/></p>
									
								<!-- //////////////////////////////////////////////////////// -->	
									<p><input type="button" value="거절 사유" name= "cancelUse" class="button small primary stretched-link" id="cancelUse-modal" data-toggle="modal"
									data-target="#cancelUseModal"/></p>
								
								<!-- ========모달에서 유저일경우 업주일경우 다르게 보여야됨============== -->	
									<!-- Button trigger modal --> 
								</div>
								
								<div class="col-6 col-12-xsmall fixedDate">
									<label for=""fixedDate"">방문 확정 후</label> 
									<p>${reservation.fixedDate} ${reservation.returnStatus}</p>
									<input id="fixedDate" name="fixedDate" type="hidden" value="1">
									
									
								</div>
								
								<div class="col-12">
									<label for="reservationStatus">예약 및 결제 현황</label>
									<p>${reservation.returnStatus}</p>
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
									
					                <p>	<c:forEach var="order" items="${reservation.order}" varStatus="status">
					                		<c:out value = "${order.menuTitle} - ${order.orderCount} ${status.last ? '' : '/'}"/>
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
									<p>${reservation.returnPayOption}</p>
								</div>
								
								
								<script type="text/javascript"></script>
							 
							 
					
								
								<script>
								
								
							    </script>
								
								<!-- Break -->
								
								<div class="col-12">
									<ul class="actions">
										<li><input type="reset" value="이전 페이지" class="normal reset" /></li>
									</ul>
								</div>
							</div>
			
							<!-- Button trigger modal -->
							<input type="button" value="페이지 이동" class="btn btn-primary getReservationModal" id="" data-toggle="modal"
								data-target="#getReservationModal"/ style="visibility: hidden;">
							<!-- end -->
						
						
							<!-- S:Modal -->
							<!-- Modal -->
							<div class="modal fade" id="rejectionModal" tabindex="-1" role="dialog"
								aria-labelledby="rejectionModalLabel" aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										
										<div class="modal-body">
												
											<h6 class="h6 mb-6 font-weight-normal">해당 고객의 예약을 거절하시겠습니까?</h6>
												
											<input class="btn btn-lg cancel" id="cancel"
													type="button" value="취소" />
													
											<input class="btn btn-lg btn-primary confirm" id="confirm"
													type="button" value="확인" />	
										</div>
									</div>
								</div>
							</div>
							<!-- E:Modal -->
							
							
							<!-- 거절사유 Modal -->
								<div class="modal fade" id="cancelUseModal" tabindex="-1" 
									aria-labelledby="cancelUseModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLabel">예약 거절 사유를 입력해주세요</h5>
												<button type="button" class="close secondary"
													data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											
											<div class="modal-body">
											
											<!-- 라디오 -->
											<div class="col-12-small">
												<input type="radio" id="reservationCancelReason1" name="reservationCancelReason" value="1"
													checked> <label for="reservationCancelReason1">동일 시간대에 이미 해당 예약이 존재합니다.</label>
											</div>
											<div class="col-12-small">
												<input type="radio" id="reservationCancelReason2" name="reservationCancelReason" value="2"> 
												<label for="reservationCancelReason2">가게 휴무일 입니다.</label>
											</div>
											<div class="col-12-small">
												<input type="radio" id="reservationCancelReason3" name="reservationCancelReason" value="3"> 
												<label for="reservationCancelReason3">재고 소진으로 예약이 불가능한 메뉴입니다.</label>
											</div>
											<!-- text -->
											<div class="col-12">
												<label for="reservationCancelDetail">기타 내용 작성</label>
												<textarea name="reservationCancelDetail" id="reservationCancelDetail"
													placeholder="100자 이내로 작성해주세요" rows="6"></textarea>
											</div>
											<!-- Break -->
											
											</div>
											<!-- 라디오 End -->
											<div class="modal-footer">
												<button type="button" class="button small secondary cancelUse"
													data-dismiss="modal">취소</button>
												<button type="button" class="button small primary cancelConfirm">확인</button>
											</div>
										</div>
									</div>
								</div>
							
							<!-- 방문확정 Modal -->
								<div class="modal fade" id="getReservationModal" tabindex="-1"
									aria-labelledby="getReservationModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5>방문 확정</h5>
												<button type="button" class="close secondary"
													data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											
											<div class="modal-body">해당 고객이 음식점을 방문하였습니까?</div>
											<div class="modal-footer">
												<button type="button" class="button small secondary" id="close" 
													data-dismiss="modal">취소</button>
													
												<button type="button" class="button small primary no" id="no" value="3"
													name="reservationStatus">아니오</button>		
												<button type="button" class="button small primary yes" id="yes" value="2"
													name="reservationStatus">예</button>	
											</div>
										</div>
									</div>
								</div>
							
						
					<!-- /////////////////////////////////////////////////////////////////////////////////////////// -->
						<!-- 유저 Modal -->
								<div class="modal fade" id="reservationRejectionModal" tabindex="-1"
									aria-labelledby="reservationRejectionModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5>예약 취소</h5>
												<button type="button" class="close secondary"
													data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											
											<div class="modal-body">예약 취소는 방문 예정시간 하루 전까지 취소가 가능합니다. 
											예약을 취소하시겠습니까?</div>
											
											<div class="modal-footer">
												<button type="button" class="button small secondary"
													data-dismiss="modal">취소</button>
												<button type="button" class="button small primary userConfirm" id="userConfirm" 
													name="reservationStatus">확인</button>	
											</div>
										</div>
									</div>
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