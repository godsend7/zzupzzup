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
				<li><a href="#">쩝쩝친구 구하기</a></li>
				<li><a href="/community/listCommunity">나만의 작고 소중한 맛집</a></li>
				<li><a href="/community/addCommunity">test-나만의 작고 소중한 맛집(add)</a></li>
				<li><a href="#">공지사항</a></li>
				<li><a href="/restaurant/addRestaurant">test-음식점</a></li>
				<li><a href="/restaurant/listRestaurant">test-(관리자)음식점목록</a></li>
				
			</ul>
		</nav>

		<!-- Section -->
		<section>
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
				<h2>mom's touch</h2>
			</header>
			<p>종각역 4번출구 전방 30미터 이내 2층</p>
			<ul class="contact">
				<li class="icon solid fa-envelope"><a href="#">ebeaver@hanmail.net</a></li>
				<li class="icon solid fa-phone">010-4444-4444</li>
				<li class="icon solid fa-home">서울시 종로구 종로 69 서울YMCA</li>
			</ul>
		</section>

		<!-- Footer -->
		<footer id="footer">
			<p class="copyright">&copy; Untitled. All rights reserved. Demo Images: <a href="https://unsplash.com">Unsplash</a>. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
		</footer>

	</div>
</div>
<!--  E:Sidebar -->