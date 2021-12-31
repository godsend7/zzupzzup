<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML>

<html>
<head>
<title>ZZUPZZUP-template</title>

<jsp:include page="/layout/toolbar.jsp" />

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		console.log("template.jsp");
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

				<!-- start:해당 부분은 지우고 아래 container안에 작성 -->
				<div class="row">
					<div class="col-12">
						<ul style="display: flex; list-style: none;">
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

				<section id="button">

					<div class="container">

						<!-- Buttons -->
						<h3>Buttons</h3>
						<h5>버튼 크기</h5>
						<ul class="actions">
							<li><a href="#" class="button large">Large</a></li>
							<li><a href="#" class="button">Default</a></li>
							<li><a href="#" class="button small">Small</a></li>
						</ul>
						<h5>버튼 색깔</h5>
						<ul class="actions">
							<li><a href="#" class="button primary">Primary</a></li>
							<li><a href="#" class="button">Default</a></li>
							<li><a href="#" class="button normal">normal</a></li>
							<li><a href="#" class="button secondary">secondary</a></li>
							<li><a href="#" class="button success">success</a></li>
							<li><a href="#" class="button danger">danger</a></li>
							<li><a href="#" class="button warning">warning</a></li>
							<li><a href="#" class="button info">info</a></li>
						</ul>

						<ul class="actions">
							<li><a href="#" class="button primary large">Large</a></li>
							<li><a href="#" class="button primary">Default</a></li>
							<li><a href="#" class="button primary small">Small</a></li>
						</ul>
						<h5>100% 넓이 버튼</h5>
						<ul class="actions fit">
							<li><a href="#" class="button primary fit">Fit</a></li>
							<li><a href="#" class="button fit">Fit</a></li>
						</ul>
						<ul class="actions fit small">
							<li><a href="#" class="button primary fit small">Fit +
									Small</a></li>
							<li><a href="#" class="button fit small">Fit + Small</a></li>
						</ul>
						<h5>아이콘 들어간 버튼</h5>
						<ul class="actions">
							<li><a href="#" class="button primary icon solid fa-search">Icon</a></li>
							<li><a href="#" class="button icon solid fa-download">Icon</a></li>
						</ul>
						<h5>아이콘 들어간 버튼 SVG</h5>
						<ul class="actions">
							<li><a href="#" class="button svg-btn"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
</svg>작성하기</a></li>
						</ul>
						<ul class="actions">
							<li><span class="button primary disabled">Primary</span></li>
							<li><span class="button disabled">Default</span></li>
						</ul>
						<h5>input 버튼</h5>
						<ul class="actions">
							<li><input type="submit" value="Send Message"
								class="primary"></li>
							<li><input type="button" value="List" class="secondary"></li>
							<li><input type="reset" value="Reset"></li>
						</ul>
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