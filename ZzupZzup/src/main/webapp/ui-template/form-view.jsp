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

				<section id="">
					<div class="container">

						<!-- start:Form -->
						<h3>Form</h3>

						<form method="post" action="#">
							<div class="row gtr-uniform">
								<div class="col-4 col-12-xsmall">
									<label for="demo-name">Name</label>
									<p>모시기 모시기</p>
								</div>
								<div class="col-8 col-12-xsmall">
									<label for="demo-email">Email</label>
									<p>모시기 모시기</p>
								</div>
								<!-- Break -->
								<div class="col-4 col-12-small">
									<label for="demo-name2">Name</label>
									<p>모시기 모시기</p>
								</div>
								<div class="col-4 col-12-small">
									<label for="demo-email2">Email</label>
									<p>모시기 모시기</p>
								</div>
								<div class="col-4 col-12-small">
									<label for="demo-email3">Email</label>
									<p>모시기 모시기</p>
								</div>
								<!-- Break -->
								<div class="col-12">
									<label for="demo-category">Category</label>
									<p>모시기 모시기</p>
								</div>
								<!-- Break -->
								<div class="col-12">
									<label for="demo-priority">Radio</label>
									<p>라디오</p>
								</div>
								<!-- Break -->
								<div class="col-12">
									<label for="demo-copy">Check</label>
									<p>체크, 체크, 체크</p>
								</div>
								<!-- Break -->
								<div class="col-12">
									<label for="demo-message">Message</label>
									<p>메세지메세지 메세지메세지 메세지메세지 메세지메세지 메세지메세지 메세지메세지 메세지메세지 메세지메세지
										메세지메세지 메세지메세지 메세지메세지 메세지메세지 메세지메세지 메세지메세지 메세지메세지 메세지메세지 메세지메세지
										메세지메세지 메세지메세지 메세지메세지</p>
								</div>
								<!-- Break -->
								<div class="col-12">
									<ul class="actions">
										<li><input type="submit" value="Send Message"
											class="primary" /></li>
										<li><input type="reset" value="Reset" class="normal" /></li>
									</ul>
								</div>
							</div>
						</form>
						<!-- end -->

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