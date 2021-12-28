<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
				<h2>Menu</h2>
			</header>
			<ul>
				<c:if test="${ ! empty member}">
					<c:if test="${sessionScope.member.memberRole == 'user'}">
					<li>
						<span class="opener">MyPage</span>
						<ul>
							<li><a href="#">내 정보 조회</a></li>
							<li><a href="#">내 활동 점수 적립 내역</a></li>
							<li><a href="#">내가 작성한 리뷰 내역</a></li>
							<li><a href="#">내가 작성한 게시판 내역</a></li>
							<li><a href="/reservation/addReservation">예약 및 결제 내역</a></li>
							<li><a href="#">내가 좋아요 누른 리뷰 내역</a></li>
							<li><a href="#">내가 좋아요 누른 게시물 내역</a></li>
							<li><a href="#">나의 신고/제보 접수 내역</a></li>
							<li><a href="#">나의 평가 내역</a></li>
							<li><a href="#">내가 찜한 음식점 내역</a></li>
						</ul>
					</li>
					</c:if>
					<li><a href="#">쩝쩝친구 구하기</a></li>
					<li><a href="#">나만의 작고 소중한 맛집</a></li>
				</c:if>
				<li><a href="#">공지사항</a></li>
				<li><a href="#">test-음식점</a></li>
			</ul>
		</nav>

		<!-- Section -->
		<section>
			<header class="major">
				<h2>Ante interdum</h2>
			</header>
			<div class="mini-posts">
				
			</div>
			<ul class="actions">
				<li><a href="#" class="button">More</a></li>
			</ul>
		</section>

		<!-- Section -->
		<section>
			<header class="major">
				<h2>Get in touch</h2>
			</header>
			<p>Sed varius enim lorem ullamcorper dolore aliquam aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin sed aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
			<ul class="contact">
				<li class="icon solid fa-envelope"><a href="#">information@untitled.tld</a></li>
				<li class="icon solid fa-phone">(000) 000-0000</li>
				<li class="icon solid fa-home">1234 Somewhere Road #8254<br />
				Nashville, TN 00000-0000</li>
			</ul>
		</section>

		<!-- Footer -->
		<footer id="footer">
			<p class="copyright">&copy; Untitled. All rights reserved. Demo Images: <a href="https://unsplash.com">Unsplash</a>. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
		</footer>

	</div>
</div>
<!--  E:Sidebar -->