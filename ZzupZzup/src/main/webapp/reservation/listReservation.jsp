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
.orderBox { text-overflow: ellipsis; white-space: nowrap; overflow: hidden; }
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
		let count = 2;
		$(window).on("scroll", function(){
			
			let scrTop = $(window).scrollTop();
			let scrBtm = $(document).height() - $(window).height() - $(window).scrollTop();
			let currentPage = $("#currentPage").val();
			$("#currentPage").val(count);
			//console.log("top : " + scrTop);
			//console.log("bottom : " + scrBtm);
			//console.log("count : " + count);
			if(scrBtm <= 0 ){
				console.log("바닥이야");
				//console.log($("#chatForm"));
				//console.log($("#searchKeyword").val());
				let queryStr = $("#reservationForm").serialize();
				console.log(queryStr);
				
				//////////////////////////////////
	    		$.ajax({
	    				url : "/reservation/json/listReservation",
	    				type : "POST",
	    				dataType : "json",
	    				data: queryStr,
						success : function(data) {
	    					alert("무한스크롤 성공");
	    					console.log(data);
	    				
		    				let dom ='';
							$.each(data.list, function(index, item){
								console.log(item);
								dom += '<div class="col-md-4">'
									+'<div class="card mb-4 shadow-sm">'
									+'<a href="" class="thumb">'
									+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"></a>'
								////////////////여기서부터 내가/////////////////
									+'<div class="card-body">'
									+'<h3 class="card-title">'+item.restaurant.restaurantName+'</h3>'
									+'<h4 class="text-primary card-title">예약번호<a href="/reservation/getReservation?reservationNo='+item.reservationNo+'">'+item.reservationNumber+'</a></h4>'
									+'<div class="col-md-8 nickname">'
									+'<label for="nickname"> 예약자 NickName</label>'
									/////////////foreach문 어케하지????////////////
									+'<p>';
									
									var total = item.chat.chatMember.length;
									$.each(item.chat.chatMember, function(status, itemm){
										dom += itemm.member.nickname;
										if (index !== total-1) {
											dom += " / ";
										}else if (index === total-1) {
											dom += " ";
										}
									});
									
									dom += '</p>'
									+'</div>'
									+'<div class="col-md-8 orderName">'
									+'<label for="orderName">주문 메뉴 명, 수량</label>' 
					              	+'<p class="orderBox">';
					              	////////////////////////////
					              	var total2 = item.order.length;
					              	console.log(total2);
					              	$.each(item.order, function(status, itemm){
										dom += itemm.menuTitle+' - '+itemm.orderCount;
										if (index !== total-1) {
											dom += " / ";
										}
									});
					              	
									dom +='</p>'
									+'</div>'
									/////////////////////////
									
									+'<div class="col-md-8 planDate">'
									+'<label for="demo-name">방문 확정 전</label>'
									+'<p>'
									+item.planDateString+' '+item.planTime
									+'</p>'
									+'</div>'
									+'<div class="container">'
									+'<div class="row">'
									+'<div class="col-md-8 fixedDate">'
									+'<label for="demo-name">방문 확정 후(승인)</label>';
									////////////////choose////////////////////
									if(item.reservationStatus == 1 || item.reservationStatus == 2){
											dom +='<p>'+item.fixedDate+'</p>';
									}
									
									dom += '</div> <div class="col-6 col-md-4">';
									
									console.log(item.member);
									console.log("item.member!!!!!");
									if(item.member.memberRole == 'user' && item.reviewNo != null && item.reservationStatus==1){
										dom +='<a href="#reviewModal" class="button small primary reviewModal" data-toggle="modal" data-id="'+item.reviewNo+'">리뷰 보기</a>';
									} else if(item.member.memberRole == 'user' && item.reviewNo == null && item.reservationStatus==1){
											dom +='<a href="/review/addReview?reservationNo='+item.reservationNo+'" class="button small primary stretched-link rivewWrite" name = "rivewWrite" id ="rivewWrite">리뷰 쓰기</a>';
									}
									
									////////////////choose////////////////////  
									dom +='</div>'
									 +'</div>' 
									 +'</div>'
									+'<div class="col-6 col-12-xsmall">'
									+'<label for="demo-name">예약/결제 현황</label>' 
									+'<p>'
									+item.returnStatus
									+'</p>'
									+'</div>';
					////////////////choose////////////////////  	
									if(${member.memberRole == 'admin'}){
										dom +='<div class="col-md-12 ownerId">'
											+'<label for="ownerId">업주 아이디</label> '
											+'<p>'
											+item.restaurant.member.memberId
											+'</p>'
											+'</div>';
								}
				////////////////choose////////////////////  
									dom +='</div>'
									+'</div>'
									+'</div>';
									
							});
							console.log(dom);
							$(".thumb-list").append(dom);
							if(data.length != 0){
								count++;
							}else{
								if(!$("#listReservation .alert").length){
									alert_dom = '<div class="alert alert-danger alert-dismissible" role="alert"><strong>스크롤 중지!</strong> 리스트가 더 존재하지 않습니다.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>	</div>';							
									$("#listReservation").append(alert_dom);
									$("#listReservation .alert").fadeIn();
								}
							}



						},
						error:function(request,status,error){
					       console.log("실패");
					    }

	    		}); 
				/////////////////////////////////////////////////////
			}
		});
		/* ---------무한스크롤--------	 */
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
					<!-- S:Search -->
						<form id="reservationForm" name="reservationForm">
							<div class="container">
								<div class="row search-box gtr-uniform">
									<div class="col-md-4 col-sm-12">
										
										<div class="dropmenu float-left mr-2">
											<a href="" class="button normal icon solid fa-sort dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">정렬</a>
											<div class="dropmenu-list" aria-labelledby="dropmenuList">
												<a class="dropmenu-item search-sort" href="#" data-sort="latest">최신순</a>
												<a class="dropmenu-item search-sort" href="#" data-sort="oldest">오래된 순</a>
												<input type="hidden" name="searchSort" value="">
											</div>
										</div>
										<div class="dropmenu float-left">
											<a href="" class="button normal icon solid fa-filter dropmenu-btn" id="dropdownMenuLink" data-toggle="dropmenu">필터</a>
											
											<div class="dropmenu-list" aria-labelledby="dropmenuList">
												<input type="checkbox" id="filterMy" class="search-filter" name="searchFilter" value="11"><label for="filterMy">내가 참여중인 채팅방</label>
												<input type="checkbox" id="chatAge1" class="search-filter" name="searchFilter" value="1"><label for="chatAge1">10대</label>
												<input type="checkbox" id="chatAge2" class="search-filter" name="searchFilter" value="2"><label for="chatAge2">20대</label>
												<input type="checkbox" id="chatAge3" class="search-filter" name="searchFilter" value="3"><label for="chatAge3">30대</label>
												<input type="checkbox" id="chatAge4 " class="search-filter" name="searchFilter" value="4"><label for="chatAge4">40대</label>
												<input type="checkbox" id="chatAge5" class="search-filter" name="searchFilter" value="5"><label for="chatAge5">50대</label>
												<input type="checkbox" id="chatAge6" class="search-filter" name="searchFilter" value="6"><label for="chatAge6">60대 이상</label>
												<input type="checkbox" id="chatAge7" class="search-filter" name="searchFilter" value="7"><label for="chatAge7">연령대 무관</label>
												<input type="checkbox" id="male" class="search-filter" name="searchFilter" value="8"><label for="male">남자</label>
												<input type="checkbox" id="female" class="search-filter" name="searchFilter" value="9"><label for="female">여자</label>
												<input type="checkbox" id="malefemale" class="search-filter" name="searchFilter" value="10"><label for="malefemale">성별 무관</label>
											</div>
										</div>
									</div>
									<div class="col-md-6 col-sm-12 d-flex">
										<select id="searchCondition" name="searchCondition">
											<option value="0"
												${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>음식점명</option>
											<option value="1"
												${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>음식점주소</option>
										</select> <input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어" autocomplete="off" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
										<a href="#" class="button primary icon solid fa-search search-btn"></a>

										<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
										<input type="hidden" id="currentPage" name="currentPage" value="1" />
									</div>
									<div class="col-md-2 d-flex justify-content-end">
										<a href="" class="button svg-btn" ><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
</svg>작성하기</a>
									</div>
								</div>
							</div>
						</form>
						<!-- E:Search -->
							
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
					              	<p class="orderBox">	<c:forEach var="order" items="${reservation.order}" varStatus="status">
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