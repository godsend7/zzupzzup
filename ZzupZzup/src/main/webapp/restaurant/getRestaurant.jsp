<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>${restaurant.restaurantName}</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>

</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

	window.onload = function(){
		$(function() {
			// 목록으로 버튼
			$("button.btn.btn-warning").on("click", function() {
				history.go(-1);
			});
			
			// 삭제하기 버튼
			$("button.btn.btn-link").on("click", function() {
				if(confirm('정말로 삭제하시겠습니까? 확실해요??')) {
					self.location = "/restaurant/deleteRestaurant?restaurantNo=${restaurant.restaurantNo}"
					/* $("#restaurant").attr("method", "POST").attr("action","/restaurant/deleteRestaurant").submit(); */
				}
			});
		});
		
		// carousel prev & next
		$("#car_prev").click(function(){
			$("#carouselExampleFade").carousel("prev");
		});
		
		$("#car_next").click(function(){
			$("#carouselExampleFade").carousel("next");
		});
	}
	
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
				
				<section id="restaurant">
					<div class="container">
					
					<c:if test="${restaurant.reservationStatus = true}">
						<span class="badge badge-info" id="plus">예약 및 결제 가능</span>
					</c:if>
					<div class="row">
						<div class="col-md-6">
							<h1 class="text-warning">${restaurant.restaurantName}&nbsp;<small style="color:gray;">${restaurant.returnMenuType}</small></h1>
						</div>
						<div class="col-md-6" style="text-align:right;">
							<button type="button" class="btn btn-outline-link btn-sm" style="border: none; outline: none; box-shadow: none;">
                			<svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="currentColor" class="bi bi-bookmark-star" viewBox="0 0 16 16">
  							<path d="M7.84 4.1a.178.178 0 0 1 .32 0l.634 1.285a.178.178 0 0 0 .134.098l1.42.206c.145.021.204.2.098.303L9.42 6.993a.178.178 0 0 0-.051.158l.242 1.414a.178.178 0 0 1-.258.187l-1.27-.668a.178.178 0 0 0-.165 0l-1.27.668a.178.178 0 0 1-.257-.187l.242-1.414a.178.178 0 0 0-.05-.158l-1.03-1.001a.178.178 0 0 1 .098-.303l1.42-.206a.178.178 0 0 0 .134-.098L7.84 4.1z"/>
  							<path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5V2zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1H4z"/>
							</svg></button>
						</div>
					</div><hr>
					
					<div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel">
					  <div class="carousel-inner">
					  	<c:if test="${!empty restaurant.restaurantImage}">
						  	<c:forEach var="image" items="${restaurant.restaurantImage}" varStatus="status">
						  		<c:choose>
						  			<c:when test="${status.index == 0}">
						  				<div class="carousel-item active">
						  					<img src="/resources/images/uploadImages/${image}" height="600" class="d-block w-100">
						  				</div>
						  			</c:when>
						  			<c:otherwise>
						  				<div class="carousel-item">
						  					<img src="/resources/images/uploadImages/${image}" height="600" class="d-block w-100">
						  				</div>
						  			</c:otherwise>
						  		</c:choose>
						  			<%-- <img src="/resources/images/uploadImages/${image}" height="600" class="d-block w-100"> --%>	
						  	</c:forEach>
						  </c:if>	
						  <c:if test="${empty restaurant.restaurantImage}">
						  	<div class="carousel-item active">
						  		<img src="/resources/images/uploadImages/default.jpg" height="600" class="d-block w-100">
						  	</div>
						  </c:if>	
					  </div>
					  <button class="carousel-control-prev" type="button" id="car_prev" data-target="#carouselExampleFade" data-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="sr-only">Previous</span>
					  </button>
					  <button class="carousel-control-next" type="button" id="car_next" data-target="#carouselExampleFade" data-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="sr-only">Next</span>
					  </button>
					</div><br><br>
					
					<div class="row">
		  				<div class="col-xs-4 col-md-2">
		  				<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone" viewBox="0 0 16 16">
  						<path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z"/>
						</svg> 전화번호</strong></div>
						<div class="col-xs-8 col-md-4">${restaurant.restaurantTel}</div>
					</div><br><br>
					
					<div class="row col-xs-4">
		  				<div class="col-md-2">
		  					<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt" viewBox="0 0 16 16">
  							<path d="M12.166 8.94c-.524 1.062-1.234 2.12-1.96 3.07A31.493 31.493 0 0 1 8 14.58a31.481 31.481 0 0 1-2.206-2.57c-.726-.95-1.436-2.008-1.96-3.07C3.304 7.867 3 6.862 3 6a5 5 0 0 1 10 0c0 .862-.305 1.867-.834 2.94zM8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10z"/>
 							<path d="M8 8a2 2 0 1 1 0-4 2 2 0 0 1 0 4zm0 1a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
							</svg> 위치</strong></div>
						<div class="col-md-3"><span class="badge badge-secondary">도로명주소</span> ${restaurant.streetAddress}</div>
						<div class="col-md-3"><span class="badge badge-secondary">지번주소</span> ${restaurant.areaAddress}</div>
						<c:if test="${empty restaurant.restAddress}">
							
						</c:if>
						<c:if test="${!empty restaurant.restAddress}">
							<div class="col-md-3"><span class="badge badge-secondary">상세주소</span> ${restaurant.restAddress}</div>
						</c:if>
					</div><br><br>
					
					<div class="row">
						<div class="col-xs-4 col-md-2">
							<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-alarm" viewBox="0 0 16 16">
  							<path d="M8.5 5.5a.5.5 0 0 0-1 0v3.362l-1.429 2.38a.5.5 0 1 0 .858.515l1.5-2.5A.5.5 0 0 0 8.5 9V5.5z"/>
  							<path d="M6.5 0a.5.5 0 0 0 0 1H7v1.07a7.001 7.001 0 0 0-3.273 12.474l-.602.602a.5.5 0 0 0 .707.708l.746-.746A6.97 6.97 0 0 0 8 16a6.97 6.97 0 0 0 3.422-.892l.746.746a.5.5 0 0 0 .707-.708l-.601-.602A7.001 7.001 0 0 0 9 2.07V1h.5a.5.5 0 0 0 0-1h-3zm1.038 3.018a6.093 6.093 0 0 1 .924 0 6 6 0 1 1-.924 0zM0 3.5c0 .753.333 1.429.86 1.887A8.035 8.035 0 0 1 4.387 1.86 2.5 2.5 0 0 0 0 3.5zM13.5 1c-.753 0-1.429.333-1.887.86a8.035 8.035 0 0 1 3.527 3.527A2.5 2.5 0 0 0 13.5 1z"/>
							</svg> 영업시간</strong></div>
		  				<div class="col-xs-8 col-md-10">
		  					<!-- ************* 월요일 ************* -->
		  					<div class="col">
								<c:if test="${restaurant.restaurantTimes[0].restaurantDayOff eq 'true'}">
									월요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[0].restaurantDayOff eq 'false'}">
									월요일 | ${restaurant.restaurantTimes[0].restaurantOpen} ~ ${restaurant.restaurantTimes[0].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[0].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[0].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[0].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[0].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[0].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[0].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
							
							<!-- ************* 화요일 ************* -->
							<div class="col">
								<c:if test="${restaurant.restaurantTimes[1].restaurantDayOff eq 'true'}">
									화요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[1].restaurantDayOff eq 'false'}">
									화요일 | ${restaurant.restaurantTimes[1].restaurantOpen} ~ ${restaurant.restaurantTimes[1].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[1].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[1].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[1].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[1].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[1].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[1].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
							
							<!-- ************* 수요일 ************* -->
							<div class="col">
								<c:if test="${restaurant.restaurantTimes[2].restaurantDayOff eq 'true'}">
									수요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[2].restaurantDayOff eq 'false'}">
									수요일 | ${restaurant.restaurantTimes[2].restaurantOpen} ~ ${restaurant.restaurantTimes[2].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[2].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[2].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[2].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[2].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[2].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[2].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
							
							<!-- ************* 목요일 ************* -->
							<div class="col">
								<c:if test="${restaurant.restaurantTimes[3].restaurantDayOff eq 'true'}">
									목요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[3].restaurantDayOff eq 'false'}">
									목요일 | ${restaurant.restaurantTimes[3].restaurantOpen} ~ ${restaurant.restaurantTimes[3].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[3].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[3].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[3].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[3].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[3].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[3].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
							
							<!-- ************* 금요일 ************* -->
							<div class="col">
								<c:if test="${restaurant.restaurantTimes[4].restaurantDayOff eq 'true'}">
									금요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[4].restaurantDayOff eq 'false'}">
									금요일 | ${restaurant.restaurantTimes[4].restaurantOpen} ~ ${restaurant.restaurantTimes[4].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[4].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[4].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[4].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[4].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[4].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[4].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
							
							<!-- ************* 토요일 ************* -->
							<div class="col">
								<c:if test="${restaurant.restaurantTimes[5].restaurantDayOff eq 'true'}">
									토요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[5].restaurantDayOff eq 'false'}">
									토요일 | ${restaurant.restaurantTimes[5].restaurantOpen} ~ ${restaurant.restaurantTimes[5].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[5].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[5].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[5].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[5].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[5].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[5].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
							
							<!-- ************* 일요일 ************* -->
							<div class="col">
								<c:if test="${restaurant.restaurantTimes[6].restaurantDayOff eq 'true'}">
									일요일 휴무
								</c:if>
								<c:if test="${restaurant.restaurantTimes[6].restaurantDayOff eq 'false'}">
									일요일 | ${restaurant.restaurantTimes[6].restaurantOpen} ~ ${restaurant.restaurantTimes[6].restaurantClose}
									<c:if test="${empty restaurant.restaurantTimes[6].restaurantBreak}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[6].restaurantBreak}">
										, break at ${restaurant.restaurantTimes[6].restaurantBreak}
									</c:if>
									<c:if test="${empty restaurant.restaurantTimes[6].restaurantLastOrder}">
										
									</c:if>
									<c:if test="${!empty restaurant.restaurantTimes[6].restaurantLastOrder}">
										, LastOrder Time is ${restaurant.restaurantTimes[6].restaurantLastOrder}
									</c:if>
								</c:if>
							</div>
						</div>
					</div><br><br>
					
					<div class="row">
		  				<div class="col-xs-4 col-md-2">
		  					<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-basket" viewBox="0 0 16 16">
  							<path d="M5.757 1.071a.5.5 0 0 1 .172.686L3.383 6h9.234L10.07 1.757a.5.5 0 1 1 .858-.514L13.783 6H15a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1v4.5a2.5 2.5 0 0 1-2.5 2.5h-9A2.5 2.5 0 0 1 1 13.5V9a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h1.217L5.07 1.243a.5.5 0 0 1 .686-.172zM2 9v4.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V9H2zM1 7v1h14V7H1zm3 3a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3A.5.5 0 0 1 4 10zm2 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3A.5.5 0 0 1 6 10zm2 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3A.5.5 0 0 1 8 10zm2 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3a.5.5 0 0 1 .5-.5zm2 0a.5.5 0 0 1 .5.5v3a.5.5 0 0 1-1 0v-3a.5.5 0 0 1 .5-.5z"/>
  							</svg> 음식점 메뉴</strong></div>
						<div class="col-xs-8 col-md-4">${restaurant.restaurantMenus[0].menuTitle} ${restaurant.restaurantMenus[0].menuPrice}원 &nbsp;
							<c:if test="${restaurant.restaurantMenus[0].mainMenuStatus eq 'true'}">
								<span class="badge badge-success">메인메뉴</span>
							</c:if>
							<c:if test="${restaurant.restaurantMenus[0].mainMenuStatus eq 'false'}">
								
							</c:if>
						</div>
					</div><br><br>
					
					<div class="row">
		  				<div class="col-xs-4 col-md-2">
							<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-megaphone" viewBox="0 0 16 16">
  							<path d="M13 2.5a1.5 1.5 0 0 1 3 0v11a1.5 1.5 0 0 1-3 0v-.214c-2.162-1.241-4.49-1.843-6.912-2.083l.405 2.712A1 1 0 0 1 5.51 15.1h-.548a1 1 0 0 1-.916-.599l-1.85-3.49a68.14 68.14 0 0 0-.202-.003A2.014 2.014 0 0 1 0 9V7a2.02 2.02 0 0 1 1.992-2.013 74.663 74.663 0 0 0 2.483-.075c3.043-.154 6.148-.849 8.525-2.199V2.5zm1 0v11a.5.5 0 0 0 1 0v-11a.5.5 0 0 0-1 0zm-1 1.35c-2.344 1.205-5.209 1.842-8 2.033v4.233c.18.01.359.022.537.036 2.568.189 5.093.744 7.463 1.993V3.85zm-9 6.215v-4.13a95.09 95.09 0 0 1-1.992.052A1.02 1.02 0 0 0 1 7v2c0 .55.448 1.002 1.006 1.009A60.49 60.49 0 0 1 4 10.065zm-.657.975 1.609 3.037.01.024h.548l-.002-.014-.443-2.966a68.019 68.019 0 0 0-1.722-.082z"/>
							</svg> 음식점 소개글</strong></div>
						<div class="col-xs-8 col-md-10">${restaurant.restaurantText}</div>
					</div><br><br>
					
					<div class="row">
		  				<div class="col-xs-4 col-md-2">
		  				<strong><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar2-week" viewBox="0 0 16 16">
  						<path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM2 2a1 1 0 0 0-1 1v11a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H2z"/>
  						<path d="M2.5 4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5H3a.5.5 0 0 1-.5-.5V4zM11 7.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm-3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm-5 3a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5v-1z"/>
						</svg> 음식점 등록일</strong></div>
						<div class="col-xs-8 col-md-4">${restaurant.restaurantRegDate}</div>
					</div><br><hr>
					
					<div class="text-center">
						<button type="button" class="btn btn-link">삭제하기</button>
						<button type="button" class="btn btn-warning">목록으로</button>
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