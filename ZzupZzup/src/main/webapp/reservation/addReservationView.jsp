<%@page import="com.zzupzzup.service.domain.RestaurantTime"%>
<%@page import="com.zzupzzup.service.domain.RestaurantMenu"%>
<%@page import="com.zzupzzup.service.domain.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- <%@ page import="com.zzupzzup.service.domain.Reservation" %>
<%@ page import="com.zzupzzup.service.domain.Restaurant" %>
<%@ page import="com.zzupzzup.service.domain.Chat" %>
<%@ page import="com.zzupzzup.service.domain.Member" %>

<% Reservation reservation= (Reservation)session.getAttribute("reservation");%>	
<% Restaurant restaurant= (Restaurant)session.getAttribute("restaurant");%>	
<% RestaurantMenu restaurantMenu= (RestaurantMenu)session.getAttribute("restaurantMenu");%>	
<% Chat chat= (Chat)session.getAttribute("chat");%>	
<% Member member= (Member)session.getAttribute("member");%>	
<% Order order= (Order)session.getAttribute("order");%>	
<% RestaurantTime restaurantTime= (RestaurantTime)session.getAttribute("restaurantTime");%>	 --%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-template</title>

<jsp:include page="/layout/toolbar.jsp" />
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		console.log("addReservationView.jsp");
		//$("form").attr("method" , "POST").attr("action" , "/reservation/addReservation").submit();
		
		
		/////////아임포트 function//////////////////
		var IMP = window.IMP; // 생략가능
	    IMP.init('imp30711347');
	    function requestPay() {
	      // IMP.request_pay(param, callback) 결제창 호출
	      IMP.request_pay({ // param
	          pg: "html5_inicis",
	          pay_method: "card",
	          merchant_uid: 'merchant_' + new Date().getTime(),
	          name: "노르웨이 회전 의자",
	          amount: 100,
	          buyer_email: "gildong@gmail.com",
	          buyer_name: "홍길동",
	          buyer_tel: "010-4242-4242",
	          buyer_addr: "서울특별시 강남구 신사동",
	          buyer_postcode: "01181"
	      }, function (rsp) { // callback
	    	  console.log(rsp);
	          if (rsp.success) {
	        	  var msg = '결제가 완료되었습니다.';
	              msg += '고유ID : ' + rsp.imp_uid;
	              msg += '상점 거래ID : ' + rsp.merchant_uid;
	              msg += '결제 금액 : ' + rsp.paid_amount;
	              msg += '카드 승인번호 : ' + rsp.apply_num;
	              alert('결제가 완료되었습니다.');
	              $("#modal").trigger('click'); //class는 . 아이디는 #
	          } else {
	        	  var msg = '결제에 실패하였습니다.';
	              msg += '에러내용 : ' + rsp.error_msg;
	              alert('결제에 실패하였습니다.');
	          }
	      });
	    } 
	    
	    $( "body" ).on("click" , ".payment1", function() {
	    	console.log("fjdkjfd");
	    	requestPay();
		});
	    
	    $( "body" ).on("click" , ".payment2", function() {
	    	console.log("8237183");
	    	$("#modal").trigger('click');
		});
	    /* $( ".payment2" ).on("click" , function() {
	    	$("#modal");
		}); */
	    
		/////////아임포트 function//////////////////
		
		//////////이전페이지////////////////
	    $(".reset").on("click" , function() {
	    	self.location = "/main.jsp"
		});
		//////////이전페이지////////////////
		
		//////////모달 이동////////////////
	    $("#homePage").on("click" , function() {
	    	self.location = "/main.jsp"
		});
		//////////모달 이동////////////////
		
		//////////모달 이동////////////////
	    $("#ReservationPage").on("click" , function() {
	    	self.location = "/reservation/addReservationView"
		});
		//////////모달 이동////////////////
		
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
				
				<section id="addReservationView">
					<div class="container">

						<!-- start:Form -->
						<h3>예약하기</h3>
					
						<form name="addReservation" method="post" action="/addReservation">
						<input type="hidden" name="chatNo" value="${reservation.chat.chatNo}" />
						<input type="hidden" name="restaurantNo" value="${reservation.restaurant.restaurantNo}" />
						<input type="hidden" name="reservationNo" value="${reservation.reservationNo}" />
							<div class="row gtr-uniform">
								<div class="col-6 col-12-xsmall">
									<label for="demo-name">NickName</label> 
									<p>${chat.getChatLeaderId(member.getNickname())}</p>
								</div>
								<div class="col-6 col-12-xsmall">
									<label for="restaurantName">음식점 명</label> 
									<p>${restaurant.restaurantName}</p>
								</div>
								<div class="col-6 col-12-xsmall">
									<label for="restaurantPhone">음식점 전화번호</label> 
									<p>${restaurant.restaurantTel}</p>
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="restaurantAdress">음식점 소재지 주소</label> 
									<p>${restaurant.streetAddress}</p>
									<p>${restaurant.areaAddress}</p>
									<p>${restaurant.restAddress}</p>
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="restaurantType">음식 종류</label> 
									<p>${restaurant.menuType}</p>
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="memberCount">예약 인원 수</label> 
									<p>${reservation.memberCount} 명</p>
								</div>
								
								<!-- Break -->
								<div class="col-4 col-12-small">
									<label for="orderName">주문 메뉴 명</label> 
									<select class="form-select" id="orderName" required>
					                <option value="">${order.menuTitle}</option>
					                <option>United States</option>
					              </select>
								</div>
								<div class="col-4 col-12-small">
									<label for="orderCount">주문 메뉴 수량</label> 
									<select class="form-select" id="orderCount" required>
					                <option value="">${order.orderCount}</option>
					                <option>United States</option>
					              </select>
								</div>
								
								<div class="col-4 col-12-small">
								<label >주문 메뉴와 수량을 확인 후 체크해주세요</label> 
									<input type="checkbox" id="demo-copy" name="demo-copy"> <label
										for="demo-copy"></label>
								</div>
								<!-- Break -->
								
								<!-- Break -->
								<div class="col-6">
									<label for="date">날짜 선택</label>
									<input type="date" id="date">
								</div>
								<div class="col-6">
									<label for="time">시간 선택</label>
					      			<input type="time" id="time">
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="demo-memberCount">음식점 영업 시간</label> 
									<%-- <p><%=restaurant.getRestaurantNo(restaurantTime) %></p> --%>
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="demo-memberCount"></label> 
									<p></p>
								</div>
								<!-- Break -->
								<h3>결제하기</h3>
								
								<!-- Break -->
								<div class="col-12">
									<label for="demo-priority">결제 수단</label>
								</div>
								<div class="col-4 col-12-small">
									<input type="radio" id="sunPayment" name="demo-priority"
										checked> <label for="sunPayment">선 결제</label>
								</div>
								<div class="col-4 col-12-small">
									<input type="radio" id="huPayment" name="demo-priority">
									<label for="huPayment">방문 결제</label>
								</div>
								
								<!-- Break -->
							
								
								<script type="text/javascript"></script>
							 
							 
					
								
								<script>
								
								
							    </script>
								
								<!-- Break -->
								
								<div class="col-12">
									<ul class="actions">
										<li><input type="button" value="결제하기" class="primary payment1 payment-btn"/></li>
										<li><input type="reset" value="이전 페이지" class="normal reset" /></li>
									</ul>
								</div>
							</div>
							
							
							<!-- Button trigger modal -->
							<input type="button" value="페이지 이동" class="btn btn-primary" id="modal" data-toggle="modal"
								data-target="#listReservationModal"/>
							
							<!-- Modal -->
							<div class="modal fade" id="listReservationModal" tabindex="-1" role="dialog"
								aria-labelledby="loginModalLabel" aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h2 class="modal-title" id="loginModalLabel">회원 로그인</h2>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div> 
										<div class="modal-body">
											<form class="form-signin">
												
												<h6 class="h6 mb-6 font-weight-normal">닉네임 예약 및 결제가 완료되었습니다.</h6>
												
												</div>
												<input class="btn btn-lg ReservationPage" id="listReservationPage"
													type="button" value="내 예약 내역 확인하러가기" />
													
												<input class="btn btn-lg btn-primary homePage" id="mainPage"
													type="button" value="홈" />	
												
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