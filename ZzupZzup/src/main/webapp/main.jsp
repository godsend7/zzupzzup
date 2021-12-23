<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<!--
	Editorial by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Editorial by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		

		<!-- Scripts -->
		<!-- defer :: HTML이 파싱 완료된 후 script 실행 -->
		<script defer src="assets/js/jquery.min.js"></script>
		<script defer src="assets/js/browser.min.js"></script>
		<script defer src="assets/js/breakpoints.min.js"></script>
		<script defer src="assets/js/util.js"></script>
		<script defer src="assets/js/main.js"></script>
		
		<script defer type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=7gzdb36t5o"></script>
		<!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=7gzdb36t5o&callback=CALLBACK_FUNCTION"></script> -->
		<script>
			window.onload = function() {
				
				var HOME_PATH = window.HOME_PATH || '.';
				console.log(HOME_PATH);
				var cityhall = new naver.maps.LatLng(37.5666805, 126.9784147),
				    map = new naver.maps.Map('content', {
				        center: cityhall,
				        zoom: 15
				    }),
				    marker = new naver.maps.Marker({
				        map: map,
				        position: cityhall
				    });

				var contentString = [
				        '<div class="iw_inner">',
				        '   <h3>서울특별시청</h3>',
				        '   <p>서울특별시 중구 태평로1가 31 | 서울특별시 중구 세종대로 110 서울특별시청<br />',
				        '       <img src="'+ HOME_PATH +'/img/example/hi-seoul.jpg" width="55" height="55" alt="서울시청" class="thumb" /><br />',
				        '       02-120 | 공공,사회기관 &gt; 특별,광역시청<br />',
				        '       <a href="http://www.seoul.go.kr" target="_blank">www.seoul.go.kr/</a>',
				        '   </p>',
				        '</div>'
				    ].join('');

				var infowindow = new naver.maps.InfoWindow({
				    content: contentString,
				    maxWidth: 140,
				    backgroundColor: "#eee",
				    borderColor: "#2db400",
				    borderWidth: 5,
				    anchorSize: new naver.maps.Size(30, 30),
				    anchorSkew: true,
				    anchorColor: "#eee",
				    pixelOffset: new naver.maps.Point(20, -20)
				});

				naver.maps.Event.addListener(marker, "click", function(e) {
				    if (infowindow.getMap()) {
				        infowindow.close();
				    } else {
				        infowindow.open(map, marker);
				    }
				});
				
				
				
				$(function() {
					$.ajax(
						{
							url : "https://openapi.gg.go.kr/PlaceThatDoATasteyFoodSt?KEY=0584ed7e427d4676a15a4bf7f91b1597&Type=json&pIndex=1&pSize=10",
		    				type : "GET",
		    				dataType : "json",
		    				success : function(data, status) {
		    					alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(data) );
		    					console.log(JSON.stringify(data));
		    					alert(status);
								alert("data : \n"+data);
		    				},
		    				error:function(request,status,error){
		 				       console.log("실패");
		 				    }
						}
					)
							
				});
			}
		</script>
	</head>
	<body class="is-preload">

		<!-- Wrapper -->
		<div id="wrapper">

			<!-- Main -->
			<div id="main">
				<div class="inner">

					<!-- Header -->
					<header id="header">
						<a href="index.html" class="logo"><strong>Editorial</strong> by HTML5 UP</a>
						<ul class="icons">
							<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
							<li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
							<li><a href="#" class="icon brands fa-snapchat-ghost"><span class="label">Snapchat</span></a></li>
							<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
							<li><a href="#" class="icon brands fa-medium-m"><span class="label">Medium</span></a></li>
						</ul>
					</header>

					<!-- Banner -->
					<section id="banner">
						<div class="content" id="content" style="width: 100%; height:400px;"></div>
					</section>

					<!-- Section -->
	<!-- 			<section>
						<header class="major">
							<h2>Erat lacinia</h2>
						</header>
						<div class="features">
							<article>
								<span class="icon fa-gem"></span>
								<div class="content">
									<h3>Portitor ullamcorper</h3>
									<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
								</div>
							</article>
							<article>
								<span class="icon solid fa-paper-plane"></span>
								<div class="content">
									<h3>Sapien veroeros</h3>
									<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
								</div>
							</article>
							<article>
								<span class="icon solid fa-rocket"></span>
								<div class="content">
									<h3>Quam lorem ipsum</h3>
									<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
								</div>
							</article>
							<article>
								<span class="icon solid fa-signal"></span>
								<div class="content">
									<h3>Sed magna finibus</h3>
									<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
								</div>
							</article>
						</div>
					</section>

				Section
					<section>
						<header class="major">
							<h2>Ipsum sed dolor</h2>
						</header>
						<div class="posts">
							<article>
								<a href="#" class="image"><img src="images/pic01.jpg" alt="" /></a>
								<h3>Interdum aenean</h3>
								<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
								<ul class="actions">
									<li><a href="#" class="button">More</a></li>
								</ul>
							</article>
							<article>
								<a href="#" class="image"><img src="images/pic02.jpg" alt="" /></a>
								<h3>Nulla amet dolore</h3>
								<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
								<ul class="actions">
									<li><a href="#" class="button">More</a></li>
								</ul>
							</article>
							<article>
								<a href="#" class="image"><img src="images/pic03.jpg" alt="" /></a>
								<h3>Tempus ullamcorper</h3>
								<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
								<ul class="actions">
									<li><a href="#" class="button">More</a></li>
								</ul>
							</article>
							<article>
								<a href="#" class="image"><img src="images/pic04.jpg" alt="" /></a>
								<h3>Sed etiam facilis</h3>
								<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
								<ul class="actions">
									<li><a href="#" class="button">More</a></li>
								</ul>
							</article>
							<article>
								<a href="#" class="image"><img src="images/pic05.jpg" alt="" /></a>
								<h3>Feugiat lorem aenean</h3>
								<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
								<ul class="actions">
									<li><a href="#" class="button">More</a></li>
								</ul>
							</article>
							<article>
								<a href="#" class="image"><img src="images/pic06.jpg" alt="" /></a>
								<h3>Amet varius aliquam</h3>
								<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore. Proin aliquam facilisis ante interdum. Sed nulla amet lorem feugiat tempus aliquam.</p>
								<ul class="actions">
									<li><a href="#" class="button">More</a></li>
								</ul>
							</article>
						</div>
					</section> -->
				</div>
			</div>

			<!-- Sidebar -->
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
							<li><a href="index.html">Homepage</a></li>
							<li><a href="generic.html">Generic</a></li>
							<li><a href="elements.html">Elements</a></li>
							<li>
								<span class="opener">Submenu</span>
								<ul>
									<li><a href="#">Lorem Dolor</a></li>
									<li><a href="#">Ipsum Adipiscing</a></li>
									<li><a href="#">Tempus Magna</a></li>
									<li><a href="#">Feugiat Veroeros</a></li>
								</ul>
							</li>
							<li><a href="#">Etiam Dolore</a></li>
							<li><a href="#">Adipiscing</a></li>
							<li>
								<span class="opener">Another Submenu</span>
								<ul>
									<li><a href="#">Lorem Dolor</a></li>
									<li><a href="#">Ipsum Adipiscing</a></li>
									<li><a href="#">Tempus Magna</a></li>
									<li><a href="#">Feugiat Veroeros</a></li>
								</ul>
							</li>
							<li><a href="#">Maximus Erat</a></li>
							<li><a href="#">Sapien Mauris</a></li>
							<li><a href="#">Amet Lacinia</a></li>
						</ul>
					</nav>
	
					<!-- Section -->
					<section>
						<header class="major">
							<h2>Ante interdum</h2>
						</header>
						<div class="mini-posts">
							<article>
								<a href="#" class="image"><img src="images/pic07.jpg" alt="" /></a>
								<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore aliquam.</p>
							</article>
							<article>
								<a href="#" class="image"><img src="images/pic08.jpg" alt="" /></a>
								<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore aliquam.</p>
							</article>
							<article>
								<a href="#" class="image"><img src="images/pic09.jpg" alt="" /></a>
								<p>Aenean ornare velit lacus, ac varius enim lorem ullamcorper dolore aliquam.</p>
							</article>
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
		</div>
	</body>
</html>