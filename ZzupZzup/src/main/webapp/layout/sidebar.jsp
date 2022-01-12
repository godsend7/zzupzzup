<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- <script type="text/javascript">

	var imgArray = new Array();
	imgArray[0] = "../resources/images/common/ad1.JPG";
	imgArray[1] = "../resources/images/common/ad2.JPG";
	imgArray[2] = "../resources/images/common/ad3.JPG";
	imgArray[3] = "../resources/images/common/ad4.JPG";
	
	function showAd() {
		var imgNum = Math.round(Math.random() * 3);
		var objImg = document.getElementById("adImgs");
		objImg.src = imgArray[imgNum];
	}

</script> -->

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
<!-- <body> -->
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
				<c:if test="${ empty member}">
					<div style="text-align : center;">
						<img src="/favicon.ico" width="150" height="150" />
					</div>
					<div style="text-align : center; color: hotpink;">
						더 많은 서비스를 이용하시려면
					</div>
					<div style="text-align : center; color: hotpink;">
						로그인 해주세요
					</div><br>
				</c:if>
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
									<c:if test="${sessionScope.member.memberRole == 'owner'}">
										<span class="badge badge-pill badge-dark"
											style="color:#fff;background-color:#bfbfbf;display:inline-block;padding: .25em .4em;padding-right: .6em;
											padding-left: .6em;line-height: 1;">업주</span>&nbsp;
									</c:if>
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
											<li><a href="/member/listMyActivityScore?memberId=${member.memberId}">내 활동 점수 적립 내역</a></li>
											<li><a href="/review/listReview">내가 작성한 리뷰 내역</a></li>
											<li><a href="#">내가 작성한 게시판 내역</a></li>
											<li><a href="/reservation/listReservation">나의 예약 및 결제 내역</a></li>
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
										<li><a href="/reservation/listReservation">예약/주문 및 결제 내역</a></li>
										<li><a href="/restaurant/listRestaurant">등록된 전체 음식점</a></li>
										<li><a href="/restaurant/listRequestRestaurant">음식점 등록 요청 내역</a></li>
										<li><a href="/review/listReview">전체 리뷰 관리</a></li>
										<li><a href="/report/listReport">신고/제보 관리</a></li>
									</ul>
								</li>
							</c:if>
							<li><a href="/chat/listChat">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-people-fill" viewBox="0 0 16 16">
							  <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
							  <path fill-rule="evenodd" d="M5.216 14A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216z"/>
							  <path d="M4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5z"/>
							</svg> 쩝쩝친구 구하기</a></li>
							<li><a href="/community/listCommunity">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cup-straw" viewBox="0 0 16 16">
							  <path d="M13.902.334a.5.5 0 0 1-.28.65l-2.254.902-.4 1.927c.376.095.715.215.972.367.228.135.56.396.56.82 0 .046-.004.09-.011.132l-.962 9.068a1.28 1.28 0 0 1-.524.93c-.488.34-1.494.87-3.01.87-1.516 0-2.522-.53-3.01-.87a1.28 1.28 0 0 1-.524-.93L3.51 5.132A.78.78 0 0 1 3.5 5c0-.424.332-.685.56-.82.262-.154.607-.276.99-.372C5.824 3.614 6.867 3.5 8 3.5c.712 0 1.389.045 1.985.127l.464-2.215a.5.5 0 0 1 .303-.356l2.5-1a.5.5 0 0 1 .65.278zM9.768 4.607A13.991 13.991 0 0 0 8 4.5c-1.076 0-2.033.11-2.707.278A3.284 3.284 0 0 0 4.645 5c.146.073.362.15.648.222C5.967 5.39 6.924 5.5 8 5.5c.571 0 1.109-.03 1.588-.085l.18-.808zm.292 1.756C9.445 6.45 8.742 6.5 8 6.5c-1.133 0-2.176-.114-2.95-.308a5.514 5.514 0 0 1-.435-.127l.838 8.03c.013.121.06.186.102.215.357.249 1.168.69 2.438.69 1.27 0 2.081-.441 2.438-.69.042-.029.09-.094.102-.215l.852-8.03a5.517 5.517 0 0 1-.435.127 8.88 8.88 0 0 1-.89.17zM4.467 4.884s.003.002.005.006l-.005-.006zm7.066 0-.005.006c.002-.004.005-.006.005-.006zM11.354 5a3.174 3.174 0 0 0-.604-.21l-.099.445.055-.013c.286-.072.502-.149.648-.222z"/>
							</svg> 나만의 작고 소중한 맛집</a></li>
						</c:when>
						<c:otherwise>
							<!--  업주가 보이는 목록 -->
							<li><a href="/member/getMember?memberId=${member.memberId}">내 정보 조회</a></li>
							<li><a href="/reservation/listMyReservation">예약 주문 내역</a></li>
							<li><a href="/report/listReport?memberId=${member.memberId}">음식점 제보 내역</a></li>
						</c:otherwise>
					</c:choose>
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
				<img alt="mcdonald" src="../resources/images/common/ad1.JPG" width="100%">
			</a>
			<!-- <img id = "adImgs" width="100%" border="0"> -->
		</section>

		<!-- Footer -->
		<footer id="footer">
			<p class="copyright">&copy; ZZUPZZUPDUCE_101. All rights reserved. Demo Images | <a href="https://unsplash.com">Unsplash</a>. Design | <a href="https://html5up.net">HTML5 UP</a>.</p>
		</footer>

	</div>
</div>
<!--  E:Sidebar -->

<!-- S: Login Modal -->
<jsp:include page="/member/modal-archive.jsp" />
<!-- E: Login Modal -->
<!-- </body> -->
<!-- </body> -->