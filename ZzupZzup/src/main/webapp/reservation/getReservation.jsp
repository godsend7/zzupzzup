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
		/* var orderCount = 0;
		var order_price_total = 0;
	 */
		
		console.log("getReservationView.jsp");
		
		////////////////////////////////////==> 유효성 체크
		function fncGetReservation() {
			
			
			/* let orderName = $("#orderName").val();
			let orderCount = $("#orderCount").val();
			
			console.log("orderName : " + orderName);
			console.log("orderCount : " + orderCount);
			
			if(orderName == null){
				alert("메뉴를 선택해주세요");
				return;
			}
			
			if(orderCount == null){
				alert("수량을 선택해주세요");
				return; */
			}
			
			//$("#totalPrice").val(order_price_total);
			//console.log("totalPrice~~~"+$("#totalPrice").val());
			//$("#addReservation").attr("method" , "POST").attr("action" , "/reservation/addReservation").submit();
		}
		
		 //console.log(${reservation.restaurant.restaurantName}+"거구장~~~");
		 
	     
	    $( "body" ).on("click" , ".payment1", function() {
	    	requestPay();
		});
	    
	    $( "body" ).on("click" , ".payment2", function() {
	    	fncAddReservation();
	    	$("#modal").trigger('click');
		});
	    /* $( ".payment2" ).on("click" , function() {
	    	$("#modal");
		}); */
	    
		/////////아임포트 function//////////////////
		
		//////////이전페이지////////////////
	    $(".reset").on("click" , function() {
	    	self.location = "/reservation/listReservation"
		});
		//////////이전페이지////////////////
		
		//////////모달 이동////////////////
	    $("#yes").on("click" , function() {
	    	self.location = "/reservation/getReservation"
		});
		//////////모달 이동////////////////
		
		//////////모달 이동////////////////
	    $("#close").on("click" , function() {
	    	self.location = "/reservation/getReservation"
		});
		//////////모달 이동////////////////
		
		//////////주문 메뉴 체크////////////////
		$("#orderCheck").on("click" , function() {

			console.log( $("#orderName").val()); 
			console.log( $("#orderName option:checked").text()); 
			console.log($("#orderCount").val());
			//console.log($("#price").val());
			
	    	/* $(".order").append("<input type='hidden' name='order["+ orderCount +"].menuTitle' value='"+ 
	    			$("#orderName option:checked").text() + "'>");
	    	$(".order").append("<input type='hidden' name='order["+ orderCount +"].orderCount' value='"+ $("#orderCount").val() + "'>");
	    	$(".order").append("<input type='hidden' name='order["+ orderCount +"].menuPrice' value='"+ $("#orderName").val() + "'>"); */
	    	
	    	//
	    	var menu_order_list = "";
	    	menu_order_list += "<div class='row nbsp'>";
	    	menu_order_list += "<div class='col-md-3'>선택 메뉴 : <input type='text' name='order["+ orderCount +"].menuTitle' id='menuTitle' value='"+ 
			$("#orderName option:checked").text() + "'></div>";
			menu_order_list += "<div class='col-md-3'>메뉴 수량 : <input type='text' name='order["+ orderCount +"].orderCount' id='orderCount' value='"+ $("#orderCount").val() + "'></div>";
			menu_order_list += "<div class='col-md-3'>메뉴 가격 : <input type='text' name='order["+ orderCount +"].menuPrice' id='menuPrice' value='"+ $("#orderName").val() + "'></div>";
			menu_order_list += "<div class='col-md-2'><input type='button' id='resetCheck' name='resetCheck' value='취소' class= 'button small primary'></div>";
			menu_order_list += "</div>";
			
			//console.log(menu_order_list);
			
			$(".orderresult").append(menu_order_list);
			
			orderCount++;
	    	
	    	/* $(".orderresult").append("<p class='nbsp'><input type='text' name='order["+ orderCount +"].menuTitle' value='"+ 
	    			$("#orderName option:checked").text() + "'><input type='text' name='order["+ orderCount +"].orderCount' value='"+ $("#orderCount").val() + "'><input type='text' name='order["+ orderCount +"].menuPrice' value='"+ $("#orderName").val() + "'><input type='button' id='resetCheck' 			name='resetCheck' value='취소' class= 'button small primary'></p>"); */
	    	
	    	/* $(".orderresult").append("<p class='nbsp'><span>"+ $("#orderName option:checked").text() + 
	    	"</span> <span>" + $("#orderCount").val() + "</span> <span>" + 	$("#orderName").val() + "</span><input type='button' id='resetCheck' 			name='resetCheck' value='취소' class= 'button small primary'></p>"); */
	    	
	    	//$(".orderresult").append("<span>" + $("#orderCount").val() + "</span>");
	    	//$(".orderresult").append("<span>" + $("#orderName").val() + "</span></p>");
	    	
	    	/////////////////////////최종가격//////////////////////////
	  
	   
			
	    	var count = $("#orderCount").val();
	    	var price = $("#orderName").val();
	    	
	    	order_price_total = parseInt(order_price_total) + (parseInt(count) * parseInt(price));
		    console.log(parseInt(count) * parseInt(price));
   
		    $(".orderTotal").empty();
			$(".orderTotal").append(order_price_total);
	    	//$("#orderCount").val();
	    	
	    	 
		});
		//////////주문 메뉴 체크////////////////
		 $("body").on("click" , "#resetCheck", function() {
			 
	    	var count = $("#orderCount").val();
	    	var price = $("#orderName").val();
	    	console.log(count+"kkjjkj");
	    	console.log(price+"jjjj");
	    	
	    	
	    	var reset = $(this).parent().parent('.nbsp');
	    	var findCount = $(this).parent().parent('.nbsp').find("#orderCount").val();
	    	var findPrice = $(this).parent().parent('.nbsp').find("#menuPrice").val();
	    	console.log(findCount+"findCount~~~");
	    	console.log(findPrice+"findPrice~~~~");
	    	
	    	console.log(reset);
	    	
	    	order_price_total =parseInt(order_price_total) - (parseInt(findCount) * parseInt(findPrice));
	    	
	    	reset.remove();
	    	$(".orderTotal").empty();
			$(".orderTotal").append(order_price_total);
	    	
	 	});
		/////////결제 선택 페이지//////////////
	
       
     // 선결제 체크시 결제페이지 class 값을 2개로 나눠서 1번일시 결제페이지 2번일시 모달창이 나오도록 구현
            $("#sunPayment").click(function(){ //선결제 라디오
            	$(".payment-btn").removeClass("payment2");
            	$(".payment-btn").addClass("payment1");
            
            		console.log("sunPayment");
            });
            
          
         	$("#huPayment").click(function(){ //방문결제
                $(".payment-btn").removeClass("payment1");
                $(".payment-btn").addClass("payment2");
            		console.log("huPayment111");
            }); 
            
	///////////결제 선택 페이지////////////////////////////////////////////////////
	
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
							
							
								<div class="col-6 col-12-xsmall">
									<label for="nickname">NickName</label> 
									<p>${reservation.member.nickname}</p>
								</div>
								<div class="col-6 col-12-xsmall">
									<label for="restaurantName">음식점 명</label> 
									<p>${reservation.restaurant.restaurantName}</p>
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
									<p>${reservation.planDate}
									<!-- Button trigger modal -->
									<input type="button" value="방문 확정" class="button small primary stretched-link" id="modal" data-toggle="modal"
									data-target="#getReservationModal"/></p>
									<!-- Button trigger modal --> 
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="memberCount">방문 확정 후</label> 
									<p>${reservation.fixedDate}</p>
								</div>
								
								<div class="col-12">
									<label for="memberCount">예약 및 결제 현황</label>
									<p>${reservation.reservationStatus}</p>
								</div>
								
								
							
								<!-- Break -->
								<h3>결제정보</h3>
								
								<!-- Break -->
								<div class="col-12">
									<label for="restaurantType">예약 및 결제 일시</label> 
									<p>${reservation.restaurant.menuType}</p>
								</div>
								
								<!-- ///////////////////get 추가///////////////////////// -->
								<!-- Break -->
								<div class="col-6 col-12-xsmall">
									<label for="orderName">주문 메뉴 명, 수량</label> 
									
					                <p>	<c:forEach var="menu" items="${order.menuTitle}">
					                		<option value=${order.menuTitle}>${order.menuTitle}</option>
					                		<p>${order.orderCount}</p>
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
								
								
								<!-- Break -->
								
								
								
								
								
								
								<!-- <div class="col-12">
									<label for="demo-priority">결제 수단</label>
								</div>
								<div class="col-4 col-12-small">
									<input type="radio" id="sunPayment" name="payOption" value="2"
										checked> <label for="sunPayment">선 결제</label>
								</div>
								<div class="col-4 col-12-small">
									<input type="radio" id="huPayment" name="payOption" value="1">
									<label for="huPayment">방문 결제</label>
								</div> -->
								
								<!-- Break -->
							
								
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
								aria-labelledby="loginModalLabel" aria-hidden="true">
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