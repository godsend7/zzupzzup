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
	 /* 	function fncPageNavigation(currentPage) {
			   document.getElementById("currentPage").value = currentPage;
		  document.detailForm.submit(); 
		  console.log(currentPage);
		  $("#currentPage").val(currentPage);
		  $("#reservation").attr("action","/reservation/listReservation").attr("method", "POST").submit();
		}
		  */
			//////////이전페이지////////////////
			console.log(${reservation.planTime}+"시간 왜 안찍혀");
			console.log(${chat.chatLeaderId}+"닉네임 왜 안찍혀");
			console.log(${reservation.member.nickname}+"닉네임 왜 안찍혀333");
		/*  function fnclistReservation(reservationNo) {
			 
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
		}    */
		
		/* $(".reviewWrite").on("click" , function() {
	    	//self.location = "/review/addReview?reservationNo=${reservation.member.memberId}"
	    	self.location = "/review/addReview?reservationNo=1"
		}); */
		
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
									<h4 class="text-primary card-title">에약번호<a href="/reservation/getReservation?reservationNo=${reservation.reservationNo}">${reservation.reservationNumber}</a></h4>
								
										<div class="col-6 col-12-xsmall">
										<label for="nickname">참여자 NickName1111</label> 
										<p>${member.nickname}</p>
										${reservation.chat.chatLeaderId} 예약자 닉네임이아니라 로그인한 사람닉네임이 나옴 썅~~~~ 
										</div>
										
										<div class="col-6 col-12-xsmall">
										<label for="demo-name">방문 확정 전</label> 
										<p>${reservation.planDate} ${reservation.planTime}</p>
										</div>
										
										<div class="container">
										<div class="row">
									    <div class="col-md-8 fixedDate">
									    <label for="demo-name">방문 확정 후(승인)</label> 
										<p>${reservation.fixedDate} </div>
									    <div class="col-6 col-md-4">
									    <a href="#" class="button small primary stretched-link rivewWrite" name = "rivewWrite" id ="rivewWrite">리뷰 쓰기</a></div>
									  	</div> 
									  	</div>
									
										<div class="col-6 col-12-xsmall">
										<label for="demo-name">예약 및 결제 현황</label> 
										<p>${reservation.returnStatus}</p>
										</div>
								</div>
							</div>
							
						</div>
						</c:forEach>
						
		
				
				
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