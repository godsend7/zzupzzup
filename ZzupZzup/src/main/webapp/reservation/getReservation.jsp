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

#getReservationView #getReservation label { margin-bottom: 0px; }
#getReservationView #getReservation  p { color: #999; }
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {

		console.log("getReservationView.jsp");
		///날짜 초 자르는 부분 ///
		var fixed = "${reservation.fixedDate}";
		var fixedDateSlice = fixed.slice(0,-5);
		$(".fixedDate").find("p").text(fixedDateSlice);
		
		var reservationDate = "${reservation.reservationDate}";
		var reservationDateSlice = reservationDate.slice(0,-5);
		$(".reservationDate").find("p").text(reservationDateSlice);
		//////////이전페이지////////////////
		var memberRole = "${member.memberRole}";
	   	 $(".reset").on("click" , function() {
	    	if(memberRole == 'owner'){
	   		 	self.location = "/reservation/listMyReservation"
	    	}else {
	    		self.location = "/reservation/listReservation"
	    	}
	   		
	   		
	   		
		}); 
		//////////모달 이동////////////////
		  $(".confirm").on("click" , function() {
			$('#rejectionModal').modal("hide");
	    	$("#cancelUseModal").modal('show');
		});  
	   	///////////////////////업주가 아니오를 누를시 미방문//////////////////////////
			$(".no").on("click", function() {
				console.log(".no");
				 $.ajax({
					url : "/reservation/json/updateReservation/${reservation.reservationNo}/2",
					method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"contentType" : "application/json; charset=utf-8"
					},
					success : function(data){
						console.log(data+"data 나오는 부분 미완료");
						$('#getReservationModal').modal("hide");
						history.go(0);
					},
					error : function(e) {
						alert(e.responseText);
					}
				}); 
			});
	   	/////////////////////////업주가 예를 누를시 방문완료//////////////////////////
	   		$(".yes").on("click", function() {
				console.log(".yes");
				 $.ajax({
					url : "/reservation/json/updateReservation/${reservation.reservationNo}/1",
					method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"contentType" : "application/json; charset=utf-8"
					},
					success : function(data){
						console.log(data+"data 나오는 부분 방문완료");
						$('#getReservationModal').modal("hide");
						history.go(0);
						
					},
					error : function(e) {
						alert(e.responseText);
					}
				}); 
			});
	   	////////////////////////유저가 예약 취소버튼 누를시//////////////////////////
	   	function fncUserConfirm() {
	   		
				console.log("#reservationRejectionModal");
				 $.ajax({
					url : "/reservation/json/updateReservation/${reservation.reservationNo}/3",
					method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"contentType" : "application/json; charset=utf-8"
					},
					success : function(data){
						$('#reservationRejectionModal').modal("hide");
						alert("예약 취소가 완료되었습니다. 예약/주문 취소 메세지가 가게에 전송되며 선결제시 결제 취소버튼을 눌러주세요");
						history.go(0);
					},
					error : function(e) {
						alert(e.responseText);
					}
				}); 
	   	}
	///////메세지와 확인버튼을 같이//////////
			$("#userConfirm").on("click", function() {
				fncUserConfirm();
				fncMesseage(); //메세지 coolsms 부르는 function
				history.go(0);
			});
	   	/////////////////////////업주의 예약 거절/////////////////////////////////////////
	   	/* 	$(".cancelUseModal").on("click", function() {
				console.log("#cancelUseModal");
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
						console.log("예약거절 되나??");
						$('#cancelUseModal').modal("hide");
						alert("예약 거절이 완료되었습니다. 예약 거절 메세지가 해당 고객에게 전송되며 해당 고객님께서 선결제시 결제 취소 버튼을 눌러주세요.");
						history.go(0);
					},
					error : function(e) {
						alert(e.responseText);
					}
				}); 
			}); */
	   	//업주 예약거절 파트/////////////////////////////////////////////////////////////////////
	   		function fncCancelConfirm() {	
				console.log("#cancelConfirm");
				var cancelReason = $("input[name='reservationCancelReason']:checked").val();
				$.ajax({
					url : "/reservation/json/reservationCancel",
					type : "POST",
					dataType: "html",
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify({
						reservationNo : ${reservation.reservationNo},
						reservationCancelDetail :$("#reservationCancelDetail").val(),
						reservationCancelReason : cancelReason,
						reservationStatus : 4
						
					}),
					success : function(data){
						console.log("바꾸기 성공");
						$('#cancelUseModal').modal("hide");
						alert("예약 거절이 완료되었습니다. 예약 거절 메세지가 해당 고객에게 전송되며 해당 고객님께서 선결제시 결제 취소 버튼을 눌러주세요.");
						history.go(0);
						
					},
					error : function(e) {
						alert(e.responseText);
					} 
				}); 
			} 
	   		$("#cancelConfirm").on("click", function() {
				fncCancelConfirm();
				fncMesseage();
				history.go(0);
			});
			
	   	////////////////////////////////////////////////////////////////////////
	   	/* Iamport 환불시스템*/
		    $(".refundStatusYes").on("click", function() {
		    	
		    	console.log("#payRefundModal");	
		        var payMethod = $("input[name='payMethod']").val();
		        var refundStatus = $("input[name='refundStatus']").val();
		        jQuery.ajax({
		            url: "/reservation/json/payRefund/${reservation.reservationNo}/${reservation.payMethod}/${reservation.refundStatus}/", 
		            type: "GET",
		            dataType: "json",
		            headers: {
		                "Accept": "application/json",
		                "Content-Type": "application/json"
		            },
		            success: function (JSONData, status) {
		            	console.log(JSONData);
		            	
		            	if (JSONData == 1) {
							$('#refundStatus').modal("hide");
							alert("결제 취소가 완료되었습니다.");
							history.go(0);
						}
		            },
		            error : function(e) {
						alert(e.responseText);
					}
				}); 
			});
	   	
	////////////////////////////////////////////////////////////////////////////////////////////////
		    function fncMesseage() {	
				console.log("#SendMesseage");
				 var cancelReason = $("input[name='reservationCancelReason']:checked").val();
				
				$.ajax({
					url : "/reservation/json/sendPhoneMessage",
					type : "POST",
					dataType: "json",
					data : {
						reservationNo : ${reservation.reservationNo},
						reservationNumber : ${reservation.reservationNumber},
						reservationCancelDetail :$("#reservationCancelDetail").val(),
						reservationCancelReason : cancelReason,
						fromMemberPhone : "${member.memberPhone}",
						toMemberPhone : "${reservation.member.memberPhone}",
						restaurantNo : ${reservation.restaurant.restaurantNo},
						toNickName : "${reservation.member.nickname}"
					},
					success : function(data){
						alert("메세지 전송이 완료되었습니다.");
						
					},
					error : function(e) {
						alert(e.responseText);
					} 
				}); 
			} 
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
						<h2 class="pl-0">예약 정보</h2>
						<div class="col-12" style="padding:0px"></div>
					
						<form id="getReservation">
						
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
									<label for="nickname">예약자 NickName</label> 
									<p><c:forEach var="chatMember" items="${reservation.chat.chatMember}" varStatus="status">
											<c:out value = "${chatMember.member.nickname} ${status.last ? '' : '/'}"/>
										</c:forEach>
									</p>
								</div>
								<div class="col-6 col-12-xsmall">
									<label for="restaurantTel">음식점 전화번호</label> 
									<p>${reservation.restaurant.restaurantTel}</p>
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="restaurantAdress">음식점 소재지 주소</label>
									<p><span class="badge badge-info">도로명 주소</span>&nbsp;
									 ${reservation.restaurant.streetAddress}</p>
									<p><span class="badge badge-warning">지번 주소</span>&nbsp;&nbsp;&nbsp;&nbsp;
									 ${reservation.restaurant.areaAddress}</p>
									<p><span class="badge badge-success">상세 주소</span>&nbsp;&nbsp;&nbsp;&nbsp;
									 ${reservation.restaurant.restAddress}</p>
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
									<p><span>${reservation.planDate} ${reservation.planTime}</span>
									<!-- Button trigger modal -->
								<!-- ========모달에서 유저일경우 업주일경우 다르게 보여야됨============== -->
									<c:choose> 
										<c:when test="${member.memberRole == 'owner'}">
											<c:if test="${(reservation.reservationStatus != 1 || reservation.reservationStatus != 2) && reservation.reservationStatus == '' }">
											<input type="button" value="방문 확정" name= "reservationStatus" class="button small primary stretched-link " id="reservationStatus-modal" data-toggle="modal"
											data-target="#getReservationModal"/>
											</c:if>
											<c:if test="${reservation.reservationStatus == 0}">	
											<input type="button" value="예약 거절" name= "reservationRejection" class="button small primary stretched-link" id="reservationRejection-modal" data-toggle="modal"
											data-target="#rejectionModal"/>
											
											<input type="button" value="거절 사유" name= "cancelUse" class="button small primary stretched-link" id="cancelUse-modal" data-toggle="modal"
											data-target="#cancelUseModal"/ style="visibility: hidden;">
											</c:if>
											</c:when>
									</c:choose>
									<c:choose>
										<c:when test="${member.memberRole == 'user' && reservation.reservationStatus == ''}">
											<c:if test="${reservation.chat.chatLeaderId.memberId == member.memberId }">
											<input type="button" value="예약 취소" name= "reservationCancel" class="button small primary stretched-link" id="reservationCancel-modal" data-toggle="modal"
											data-target="#reservationRejectionModal"/>
											</c:if>
										</c:when>
									</c:choose>
									</p>	
								</div>
								<!-- ========모달에서 유저일경우 업주일경우 다르게 보여야됨============== -->	
									<!-- Button trigger modal --> 
								
								<div class="col-6 col-12-xsmall fixedDate">
								<label for="fixedDate">방문 확정 후</label> 
									<c:choose>
										<c:when test="${reservation.reservationStatus == 1 || reservation.reservationStatus == 2}">
										<p>${reservation.fixedDate} ${reservation.returnStatus}</p>
										<input id="fixedDate" name="fixedDate" type="hidden" value="">
										</c:when>
									</c:choose>	
								</div>
								<div class="col-12">
									<label for="reservationStatus">예약 및 결제 현황</label>
									<p><c:choose>
											<c:when test="${reservation.returnStatus!=''}">
												${reservation.returnStatus} /
												</c:when>
											</c:choose>
												${reservation.returnRefund}
									<c:choose>
										<c:when test="${(reservation.reservationStatus == 3 || reservation.reservationStatus == 4) && reservation.refundStatus != 'true' && reservation.payOption == 2}">
										<c:if test="${reservation.chat.chatLeaderId.memberId == member.memberId || member.memberRole == 'owner'  }">
										<input type="button" value="결제 취소" name= "refundStatus" class="button small primary stretched-link refundStatus-modal" id="refundStatus-modal" data-toggle="modal"
										data-target="#refundStatusModal"/>
										</c:if>
										</c:when>
									</c:choose>
									</p>
								</div>
								
								<div class="col-12">
									<label for="reservationStatus">예약 거절 사유</label>
									<p>${reservation.returnReservationCancelReason} ${reservation.reservationCancelDetail}</p>
									<hr/>
								</div>
								
								<!-- Break -->
								<h2 class="pl-4 mb-0 col-12">결제 정보</h2>
								<div class="col-12 pl-4 mb-0" style="padding:0px" ></div>
							
								<!-- Break -->
								<div class="col-12 reservationDate">
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
									<p>${reservation.totalPrice} 원</p>
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="orderTotal">결제 수단</label>
									<div class="orderTotal"></div>
									<p>${reservation.returnPayOption}</p>
								</div>
								
								<!-- Break -->
								
								<div class="col-12 d-flex justify-content-center">
									<ul class="actions">
										<li><input type="reset" value="이전 페이지" class="button secondary reset" /></li>
									</ul>
								</div>
							</div>
			
							<!-- Button trigger modal -->
							<input type="button" value="페이지 이동" class="btn btn-primary getReservationModal" id="" data-toggle="modal"
								data-target="#getReservationModal"/ style="visibility: hidden;">
							<!-- end -->
						
							 <!-- 업주 예약 거절 Modal -->
								<div class="modal fade" id="rejectionModal" tabindex="-1"
									aria-labelledby="rejectionModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5>예약 거절</h5>
												<button type="button" class="close secondary"
													data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											
											<div class="modal-body">해당 고객의 예약을 거절하시겠습니까?</div>
											
											<div class="modal-footer">
												<button type="button" class="button small secondary cancel"
													data-dismiss="modal">취소</button>
												<button type="button" class="button small primary confirm" id="confirm" 
													name="reservationStatus">확인</button>	
											</div>
										</div>
									</div>
								</div>
							 
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
											
											<form class="cancelUse">
											<div class="modal-body">
						
											<!-- 라디오 -->
											<div class="col-12-small">
												<input type="radio" id="reservationCancelReason1" name="reservationCancelReason" class="reservationCancelReason" value="1"
													checked> <label for="reservationCancelReason1">동일 시간대에 이미 해당 예약이 존재합니다.</label>
											</div>
											<div class="col-12-small">
												<input type="radio" id="reservationCancelReason2" name="reservationCancelReason" class="reservationCancelReason" value="2"> 
												<label for="reservationCancelReason2">가게 휴무일 입니다.</label>
											</div>
											<div class="col-12-small">
												<input type="radio" id="reservationCancelReason3" name="reservationCancelReason" class="reservationCancelReason" value="3"> 
												<label for="reservationCancelReason3">재고 소진으로 예약이 불가능한 메뉴입니다.</label>
											</div>
											<!-- text -->
											<div class="col-12-small">
											<input type="radio" id="reservationCancelReason4" name="reservationCancelReason" class="reservationCancelReason" value="4"> 
												<label for="reservationCancelReason4">기타 내용 작성</label>
												 <textarea name="reservationCancelDetail" id="reservationCancelDetail"
													placeholder="20자 이내로 작성해주세요" rows="6" maxlength="24"></textarea> 
											</div>
											<!-- Break -->
											<input type= "hidden" name ="reservationStatus" value ="4"/>
											</div>
											
											<!-- 라디오 End -->
											<div class="modal-footer">
												<button type="button" class="button small secondary cancelUse"
													data-dismiss="modal">취소</button>
												<button type="button" class="button small primary cancelConfirm" id="cancelConfirm">확인</button>
											</div>
											
											</form>
											
											
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
													
												<button type="button" class="button small primary no" id="no" value="2"
													name="reservationStatus">아니오</button>		
												<button type="button" class="button small primary yes" id="yes" value="1"
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
												<button type="button" class="button small secondary" id="userClose"
													data-dismiss="modal">취소</button>
												<button type="button" class="button small primary userConfirm" id="userConfirm" 
													name="reservationStatus">확인</button>	
											</div>
										</div>
									</div>
								</div>
								<!-- 결제취소 Modal -->
								<div class="modal fade" id="refundStatusModal" tabindex="-1"
									aria-labelledby="refundStatusModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5>결제 취소</h5>
												<button type="button" class="close secondary"
													data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">해당 결제내역을 취소하시겠습니까?</div>
											<div class="modal-footer">
												<button type="button" class="button small secondary" id="refundStatusClose" 
													data-dismiss="modal">취소</button>	
												<button type="button" class="button small primary refundStatusYes" id="refundStatusYes" value="true"
													name="refundStatus">예</button>	
											</div>
										</div>
									</div>
								</div>
								<!-- 결제취소 Modal END -->
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