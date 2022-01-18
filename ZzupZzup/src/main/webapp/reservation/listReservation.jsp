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
#listReservation .thumb-list .card .card-body label { margin-bottom: 0px; }
#listReservation .thumb-list .card .card-body p { color: #999; }
.orderBox { text-overflow: ellipsis; white-space: nowrap; overflow: hidden; }

.nicknameBox { text-overflow: ellipsis; white-space: nowrap; overflow: hidden; }

.restaurantNameBox { text-overflow: ellipsis; white-space: nowrap; overflow: hidden; }

.reservationStatusBox { height:24.2px }
.fixedDateBox { height:24.2px }
.reviewBtn { height:36.39px }

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	function fncPageNavigation(currentPage) {
		
		  console.log("커런트 페이지 : "+currentPage);
		  $("#currentPage").val(currentPage);
		  if("${member.memberRole}" == "owner"){
		  	$("#reservationForm").attr("method", "POST").attr("action", "/reservation/listMyReservation").submit();
		  	}else{
			  	$("#reservationForm").attr("method", "POST").attr("action", "/reservation/listReservation").submit();
				  
			}
		  //var link = window.location.href;
		  //console.log(link);
		    
	}
		
	  	//////////이전페이지////////////////
	$(function() {

		var fixed = "${reservation.fixedDate}";
		var fixedDateSlice = fixed.slice(0,-5);
		//$(".fixedDate").find("p").text(fixedDateSlice);
		
		console.log(${reservation});
		console.log("${reservation.order}");
		console.log(${reservation.restaurant});
		console.log("restaurantdfsfdsNa~~");
		
		//============= "검색"  Event  처리 =============
		$(".search-btn").on("click", function() {
			fncPageNavigation(1);
		});
		
		//============= 페이지 로딩시 필터 조건이 있다면 표시 ========
		if("${search.searchFilter}" != null && "${search.searchFilter}" != ""){
			//console.log("필터 조건?? ${search.searchFilter}");
			$("input:checkbox[value=${search.searchFilter}]").prop("checked", true);
			$("input:checkbox[value=${search.searchFilter}]").addClass("active");
		}
		
		//필터 클릭
		$("input:checkbox[name='searchFilter']").on("click", function(e){
			//console.log("클릭함");
			let isActive = $(this).hasClass("active");
			if(isActive){
				$("input:checkbox[name='searchFilter']").prop("checked", false);
				$("input:checkbox[name='searchFilter']").removeClass("active");
			}else{
				$("input:checkbox[name='searchFilter']").prop("checked", false);
				$("input:checkbox[name='searchFilter']").removeClass("active");
				$(this).prop("checked", true);
				$(this).addClass("active");
				fncPageNavigation(1);
			}
		});
		//필터 클릭
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
			if(scrBtm <= 1 ){
				console.log($("#reservationForm"));
				console.log($("#searchKeyword").val());
				let queryStr = $("#reservationForm").serialize();
				console.log(queryStr);
				/////////////////////////////
				
				
				//////////////////////////////////
	    		$.ajax({
	    				url : "/reservation/json/listReservation",
	    				type : "POST",
	    				dataType : "json",
	    				data: queryStr,
						success : function(data) {
		    				let dom ='';
							$.each(data.list, function(index, item){
								console.log(item);
								dom += '<div class="col-md-4">'
									+'<div class="card mb-4 shadow">'
									+'<a href="" class="thumb">'
									+'<img src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"></a>'
									+'<div class="card-body">'
									+'<h3 class="card-title">'+item.restaurant.restaurantName+'</h3>'
									+'<h4 class="text-primary card-title">예약번호 <a href="/reservation/getReservation?reservationNo='+item.reservationNo+'">'+item.reservationNumber+'</a></h4>'
									+'<div class="col-md-12 nickname">'
									+'<label for="nickname"> 예약자 NickName</label>'
									+'<p class="nicknameBox">';
									
									var total = item.chat.chatMember.length;
									$.each(item.chat.chatMember, function(indexx, itemm){
										dom += itemm.member.nickname;
										if (indexx !== total-1) {
											dom += " / ";
										}else if (indexx ===total){
											dom += "  ";
										}
									});
									dom += '</p>'
									+'</div>'
									+'<div class="col-md-12 orderName">'
									+'<label for="orderName">주문 메뉴 명, 수량</label>' 
					              	+'<p class="orderBox">';
					              	var total2 = item.order.length;
					              	$.each(item.order, function(indexxx, itemmm){
										dom += itemmm.menuTitle+' - '+itemmm.orderCount;
										if (indexxx !== total2-1) {
											dom += " / ";
										}else if (indexxx ===total2){
											dom += " ";
										}
									});
									dom +='</p>'
									+'</div>'
									+'<div class="col-md-12 planDate">'
									+'<label for="demo-name">방문 확정 전</label>'
									+'<p>'
									+item.planDateString+' '+item.planTime
									+'</p>'
									+'</div>'
									+'<div class="col-md-12 fixedDate">'
									+'<label for="demo-name">방문 확정 후(승인)</label>'
									+'<p class="fixedDateBox">';
									if(item.reservationStatus == 1 || item.reservationStatus == 2){
											dom += item.returnFixedDate
									}
									dom +='</p>' 
									+'</div>'
									+'<div class="col-md-12">'
									+'<label for="demo-name">예약/결제 현황</label>' 
									+'<p class="reservationStatusBox">'
									+item.returnStatus
									+'</p>'
									+'</div>';
									if(${member.memberRole == 'admin'}){
										dom +='<div class="col-md-12 ownerId">'
											+'<label for="ownerId">업주 아이디</label> '
											+'<p>'
											+item.restaurant.member.memberId
											+'</p>'
											+'</div>';
									}
									dom +='<div class="col-md-12 reviewBtn">';
									if(item.member.memberRole == 'user' && item.reviewNo != null && item.reservationStatus==1){
										dom +='<a href="#reviewModal" class="button small fit primary reviewModal" data-toggle="modal" data-id="'+item.reviewNo+'">리뷰 보기</a>';
									} else if(item.member.memberRole == 'user' && item.reviewNo == null && item.reservationStatus==1){
										dom +='<a href="/review/addReview?reservationNo='+item.reservationNo+'" class="button small fit primary stretched-link rivewWrite" name = "rivewWrite" id ="rivewWrite">리뷰 쓰기</a>';
									}
									dom +='</div>'
									+'</div>'
									+'</div>'
									+'</div>';
							});
							$(".thumb-list").append(dom);
							if(data.list.length != 0){
								count++;
							}else{
								if(!$("#listReservation .alert").length){
									alert_dom = '<div class="alert alert-danger alert-dismissible thumb-list-alert" role="alert">리스트가 더 존재하지 않습니다.<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>	</div>';							
									$("#listReservation").append(alert_dom);
									$("#listReservation .alert").fadeIn();
								}
							}

						},
						error:function(request,status,error){
					       console.log("실패");
					    }

	    		}); 
			}
		});
		/* ---------무한스크롤--------	 */
		//////////////////정렬 클릭//////////////////////
		$(".search-sort").on("click", function(e){
			e.preventDefault();
			let sortType = $(this).attr("data-sort");
			console.log(sortType);
			
			//let localStorage = window.localStorage;
			//localStorage.setItem('sortType', sortType);
			
			//$("input[name=searchSort]").val(localStorage.getItem('sortType'));
			$("input[name=searchSort]").val(sortType);
			//console.log(localStorage.getItem('sortType'));
			fncPageNavigation(1);
		});
	//////////////////정렬 클릭//////////////////////
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
												<input type="checkbox" id="payMent1" class="search-filter" name="searchFilter" value="1"><label for="payMent1">결제완료(방문 결제)</label>
												<input type="checkbox" id="payMent2" class="search-filter" name="searchFilter" value="2"><label for="payMent2">결제완료(선 결제)</label>
												<hr class="dropdown-divider">
												<input type="checkbox" id="visit1" class="search-filter" name="searchFilter" value="3"><label for="visit1">방문완료</label>
												<input type="checkbox" id="visit2" class="search-filter" name="searchFilter" value="4"><label for="visit2">미방문</label>
												<hr class="dropdown-divider">
												<input type="checkbox" id="canCel1" class="search-filter" name="searchFilter" value="5"><label for="canCel1">예약 취소</label>
												<input type="checkbox" id="canCel2" class="search-filter" name="searchFilter" value="6"><label for="canCel2">예약 거절</label>
											</div>
										</div>
									</div>
									<div class="col-md-6 col-sm-12 d-flex">
										<select id="searchCondition" name="searchCondition">
											<option value="1"
												${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>예약 번호</option>	
										</select> <input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어" autocomplete="off" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
										<a href="#" class="button primary icon solid fa-search search-btn"></a>

										<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
										<input type="hidden" id="currentPage" name="currentPage" value="1" />
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
								<div class="card mb-4 shadow">
									<a href="" class="thumb"><img
										src="https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg"></a>
					
									<div class="card-body">
										<h3 class="card-title restaurantNameBox">${reservation.restaurant.restaurantName}</h3>
										<h4 class="text-primary card-title">예약번호 <a href="/reservation/getReservation?reservationNo=${reservation.reservationNo}">${reservation.reservationNumber}</a></h4>
										<div class="col-md-12 nickname">
											<label for="nickname"> 예약자 NickName</label> 
											<p class="nicknameBox">
												<c:forEach var="chatMember" items="${reservation.chat.chatMember}" varStatus="status">
													<c:out value = "${chatMember.member.nickname} ${status.last ? '' : '/'}"/>
												</c:forEach>
											</p>
										</div>
										
										<div class="col-md-12 orderName">
											<label for="orderName">주문 메뉴 명, 수량</label>
											<p class="orderBox">
												<c:forEach var="order" items="${reservation.order}" varStatus="status">
						                			<c:out value = "${order.menuTitle} - ${order.orderCount} ${status.last ? '' : '/'}"/>
						                		</c:forEach>
						                	</p>
										</div>
										
										<div class="col-md-12 planDate">
											<label for="demo-name">방문 확정 전</label> 
											<p>${reservation.planDate}  ${reservation.planTime}</p>
										</div>
										
										<div class="col-md-12 fixedDate">
										    <label for="demo-name">방문 확정 후(승인)</label> 
										    <p class="fixedDateBox">
										    	<c:choose>
													<c:when test="${reservation.reservationStatus == 1 || reservation.reservationStatus == 2}">
														${reservation.returnFixedDate}
													</c:when>
												</c:choose>
											</p> 
										</div>
										
										<div class="col-md-12">
											<label for="demo-name">예약/결제 현황</label> 
											<p class="reservationStatusBox">${reservation.returnStatus}</p>
										</div>
											
										<c:choose>
											<c:when test="${member.memberRole == 'admin'}">	
												<div class="col-md-12 ownerId">
													<label for="ownerId">업주 아이디</label> 
													<p>${reservation.restaurant.member.memberId}</p>
												</div>
											</c:when>
										</c:choose>	
										
										<div class="col-md-12 reviewBtn">
										    <c:choose>
										    	<c:when test="${member.memberRole == 'user' && reservation.reviewNo != null && reservation.reservationStatus==1}">
										    		<a href="#reviewModal" class="button small fit primary reviewModal" data-toggle="modal" data-id="${reservation.reviewNo}">리뷰 보기</a>
										    	</c:when>
										    	
										    	<c:when test="${member.memberRole == 'user' && reservation.reviewNo == null && reservation.reservationStatus==1}">
										    		<a href="/review/addReview?reservationNo=${reservation.reservationNo}" class="button small fit primary stretched-link rivewWrite" name = "rivewWrite" id ="rivewWrite">리뷰 쓰기</a>
										    	</c:when>
											</c:choose>
										</div>	
									</div>
								</div>
							</div>
						</c:forEach>
						<ul class='icons'> 
							<jsp:include page='/review/getReview.jsp'/>
						</ul>
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