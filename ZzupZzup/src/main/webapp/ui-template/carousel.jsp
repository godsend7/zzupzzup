<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/layout/toolbar.jsp" />

<div class="container">

	<div id="myCarousel" class="carousel slide" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class=""></li>
			<li data-target="#myCarousel" data-slide-to="1" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="2" class=""></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active carousel-item-left">
				<svg class="bd-placeholder-img" width="100%" height="100%"
					xmlns="http://www.w3.org/2000/svg" role="img" aria-label=" :  "
					preserveAspectRatio="xMidYMid slice" focusable="false">
					<title> </title><rect width="100%" height="100%" fill="#777"></rect>
					<text x="50%" y="50%" fill="#777" dy=".3em"> </text></svg>

				<div class="container">
					<div class="carousel-caption text-left">
						<h1>Example headline.</h1>
						<p>Some representative placeholder content for the first slide
							of the carousel.</p>
						<p>
							<a class="btn btn-lg btn-primary" href="#">Sign up today</a>
						</p>
					</div>
				</div>
			</div>
			<div class="carousel-item carousel-item-next carousel-item-left">
				<svg class="bd-placeholder-img" width="100%" height="100%"
					xmlns="http://www.w3.org/2000/svg" role="img" aria-label=" :  "
					preserveAspectRatio="xMidYMid slice" focusable="false">
					<title> </title><rect width="100%" height="100%" fill="#777"></rect>
					<text x="50%" y="50%" fill="#777" dy=".3em"> </text></svg>

				<div class="container">
					<div class="carousel-caption">
						<h1>Another example headline.</h1>
						<p>Some representative placeholder content for the second
							slide of the carousel.</p>
						<p>
							<a class="btn btn-lg btn-primary" href="#">Learn more</a>
						</p>
					</div>
				</div>
			</div>
			<div class="carousel-item">
				<svg class="bd-placeholder-img" width="100%" height="100%"
					xmlns="http://www.w3.org/2000/svg" role="img" aria-label=" :  "
					preserveAspectRatio="xMidYMid slice" focusable="false">
					<title> </title><rect width="100%" height="100%" fill="#777"></rect>
					<text x="50%" y="50%" fill="#777" dy=".3em"> </text></svg>

				<div class="container">
					<div class="carousel-caption text-right">
						<h1>One more for good measure.</h1>
						<p>Some representative placeholder content for the third slide
							of this carousel.</p>
						<p>
							<a class="btn btn-lg btn-primary" href="#">Browse gallery</a>
						</p>
					</div>
				</div>
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-target="#myCarousel" data-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="sr-only">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-target="#myCarousel" data-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="sr-only">Next</span>
		</button>
	</div>

</div>

<jsp:include page="/layout/sidebar.jsp" />