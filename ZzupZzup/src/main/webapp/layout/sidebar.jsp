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
											<li><a href="/review/listReview?memberId=${member.memberId}">내가 작성한 리뷰 내역</a></li>
											<li><a href="#">내가 작성한 게시판 내역</a></li>
											<li><a href="/reservation/listReservation?memberId=${reservation.member.memberId}">예약 및 결제 내역</a></li>
											<li><a href="/review/listMyLikeReview?memberId=${member.memberId}">내가 좋아요 누른 리뷰 내역</a></li>
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
										<li><a href="/member/listMember">회원 목록 조회</a></li>
										<li><a href="/member/getMember?memberId=user05@zzupzzup.com">회원 정보 조회</a></li>
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
										<li><a href="#">전체 음식점 내역</a></li>
										<li><a href="/restaurant/listRequestRestaurant">음식점 등록 요청 내역</a></li>
										<li><a href="/review/listReview">전체 리뷰 내역</a></li>
									</ul>
								</li>
							</c:if>
							<li><a href="/restaurant/addRestaurant?memberId=${member.memberId}">test-음식점등록</a></li>
							<li><a href="/review/addReview?reservationNo=1">test-리뷰작성</a></li>
							<li><a href="/reservation/addReservation?chatNo=${reservation.chat.chatNo}">test-예약</a></li>
						</c:when>
						<c:otherwise>
							<!--  업주가 보이는 목록 -->
							<li><a href="/member/getMember?memberId=${member.memberId}">내 정보 조회</a></li>
							<li><a href="/reservation/listReservation?restaurantNo=1">예약 주문 내역</a></li>
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
				<h2><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-alarm" viewBox="0 0 16 16">
				  <path d="M8.5 5.5a.5.5 0 0 0-1 0v3.362l-1.429 2.38a.5.5 0 1 0 .858.515l1.5-2.5A.5.5 0 0 0 8.5 9V5.5z"/>
				  <path d="M6.5 0a.5.5 0 0 0 0 1H7v1.07a7.001 7.001 0 0 0-3.273 12.474l-.602.602a.5.5 0 0 0 .707.708l.746-.746A6.97 6.97 0 0 0 8 16a6.97 6.97 0 0 0 3.422-.892l.746.746a.5.5 0 0 0 .707-.708l-.601-.602A7.001 7.001 0 0 0 9 2.07V1h.5a.5.5 0 0 0 0-1h-3zm1.038 3.018a6.093 6.093 0 0 1 .924 0 6 6 0 1 1-.924 0zM0 3.5c0 .753.333 1.429.86 1.887A8.035 8.035 0 0 1 4.387 1.86 2.5 2.5 0 0 0 0 3.5zM13.5 1c-.753 0-1.429.333-1.887.86a8.035 8.035 0 0 1 3.527 3.527A2.5 2.5 0 0 0 13.5 1z"/>
				</svg> 현재 시간</h2>
			</header>
			<ul class="contact" style="display:none">
				<li class="icon solid fa-envelope"><a href="#">ebeaver@hanmail.net</a></li>
				<li class="icon solid fa-phone">010-4444-4444</li>
				<li class="icon solid fa-home">서울시 종로구 종로 69 서울YMCA</li>
			</ul>
			<!-- <div id="divClock" class="clock"></div> -->
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