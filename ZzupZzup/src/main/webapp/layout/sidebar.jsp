<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- <!-- 실시간 시간 정보 DATA -->
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 a hh:mm:ss");
%>
<!-- 실시간 시간 정보 DATA --> --%>

<!-- 실시간 시간 정보 DATA2  -->
<!-- <script type="text/javascript">
    function showClock()
    {
        var currentDate = new Date();
        var divClock=document.getElementById("divClock");
        var apm = currentDate.getHours();
        
        if(apm<12) {
            apm="오전 ";
        } else {
            apm="오후 ";
        }
        
        var msg = apm +(currentDate.getHours()-12)+"시 ";
        msg += currentDate.getMinutes() + "분 ";
        msg += currentDate.getSeconds() + "초";
        
        divClock.innerText=msg;
        
        setTimeout(showClock,1000);
    }
</script> -->
<!-- 실시간 시간 정보 DATA2  -->

<!-- <body onload="showClock()"> -->

<!-- S:Sidebar -->
<div id="sidebar" class="inactive">
	<div class="inner">
		<!-- Search -->
		<section id="search" class="alt">
			<form method="post" action="#">
				<input type="text" name="query" id="query" placeholder="Search" />
			</form>
		</section>

		<!-- Menu -->
		<nav id="menu">
			<header class="major">
				<h2><strong>Welcome to ZZUPZZUPDUCE_101</strong></h2>
			</header>
			<ul>
				<c:if test="${ ! empty member}">
					<!-- profile image start -->
					<div class="col-md" align="center">
						<c:if test="${sessionScope.member.profileImage == 'defaultImage.png'}">
							<img src="/resources/images/${sessionScope.member.profileImage}"
							class="rounded-circle" width="150" height="150" />
						</c:if>
						<c:if test="${sessionScope.member.profileImage != 'defaultImage.png'}">
							<img src="/resources/images/uploadImages/${sessionScope.member.profileImage}"
							class="rounded-circle" width="150" height="150"/>
						</c:if>
						<br />
						<div class="d-flex justify-content-center">
							<div class="col-md">
								<h4>
								<c:if test="${sessionScope.member.memberRole == 'user'}">
									<span class="badge badge-pill badge-dark"
										style="color:#fff;background-color:#f56a6a;display:inline-block;padding: .25em .4em;padding-right: .6em;
										padding-left: .6em;line-height: 1;">${sessionScope.member.memberRank}</span>&nbsp;
									${sessionScope.member.nickname}
								</c:if>
								<c:if test="${sessionScope.member.memberRole != 'user'}">
									${sessionScope.member.memberName}
								</c:if>
								</h4>
							</div>
						</div>
						<br/>
					</div>
					<!-- profile image end -->
				</c:if>
				
					<c:choose>
						<c:when test="${sessionScope.member.memberRole != 'owner'}">
						<!-- 업주가 아닌 경우 -->
							<c:if test="${sessionScope.member.memberRole == 'user'}">
								<li>
									<span class="opener">MyPage</span>
									<ul>
										<li><a href="/member/getMember?memberId=${member.memberId}">내 정보 조회</a></li>
										<c:if test="${sessionScope.member.memberRole == 'user'}">
											<li><a href="#">내 활동 점수 적립 내역</a></li>
											<li><a href="/review/listReview">내가 작성한 리뷰 내역</a></li>
											<li><a href="#">내가 작성한 게시판 내역</a></li>
											<li><a href="/reservation/listReservation?memberId=${reservation.member.memberId}">예약 및 결제 내역</a></li>
											<li><a href="/review/listMyLikeReview">내가 좋아요 누른 리뷰 내역</a></li>
											<li><a href="#">내가 좋아요 누른 게시물 내역</a></li>
											<li><a href="/report/listReport?memberId=${member.memberId}">나의 신고/제보 접수 내역</a></li>
											<li><a href="#">나의 평가 내역</a></li>
											<li><a href="#">내가 찜한 음식점 내역</a></li>
										</c:if>
									</ul>
								</li>
							</c:if>
							<c:if test="${sessionScope.member.memberRole == 'admin'}">
								<li>
									<span class="opener">Manage Page</span>
									<ul>
										<li><a href="/member/listUser">유저 목록 조회</a></li>
										<li><a href="/member/listOwner">업주 목록 조회</a></li>
										<li><a href="/member/getMember?memberId=user05@zzupzzup.com">회원 정보 조회</a></li>
										<li><a href="/reservation/listReservation?memberId=${reservation.member.memberId}">회원 예약 및 결제 내역</a></li>
										<li><a href="/reservation/listReservation?restaurantNo=${reservation.restaurant.restaurantNo}">업주 예약 주문 내역</a></li>
										<li><a href="/restaurant/listRestaurant">등록된 전체 음식점 목록</a></li>
										<li><a href="/restaurant/listRequestRestaurant">등록 요청 음식점 목록</a></li>
									</ul>
								</li>
							</c:if>
							<li><a href="/chat/listChat">쩝쩝친구 구하기</a></li>
							<li><a href="/community/listCommunity">나만의 작고 소중한 맛집</a></li>
							<c:if test="${sessionScope.member.memberRole == 'admin'}">
								<li>
									<span class="opener">음식점 관리</span>
									<ul>
										<li><a href="/restaurant/listRestaurant">등록된 전체 음식점</a></li>
										<li><a href="/restaurant/listRequestRestaurant">음식점 등록 요청 내역</a></li>
										<li><a href="/review/listReview">전체 리뷰 내역</a></li>
									</ul>
								</li>
							</c:if>
							<li><a href="/restaurant/addRestaurant?memberId=${member.memberId}">test-음식점등록</a></li>
							<li><a href="/review/addReview?reservationNo=1">test-리뷰작성</a></li>
						</c:when>
						<c:otherwise>
							<!--  업주가 보이는 목록 -->
							<li><a href="/member/getMember?memberId=${member.memberId}">내 정보 조회</a></li>
							<li><a href="/reservation/listReservation">예약 주문 내역</a></li>
							<li><a href="/report/listReport?memberId=${member.memberId}">음식점 제보 내역</a></li>
						</c:otherwise>
					</c:choose>
				
				<li><a href="#">>> 공지사항</a></li>
			</ul>
		</nav>

		<!-- Section -->
		<section style="display:none">
			<header class="major">
				<h2>Benchmarking</h2>
			</header>
			<div class="mini-posts">
				
			</div>
			<ul class="actions">
				<li><a href="https://www.diningcode.com/" class="button" target="_blank">More</a></li>
			</ul>
		</section>

		<!-- Section -->
		<section>
			<header class="major">
				<h2><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
				  <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
				  <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z"/>
				</svg> 광고</h2>
			</header>
			<ul class="contact" style="display:none">
				<li class="icon solid fa-envelope"><a href="#">ebeaver@hanmail.net</a></li>
				<li class="icon solid fa-phone">010-4444-4444</li>
				<li class="icon solid fa-home">서울시 종로구 종로 69 서울YMCA</li>
			</ul>
			<!-- <div id="divClock" class="clock"></div> -->
			<a href="https://www.mcdonalds.co.kr/kor/promotion/detail.do?page=1&seq=347&utm_medium=Corp_site&utm_source=Main_cardblock&utm_campaign=1227_Prosperity" target="_black">
				<img alt="mcdonald" src="../resources/images/common/ad.JPG" width="100%">
			</a>
		</section>

		<!-- Footer -->
		<footer id="footer">
			<p class="copyright">&copy; Untitled. All rights reserved. Demo Images: <a href="https://unsplash.com">Unsplash</a>. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
		</footer>

	</div>
</div>
<!--  E:Sidebar -->

<!-- S: Login Modal -->
<jsp:include page="/member/loginView.jsp" />
<!-- E: Login Modal -->
<!-- </body> -->