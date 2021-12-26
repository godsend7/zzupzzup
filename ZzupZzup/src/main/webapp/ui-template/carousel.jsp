<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/layout/toolbar.jsp" />

<!-- start:해당 부분은 지우고 아래 container안에 작성 -->
<div class="row">
	<div class="col-12">
		<ul>
			<li><a href="/ui-template/basic-template.jsp">기본 템플릿</a></li>
			<li><a href="/ui-template/button.jsp">버튼</a></li>
			<li><a href="/ui-template/form.jsp">등록양식</a></li>
			<li><a href="/ui-template/form-view.jsp">등록양식 결과</a></li>
			<li><a href="/ui-template/thumbnail.jsp">썸네일리스트</a></li>
			<li><a href="/ui-template/list.jsp">일반리스트</a></li>
			<li><a href="/ui-template/carousel.jsp">슬라이드</a></li>
			<li><a href="/ui-template/table.jsp">테이블</a></li>
			<li><a href="/ui-template/etc-ui.jsp">기타ui</a></li>
		</ul>
	</div>
</div>
<!-- end -->

<div class="container">

	<div class="bd-example">
		<div id="carouselExampleIndicators" class="carousel slide"
			data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#carouselExampleIndicators" data-slide-to="0"
					class=""></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="1"
					class=""></li>
				<li data-target="#carouselExampleIndicators" data-slide-to="2"
					class="active"></li>
			</ol>
			<div class="carousel-inner">
				<div class="carousel-item">
					<svg class="bd-placeholder-img bd-placeholder-img-lg d-block w-100"
						width="100%" height="400" xmlns="http://www.w3.org/2000/svg"
						role="img" aria-label="Placeholder: First slide"
						preserveAspectRatio="xMidYMid slice" focusable="false">
						<title>Placeholder</title><rect width="100%" height="100%"
							fill="#777"></rect>
						<text x="50%" y="50%" fill="#555" dy=".3em">First slide</text></svg>

				</div>
				<div class="carousel-item">
					<svg class="bd-placeholder-img bd-placeholder-img-lg d-block w-100"
						width="100%" height="400" xmlns="http://www.w3.org/2000/svg"
						role="img" aria-label="Placeholder: Second slide"
						preserveAspectRatio="xMidYMid slice" focusable="false">
						<title>Placeholder</title><rect width="100%" height="100%"
							fill="#666"></rect>
						<text x="50%" y="50%" fill="#444" dy=".3em">Second slide</text></svg>

				</div>
				<div class="carousel-item active">
					<svg class="bd-placeholder-img bd-placeholder-img-lg d-block w-100"
						width="100%" height="400" xmlns="http://www.w3.org/2000/svg"
						role="img" aria-label="Placeholder: Third slide"
						preserveAspectRatio="xMidYMid slice" focusable="false">
						<title>Placeholder</title><rect width="100%" height="100%"
							fill="#555"></rect>
						<text x="50%" y="50%" fill="#333" dy=".3em">Third slide</text></svg>

				</div>
			</div>
			<a class="carousel-control-prev" 
				data-target="#carouselExampleIndicators" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a>
			<a class="carousel-control-next"
				data-target="#carouselExampleIndicators" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>

</div>

<jsp:include page="/layout/sidebar.jsp" />