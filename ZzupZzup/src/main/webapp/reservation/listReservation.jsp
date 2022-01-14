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
	  	
		
	  	//////////이전페이지////////////////
	$(function() {
			
		console.log(${reservation});
		console.log("${reservation.order}");
		console.log(${reservation.restaurant});
		console.log("restaurantdfsfdsNa~~");
		
		function fncPageNavigation(currentPage) {
			
			  console.log(currentPage);
			  $("#currentPage").val(currentPage);
			  
			  var link = window.location.href;
			    console.log(link);
			    
		}
	
		/* ---------무한스크롤--------	 */
		var count = 2;
		if (${!empty list}) {
	    	window.onscroll = function() {
	    	if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
	    		if (${!empty member}) {
		    		$("#currentPage").val(count);
		    		$.ajax({
		    				url : "/reservation/json/listReservation",
		    				type : "POST",
		    				dataType : "json",
							data : {
								currentPage : $("#currentPage").val()
							},
							success : function(data) {
		    					//alert("무한스크롤 성공");
		    					console.log(data);
		    					
		    					//count++;
		    					/////////////////////////////////////
		    					var append_nod = "";
		    			    	$.each(data.list, function(index, item) {
		    			    		
		    			    		console.log(item)
		    			    		console.log("item~~~~")
		    			    		
		    			    		
		    			    	});
		    					/////////////////////////////////////
							},
							error:function(request,status,error){
						       console.log("실패");
						    }

		    		}); 
		    		
	    		}
	    	}    
	    }	
	
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
									src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"></a>
				
								<div class="card-body">
									<h3 class="card-title">${reservation.restaurant.restaurantName}</h3>
									<h4 class="text-primary card-title">예약번호<a href="/reservation/getReservation?reservationNo=${reservation.reservationNo}">${reservation.reservationNumber}</a></h4>
								
										<div class="col-md-8 nickname">
										<label for="nickname"> 예약자 NickName</label> 
									<p><c:forEach var="chatMember" items="${reservation.chat.chatMember}" varStatus="status">
											<c:out value = "${chatMember.member.nickname} ${status.last ? '' : '/'}"/>
										</c:forEach></p>
										</div>
										
										<div class="col-md-8 orderName">
										<label for="orderName">주문 메뉴 명, 수량</label> 
					              	<p>	<c:forEach var="order" items="${reservation.order}" varStatus="status">
					                		<c:out value = "${order.menuTitle} - ${order.orderCount} ${status.last ? '' : '/'}"/>
										</c:forEach> </p>
										</div>
									
										<div class="col-md-8 planDate">
										<label for="demo-name">방문 확정 전</label> 
										<p>${reservation.planDate}  ${reservation.planTime}</p>
										</div>
										
										<div class="container">
										<div class="row">
									    <div class="col-md-8 fixedDate">
									    <label for="demo-name">방문 확정 후(승인)</label> 
									    <c:choose>
											<c:when test="${reservation.reservationStatus == 1 || reservation.reservationStatus == 2}">
												<p>${reservation.fixedDate}</p> 
											</c:when>
										</c:choose>
										</div>
									    <div class="col-6 col-md-4">
									    <c:choose>
									    	<c:when test="${member.memberRole == 'user' && reservation.reviewNo != null && reservation.reservationStatus==1}">
									    		<a href="#reviewModal" class="button small primary reviewModal" data-toggle="modal" data-id="${reservation.reviewNo}">리뷰 보기</a>
									    	</c:when>
									    	
									    	<c:when test="${member.memberRole == 'user' && reservation.reviewNo == null && reservation.reservationStatus==1}">
									    		<a href="/review/addReview?reservationNo=${reservation.reservationNo}" class="button small primary stretched-link rivewWrite" name = "rivewWrite" id ="rivewWrite">리뷰 쓰기</a>
									    	</c:when>
									    </c:choose>
									    
									    
									    </div>
									  	</div> 
									  	</div>
									
										<div class="col-6 col-12-xsmall">
										<label for="demo-name">예약/결제 현황</label> 
										<p>${reservation.returnStatus}</p>
										</div>
										
									<c:choose>
										<c:when test="${member.memberRole == 'admin'}">	
										<div class="col-md-12 ownerId">
										<label for="ownerId">업주 아이디</label> 
										<p>${reservation.restaurant.member.memberId}</p>
										</div>
									</c:when>
								</c:choose>		
								</div>
							</div>
							
						</div>
						</c:forEach>
						<ul class='icons'> 
							<jsp:include page='/review/getReview.jsp'/>
						</ul>
		
					<!-- <div class="col-12 text-center thumb-more">
						<a href="#" class="icon solid fa fa-plus-circle"></a>
					</div>  -->
					<!-- end -->
					<%-- 
					<jsp:include page="../common/pageNavigator.jsp"/>
						무한스크롤 필요

					</div>
					</div> --%>
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