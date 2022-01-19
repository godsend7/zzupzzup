<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-addReservationView</title>

<jsp:include page="/layout/toolbar.jsp" />
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
.nbsp > span {margin-right:100px;} 
.nbsp input { border: none;  }

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		var orderCount = 0;
		var order_price_total = 0;
	
		
		console.log("addReservationView.jsp");
		////////////////////////////////////==> 유효성 체크
		function fncAddReservation(payment) {
			
			let orderName = $("#menuTitle").val();
			let orderCount = $("#orderCount").val();
			let planDate = $("input[name='planDate']").val();
			let planTime = $("input[name='planTime']").val();
		
			console.log("orderName : " + orderName);
			console.log("orderCount : " + orderCount);
			console.log("planDate : " + planDate);
			console.log("planTime : " + planTime);
			
			console.log("fncAddReservation inner payment : " + payment);
			
			
			if(orderName == null || orderName<1 || orderName == ''){
				alert("메뉴를 선택해 주세요.");
				$("#orderName").focus();
				return;
			}
			
			if(orderCount == null || orderCount<1){
				alert("수량을 선택해 주세요.");
				$("#orderCount").focus();
				return;
			}
			
			if(planDate == null || planDate<1){
				alert("날짜를 선택해 주세요.");
				$("input[name='planDate']").focus();
				return;
			}
			
			if(planTime == null || planTime<1){
				alert("시간을 선택해 주세요.");
				$("input[name='planTime']").focus();
				return;
			}
			
			$("#totalPrice").val(order_price_total);
			console.log("totalPrice~~~"+$("#totalPrice").val());
			
			if(payment == "payment1"){
				console.log("ㅎ히히");
				requestPay();
				return;
			}else if(payment == "payment2"){
				console.log("후후후");
				addReservation();
				return
			};
		}
		
		$("input[value='결제하기']").on("click", function() {
			console.log("결제하기 버튼 클릭");
			
			if($(this).hasClass("payment1")){
				console.log("payment1");
				fncAddReservation("payment1");
			}else if($(this).hasClass("payment2")){
				console.log("payment2");
				fncAddReservation("payment2");
			};
		});
		/////////아임포트 function//////////////////
		var IMP = window.IMP; // 생략가능
	    IMP.init('imp30711347');
	    function requestPay() {
	      // IMP.request_pay(param, callback) 결제창 호출
	      IMP.request_pay({ // param
	          pg: "html5_inicis",
	          pay_method: "card",
	          merchant_uid: 'merchant_' + new Date().getTime(),
	          name:  $("#restaurantName").val(),
	          amount: parseInt(order_price_total),
	          buyer_email:$("#memberId").val(),
	          buyer_name: $("#memberName").val(),
	          buyer_tel: $("#memberId").val(),
	          buyer_addr: $("#memberPhone").val(),
	          buyer_postcode: " "
	      }, function (rsp) { // callback
	    	  console.log(rsp);
	          if (rsp.success) {
	        	  var msg = '결제가 완료되었습니다.';
	              msg += '고유ID : ' + rsp.imp_uid;
	              msg += '상점 거래ID : ' + rsp.merchant_uid;
	              msg += '결제 금액 : ' + rsp.paid_amount;
	              msg += '카드 승인번호 : ' + rsp.apply_num;
	              $("#payMethod").val(rsp.imp_uid);
	  				console.log("I'mport 번호::::"+$("#payMethod").val());
	              addReservation();
	          } else {
	        	  var msg = '결제에 실패하였습니다.';
	              msg += '에러내용 : ' + rsp.error_msg;
	              alert('결제에 실패하였습니다.');
	          }
	      });
	    }

	    function addReservation() {
	    	console.log("addReservation");
		        $.ajax({
		            type : 'post',
		            url : '/reservation/addReservation',
		            data : $("#addReservation").serialize(),
		            dataType : "html",
		            success : function(data){
		                alert("결제가 완료되었습니다.");
		                $(".listReservationModal").trigger('click');
		            }
		        });
	    	console.log("success");
		}
		
		/////////아임포트 function//////////////////
		
		//////////이전페이지////////////////
	    $(".reset").on("click" , function() {
	    	self.location = "/"
		});
		//////////이전페이지////////////////
		
		//////////모달 이동////////////////
	    $("#homePage").on("click" , function() {
	    	self.location = "/"
		});
		//////////모달 이동////////////////
		
		//////////모달 이동////////////////
	    $("#listReservationPage").on("click" , function() {
	    	$("#addReservation").attr("method" , "POST").attr("action" , "/reservation/listReservation").submit();
		});
		//////////모달 이동////////////////
		
		//////////주문 메뉴 체크////////////////
		$("#orderCheck").on("click" , function() {

			console.log( $("#orderName").val()); 
			console.log( $("#orderName option:checked").text()); 
			console.log($("#orderCount").val());
	
	    	var menu_order_list = "";
	    	menu_order_list += "<div class='row nbsp'>";
	    	menu_order_list += "<div class='col-md-3'>선택 메뉴 : <input type='text' name='order["+ orderCount +"].menuTitle' id='menuTitle' value='"+ 
			$("#orderName option:checked").text() + "'></div>";
			menu_order_list += "<div class='col-md-3'>메뉴 수량 : <input type='text' name='order["+ orderCount +"].orderCount' id='orderCount' value='"+ $("#orderCount").val() + "'></div>";
			menu_order_list += "<div class='col-md-3'>메뉴 가격 : <input type='text' name='order["+ orderCount +"].menuPrice' id='menuPrice' value='"+ $("#orderName").val() + "'></div>";
			menu_order_list += "<div class='col-md-2'><input type='button' id='resetCheck' name='resetCheck' value='취소' class= 'button small primary'></div>";
			menu_order_list += "</div>";
			
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
				
				<section id="addReservationView">
					<div class="container">

						<!-- start:Form -->
						<h2 class="pl-0 mb-0">예약하기</h2>
						<div class="col-12" style="padding:0px"><hr></div>
						<form id="addReservation">
								<input type="hidden" id="payMethod" name="payMethod" value="${reservation.payMethod}">
								<input type="hidden" id="chat.chatNo" name="chat.chatNo" value="${reservation.chat.chatNo}">
								<input type="hidden" id="restaurant.restaurantNo" name="restaurant.restaurantNo" value="${reservation.restaurant.restaurantNo}">
								<%-- <input type="hidden" id="reservationDate" name="reservationDate" value="${reservation.reservationDate}"> --%>
								
								<%-- <input type="hidden" id="reservation.reservationNo" name="reservation.reservationNo" value="${reservation.reservationNo}"> --%>
							
							
							<div class="row gtr-uniform">
								<div class="col-6 col-12-xsmall">
									<label for="nickname">예약자 NickName</label> 
									<%-- <p>${reservation.member.nickname}</p> 닉네임하나만 불러올때 --%>
									<p><c:forEach var="chatMember" items="${chatMemberList}" varStatus="status">
											<c:out value = "${chatMember.member.nickname} ${status.last ? '' : '/'}"/>
										</c:forEach></p>
									<input type="hidden" id="member.memberId" name="member.memberId" value="${reservation.chat.chatLeaderId.memberId}">
								</div>
								<div class="col-6 col-12-xsmall">
									<label for="restaurantName">음식점 명</label> 
									<p>${reservation.restaurant.restaurantName}</p>
									<input id="restaurantName" type="hidden" name="restaurantName" value="${reservation.restaurant.restaurantName}">
								</div>
								<div class="col-6 col-12-xsmall">
									<label for="restaurantTel">음식점 전화번호</label> 
									<p>${reservation.restaurant.restaurantTel}</p>
									<input id="restaurantTel" type="hidden" name="restaurantTel" value="${reservation.restaurant.restaurantTel}">
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="restaurantAdress">음식점 소재지 주소</label>
									<p><span class="badge badge-info">도로명 주소</span>&nbsp;
									 ${reservation.restaurant.streetAddress}</p>
									<p><span class="badge badge-warning">지번 주소</span>&nbsp;&nbsp;&nbsp;&nbsp;
									 ${reservation.restaurant.areaAddress}</p>
									<p><span class="badge badge-success">상세 주소</span>&nbsp;&nbsp;&nbsp;&nbsp;
									 ${reservation.restaurant.restAddress}</p>
									<input id="streetAddress" type="hidden" name="streetAddress" value="${reservation.restaurant.streetAddress}">
									<input id="areaAddress" type="hidden" name="areaAddress" value="${reservation.restaurant.areaAddress}">
									<input id="restAddress" type="hidden" name="restAddress" value="${reservation.restaurant.restAddress}">
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="restaurantType">음식 종류</label> 
									<p>${reservation.restaurant.returnMenuType}</p>
									<input id="menuType" type="hidden" name="menuType" value="${reservation.restaurant.menuType}">
								</div>
								
								<div class="col-6 col-12-xsmall">
									<label for="memberCount">예약 인원 수</label> 
									<p>${reservation.chat.readyCount} 명</p>
									<input id="memberCount" type="hidden" name="memberCount" value="${reservation.chat.readyCount}">
								</div>
								
								<!-- Break -->
								<div class="col-4 col-12-small order">
									<label for="orderName">주문 메뉴 명</label> 
									<select class="form-select" id="orderName" required>
					                
					              		<option value="">선택해주세요.</option>
					                	<c:forEach var="menu" items="${reservation.restaurant.restaurantMenus}">
					                		<option value=${menu.menuPrice}>${menu.menuTitle}</option>
					                		
										</c:forEach>
					                		
					              </select>
								</div>
								<div class="col-4 col-12-small">
									<label for="orderCount">주문 메뉴 수량</label> 
									<select class="form-select" id="orderCount" value="orderCount" required>
					                <option value="">선택해주세요</option>
					                <option value="1">1</option>
					                <option value="2">2</option>
					                <option value="3">3</option>
					                <option value="4">4</option>
					                <option value="5">5</option>
					                <option value="6">6</option>
					                <option value="7">7</option>
					                <option value="8">8</option>
					                <option value="9">9</option>
					                <option value="10">10</option>
					              </select>
								</div>
								
								<div class="col-4 col-12-small">
								<label >주문 메뉴와 수량을 확인 후 체크해주세요</label> 
									<input type="button" id="orderCheck" name="orderCheck" value="메뉴 선택" class= "button small primary"> 
								</div>
								
								<div class="col-12 orderresult">
									
								</div>
								
								<div class="col-12 menutotalprice">
									<label for="orderTotal">주문 메뉴 총 가격</label>
									<div class="orderTotal"></div>
									<input id="totalPrice" name="totalPrice" type="hidden">
								</div>
								
								
								<!-- Break -->
								
								<!-- Break -->
								<div class="col-6">
									<label for="planDate">날짜 선택</label>
									<input type="date" id="planDate" name="planDate">
								</div>
								<div class="col-6">
									<label for="planTime">시간 선택</label>
					      			<input type="time" id="planTime" name="planTime">
								</div>
								
								<div class="col-md-12">
									<label for="restaurantTimes">음식점 영업 시간</label><br>
									<div>*해당 음식점 영업시간에 맞게 예약해주세요*</div><br>
								</div>
								
								<div class="col-md-12 d-flex">	 
									<c:forEach var="time" items="${reservation.restaurant.restaurantTimes}">
											<div style="flex-grow: 1;">
					                		<span>${time.returnDay}</span><br>
					                		<c:choose>
												<c:when test="${time.restaurantDayOff != true && time.returnDay != null}">
							                		<span class="badge badge-primary">OpenTime -   ${time.restaurantOpen}</span><br>
							                		<span class="badge badge-primary">CloseTime - ${time.restaurantClose}</span><br>
							                	<c:if test="${time.restaurantLastOrder != ''}">	
							                		<span class="badge badge-warning">LastOrder - ${time.restaurantLastOrder}</span><br>
							                	</c:if>	
							                	<c:if test="${time.restaurantBreak != ''}">
						                			<span class="badge badge-success">BreakTime - ${time.restaurantBreak}</span><br>
						                		</c:if>
						                		</c:when>
					                		</c:choose>
					                		<span>${time.returnDayOff}</span>
					                		
					                		</div>
										</c:forEach>
								</div>
								<!-- Break -->
								
								<h2 class="pl-4 mb-0 col-12">결제하기</h2>
								<div class="col-12 pl-4 mb-0" style="padding:0px" ><hr></div>
								
								<!-- Break -->
								<div class="col-12">
									<label for="demo-priority">결제 수단</label>
								</div>
								<div class="col-4 col-12-small">
									<input type="radio" id="sunPayment" name="payOption" value="2"
										checked> <label for="sunPayment">선 결제</label>
								</div>
								<div class="col-4 col-12-small">
									<input type="radio" id="huPayment" name="payOption" value="1">
									<label for="huPayment">방문 결제</label>
								</div>
								
								<div class="col-12">
									<ul class="actions">
										<li><input type="button" value="결제하기" class="primary payment1 payment-btn"/></li>
										<li><input type="reset" value="이전 페이지" class="normal reset" /></li>
									</ul>
								</div>
							</div>
							</form>
							
							<!-- Button trigger modal -->
							<input type="button" value="페이지 이동" class="btn btn-primary listReservationModal" id="" data-toggle="modal"
								data-target="#listReservationModal"/ style="visibility: hidden;">
							
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
												
												<h6 class="h6 mb-6 font-weight-normal">예약 및 결제가 완료되었습니다.</h6>
												
												</div>
												<input class="btn btn-lg listReservationPage" id="listReservationPage"
													type="button" value="내 예약 내역 확인하러가기" />
													
												<input class="btn btn-lg btn-primary homePage" id="homePage"
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